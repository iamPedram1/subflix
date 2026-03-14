import { zipSync } from 'fflate';

import { ConfigService } from '@nestjs/config';

import {
  NotFoundDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { CatalogSubtitleFileProvider } from 'features/catalog/ports/catalog-subtitle-file-provider.port';
import { MediaCatalogPort } from 'features/catalog/ports/media-catalog.port';
import { CatalogSubtitleCueProvider } from 'features/catalog/providers/catalog-subtitle-cue.provider';
import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';
import { SubtitleParserService } from 'features/subtitles/utils/subtitle-parser.service';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describe('CatalogSubtitleCueProvider', () => {
  const createProvider = (params: {
    mediaExists?: boolean;
    downloadBytes: Buffer;
    fileName?: string;
    contentType?: string;
  }) => {
    const mediaCatalogPort: MediaCatalogPort = {
      search: vi.fn(),
      findById: vi.fn().mockResolvedValue(
        params.mediaExists === false
          ? null
          : ({
              id: 'movie_1',
              title: 'Inception',
            } as unknown),
      ),
    } as unknown as MediaCatalogPort;

    const fileProviders: CatalogSubtitleFileProvider[] = [
      {
        provider: 'subdl',
        downloadSubtitleFile: vi.fn().mockResolvedValue({
          sourceUrl: 'https://example.test/subtitle',
          fileName: params.fileName,
          contentType: params.contentType,
          bytes: params.downloadBytes,
        }),
      },
    ];

    return new CatalogSubtitleCueProvider(
      {
        get: vi.fn().mockReturnValue(undefined),
      } as unknown as ConfigService,
      new SubtitleParserService(),
      mediaCatalogPort,
      fileProviders,
    );
  };

  it('downloads and parses a direct .srt payload into normalized cues', async () => {
    const service = createProvider({
      downloadBytes: Buffer.from(sampleSrt, 'utf8'),
      fileName: 'sample.srt',
      contentType: 'application/x-subrip',
    });

    const cues = await service.getSubtitleCues(
      'movie_1',
      buildSubtitleSourceId('subdl', '123'),
    );

    expect(cues.length).toBe(2);
    expect(cues[0]?.cueIndex).toBe(1);
  });

  it('extracts and parses the best subtitle file from a .zip archive', async () => {
    const zipped = zipSync({
      'README.txt': new TextEncoder().encode('readme'),
      'sub.srt': new TextEncoder().encode(sampleSrt),
    });

    const service = createProvider({
      downloadBytes: Buffer.from(zipped),
      fileName: 'subtitles.zip',
      contentType: 'application/zip',
    });

    const cues = await service.getSubtitleCues(
      'movie_1',
      buildSubtitleSourceId('subdl', '123'),
    );

    expect(cues.length).toBe(2);
  });

  it('rejects unknown media ids with a normalized not_found domain error', async () => {
    const service = createProvider({
      mediaExists: false,
      downloadBytes: Buffer.from(sampleSrt, 'utf8'),
      fileName: 'sample.srt',
    });

    await expect(
      service.getSubtitleCues(
        'movie_missing',
        buildSubtitleSourceId('subdl', '123'),
      ),
    ).rejects.toBeInstanceOf(NotFoundDomainError);
  });

  it('rejects malformed subtitle source ids with a normalized validation error', async () => {
    const service = createProvider({
      downloadBytes: Buffer.from(sampleSrt, 'utf8'),
      fileName: 'sample.srt',
    });

    await expect(
      service.getSubtitleCues('movie_1', 'nope'),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });
});
