import {
  AppLanguage as PrismaAppLanguage,
  ClientDevice,
  SubtitleFormat,
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { TranslationSourceType as TranslationSourceTypeDto } from 'src/common/domain/enums/translation-source-type.enum';
import { ValidationDomainError } from 'src/common/domain/errors/domain.error';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { buildSubtitleSourceId } from 'src/features/catalog/utils/subtitle-source-id.util';
import { SubtitlesRepository } from 'src/features/subtitles/subtitles.repository';
import { SubtitleExportService } from 'src/features/subtitles/utils/subtitle-export.service';
import { TranslationJobRunnerService } from 'src/features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'src/features/translation-jobs/translation-jobs.repository';
import { TranslationJobsService } from 'src/features/translation-jobs/translation-jobs.service';

describe('TranslationJobsService', () => {
  const stableSubtitleSourceId = buildSubtitleSourceId('subdl', 'source-1');

  const device = {
    id: 'device-1',
    deviceId: 'device-header-1',
    createdAt: new Date(),
    updatedAt: new Date(),
  } satisfies ClientDevice;

  const createJobEntity = (
    overrides: Partial<TranslationJob> = {},
  ): TranslationJob => ({
    id: 'job-1',
    clientDeviceId: device.id,
    sourceType: TranslationSourceType.upload,
    status: TranslationJobStatus.queued,
    stageLabel: 'Queued for translation',
    title: 'sample',
    sourceName: 'sample.srt',
    sourceLanguage: PrismaAppLanguage.en,
    targetLanguage: PrismaAppLanguage.fr,
    format: SubtitleFormat.srt,
    progress: 0.05,
    lineCount: 2,
    durationMs: 6250,
    errorMessage: null,
    parsedFileId: 'parsed-file-1',
    mediaRef: null,
    subtitleSourceRef: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    startedAt: null,
    completedAt: null,
    ...overrides,
  });

  it('creates an upload translation job and schedules the runner', async () => {
    const jobsRepository = {
      createJob: vi.fn().mockResolvedValue(createJobEntity()),
    } as unknown as TranslationJobsRepository;
    const subtitlesRepository = {
      findOwnedParsedFileSummary: vi.fn().mockResolvedValue({
        id: 'parsed-file-1',
        fileName: 'sample.srt',
        format: SubtitleFormat.srt,
        lineCount: 2,
        durationMs: 6250,
      }),
    } as unknown as SubtitlesRepository;
    const runner = {
      schedule: vi.fn(),
    } as unknown as TranslationJobRunnerService;

    const service = new TranslationJobsService(
      jobsRepository,
      subtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      runner,
    );

    const result = await service.createJob(device, {
      sourceType: TranslationSourceTypeDto.Upload,
      parsedFileId: 'parsed-file-1',
      targetLanguage: AppLanguage.French,
    });

    expect(result.id).toBe('job-1');
    expect(subtitlesRepository.findOwnedParsedFileSummary).toHaveBeenCalledWith(
      {
        clientDeviceId: device.id,
        parsedFileId: 'parsed-file-1',
      },
    );
    expect(jobsRepository.createJob).toHaveBeenCalled();
    expect(runner.schedule).toHaveBeenCalledWith('job-1');
  });

  it('creates a catalog translation job from the selected source metadata', async () => {
    const jobsRepository = {
      createJob: vi.fn().mockResolvedValue(
        createJobEntity({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          title: 'Dune: Part Two',
          sourceName: 'OpenSubtitles BluRay',
          mediaRef: { mediaId: 'dune_part_two' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
    } as unknown as TranslationJobsRepository;
    const catalogService = {
      findById: vi.fn().mockResolvedValue({
        id: 'dune_part_two',
        title: 'Dune: Part Two',
      }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: stableSubtitleSourceId,
          label: 'OpenSubtitles BluRay',
          format: SubtitleFormat.srt,
          lineCount: 1_248,
        },
      ]),
    } as unknown as CatalogService;
    const runner = {
      schedule: vi.fn(),
    } as unknown as TranslationJobRunnerService;

    const service = new TranslationJobsService(
      jobsRepository,
      {} as SubtitlesRepository,
      catalogService,
      new SubtitleExportService(),
      runner,
    );

    await service.createJob(device, {
      sourceType: TranslationSourceTypeDto.Catalog,
      mediaId: 'dune_part_two',
      subtitleSourceId: stableSubtitleSourceId,
      targetLanguage: AppLanguage.French,
    });

    expect(catalogService.findById).toHaveBeenCalledWith('dune_part_two');
    expect(catalogService.getSubtitleSources).toHaveBeenCalledWith(
      'dune_part_two',
    );
    expect(jobsRepository.createJob).toHaveBeenCalledWith(
      expect.objectContaining({
        sourceType: TranslationSourceType.catalog,
        title: 'Dune: Part Two',
        sourceName: 'OpenSubtitles BluRay',
        parsedFileId: null,
        mediaRef: { mediaId: 'dune_part_two' },
        subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
      }),
    );
    expect(runner.schedule).toHaveBeenCalledWith('job-1');
  });

  it('blocks export before completion', async () => {
    const jobsRepository = {
      findOwnedJob: vi
        .fn()
        .mockResolvedValue(
          createJobEntity({ status: TranslationJobStatus.queued }),
        ),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationJobsService(
      jobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(service.exportJob(device, 'job-1')).rejects.toBeInstanceOf(
      ValidationDomainError,
    );
  });
});
