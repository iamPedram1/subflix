import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppLanguage, ClientDevice, SubtitleFormat } from '@prisma/client';
import { createHash } from 'node:crypto';
import { extname } from 'node:path';

import { ValidationDomainError } from 'src/common/domain/errors/domain.error';

import { SubtitleCue } from './models/subtitle-cue.model';
import { SubtitlesRepository } from './subtitles.repository';
import { DEFAULT_MAX_UPLOAD_BYTES } from './subtitle-upload.constants';
import { SubtitleParserService } from './utils/subtitle-parser.service';

@Injectable()
/** Validates, parses, and persists uploaded subtitle files for device-scoped workflows. */
export class SubtitlesService {
  constructor(
    private readonly configService: ConfigService,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly subtitleParserService: SubtitleParserService,
  ) {}

  /** Parses an uploaded `.srt` or `.vtt` file and stores its normalized cue set. */
  async parseAndStore(device: ClientDevice, file?: Express.Multer.File) {
    const upload = this.requireFile(file);
    this.assertWithinUploadLimit(upload);

    const format = this.resolveFormat(upload.originalname);
    const rawContent = upload.buffer.toString('utf8');
    const cues = this.subtitleParserService.parse({
      content: rawContent,
      format,
    });

    const parsedFile = await this.subtitlesRepository.createParsedFile({
      clientDeviceId: device.id,
      fileName: upload.originalname,
      format,
      sourceLanguage: AppLanguage.en,
      lineCount: cues.length,
      durationMs: this.getDurationMs(cues),
      checksum: createHash('sha256').update(upload.buffer).digest('hex'),
      rawContent,
      cues,
    });

    return {
      id: parsedFile.id,
      fileName: parsedFile.fileName,
      format: parsedFile.format,
      sourceLanguage: parsedFile.sourceLanguage,
      lineCount: parsedFile.lineCount,
      durationMs: parsedFile.durationMs,
    };
  }

  /** Ensures the upload route always receives a file payload. */
  private requireFile(file?: Express.Multer.File): Express.Multer.File {
    if (!file) {
      throw new ValidationDomainError('A subtitle file is required.');
    }

    return file;
  }

  /** Applies the configured upload size limit before parsing the file. */
  private assertWithinUploadLimit(file: Express.Multer.File): void {
    const maxUploadBytes =
      this.configService.get<number>('app.maxUploadBytes') ??
      DEFAULT_MAX_UPLOAD_BYTES;

    if (file.size > maxUploadBytes) {
      throw new ValidationDomainError(
        'Subtitle file exceeds the upload limit.',
        {
          maxUploadBytes,
        },
      );
    }
  }

  /** Resolves the subtitle format from the uploaded filename extension. */
  private resolveFormat(fileName: string): SubtitleFormat {
    const extension = extname(fileName).toLowerCase();

    if (extension === '.srt') {
      return SubtitleFormat.srt;
    }

    if (extension === '.vtt') {
      return SubtitleFormat.vtt;
    }

    throw new ValidationDomainError(
      'Unsupported file type. Only .srt and .vtt files are accepted.',
    );
  }

  /** Calculates the total subtitle duration using the final cue end time. */
  private getDurationMs(cues: SubtitleCue[]): number {
    return cues.at(-1)?.endMs ?? 0;
  }
}
