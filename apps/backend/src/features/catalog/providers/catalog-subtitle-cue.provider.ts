import { Inject, Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { SubtitleFormat as PrismaSubtitleFormat } from '@prisma/client';

import {
  NotFoundDomainError,
  ServiceUnavailableDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';
import { SubtitleParserService } from 'features/subtitles/utils/subtitle-parser.service';

import {
  CATALOG_SUBTITLE_FILE_PROVIDERS,
  CatalogSubtitleFileProvider,
} from 'features/catalog/ports/catalog-subtitle-file-provider.port';
import {
  MEDIA_CATALOG_PORT,
  MediaCatalogPort,
} from 'features/catalog/ports/media-catalog.port';
import { SubtitleCuePort } from 'features/catalog/ports/subtitle-cue.port';
import {
  detectSubtitleFormat,
  isZipArchive,
  rankArchiveEntries,
  unzipToEntries,
} from 'features/catalog/utils/subtitle-archive.util';
import { decodeSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';

@Injectable()
export class CatalogSubtitleCueProvider implements SubtitleCuePort {
  private readonly logger = new Logger(CatalogSubtitleCueProvider.name);

  constructor(
    private readonly configService: ConfigService,
    private readonly subtitleParserService: SubtitleParserService,
    @Inject(MEDIA_CATALOG_PORT)
    private readonly mediaCatalogPort: MediaCatalogPort,
    @Inject(CATALOG_SUBTITLE_FILE_PROVIDERS)
    private readonly fileProviders: CatalogSubtitleFileProvider[],
  ) {}

  async getSubtitleCues(
    mediaId: string,
    subtitleSourceId: string,
  ): Promise<SubtitleCue[]> {
    const media = await this.mediaCatalogPort.findById(mediaId);
    if (!media) {
      throw new NotFoundDomainError(
        'The requested media title was not found.',
        undefined,
        {
          key: 'errors.translation.media_not_found',
        },
      );
    }

    const decoded = decodeSubtitleSourceId(subtitleSourceId);
    const provider = this.fileProviders.find(
      (candidate) => candidate.provider === decoded.provider,
    );
    if (!provider) {
      throw new ServiceUnavailableDomainError(
        'Subtitle sources are temporarily unavailable for this title.',
        undefined,
        {
          key: 'errors.catalog.subtitles_unavailable',
        },
      );
    }

    try {
      const payload = await provider.downloadSubtitleFile({
        provider: decoded.provider,
        providerSubtitleId: decoded.providerSubtitleId,
      });

      return this.parseDownloadedPayload(payload);
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Unknown error';
      this.logger.warn(
        `Catalog subtitle download failed for ${subtitleSourceId}: ${message}`,
      );

      throw new ServiceUnavailableDomainError(
        'Subtitle sources are temporarily unavailable for this title.',
        undefined,
        {
          key: 'errors.catalog.subtitles_unavailable',
        },
      );
    }
  }

  private parseDownloadedPayload(payload: {
    bytes: Buffer;
    fileName?: string;
    contentType?: string;
  }): SubtitleCue[] {
    const maxZipExtractBytes =
      this.configService.get<number>('subtitleSources.zipMaxExtractedBytes') ??
      10 * 1024 * 1024;

    if (
      (payload.fileName?.toLowerCase().endsWith('.zip') ?? false) ||
      isZipArchive(payload.bytes)
    ) {
      const entries = unzipToEntries(payload.bytes, {
        maxTotalUncompressedBytes: maxZipExtractBytes,
      });

      for (const entry of rankArchiveEntries(entries)) {
        const format =
          detectSubtitleFormat({
            fileName: entry.fileName,
            contentBytes: entry.bytes,
          }) ?? null;

        if (!format) {
          continue;
        }

        const cues = this.tryParse(entry.bytes, format);
        if (cues) {
          return cues;
        }
      }

      throw new ValidationDomainError(
        'The subtitle file did not contain valid cues.',
        undefined,
        {
          key: 'errors.subtitles.no_valid_cues',
        },
      );
    }

    const format =
      detectSubtitleFormat({
        fileName: payload.fileName,
        contentType: payload.contentType,
        contentBytes: payload.bytes,
      }) ?? null;

    if (!format) {
      throw new ValidationDomainError(
        'Unsupported file type. Only .srt and .vtt files are accepted.',
        undefined,
        {
          key: 'errors.subtitles.unsupported_file_type',
        },
      );
    }

    const cues = this.tryParse(payload.bytes, format);
    if (!cues) {
      throw new ValidationDomainError(
        'The subtitle file did not contain valid cues.',
        undefined,
        {
          key: 'errors.subtitles.no_valid_cues',
        },
      );
    }

    return cues;
  }

  private tryParse(
    bytes: Buffer,
    format: SubtitleFormat,
  ): SubtitleCue[] | null {
    try {
      // The parser currently uses Prisma's SubtitleFormat enum. Values align with our domain enum.
      return this.subtitleParserService.parse({
        content: bytes.toString('utf8'),
        format: format as PrismaSubtitleFormat,
      });
    } catch {
      return null;
    }
  }
}
