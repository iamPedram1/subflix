import {
  AppLanguage as PrismaAppLanguage,
  ClientDevice,
  SubtitleFormat,
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { AppLanguage } from 'common/domain/enums/app-language.enum';
import { TranslationSourceType as TranslationSourceTypeDto } from 'common/domain/enums/translation-source-type.enum';
import { ValidationDomainError } from 'common/domain/errors/domain.error';
import { CatalogService } from 'features/catalog/catalog.service';
import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';
import { SubtitleExportService } from 'features/subtitles/utils/subtitle-export.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { TranslationJobsService } from 'features/translation-jobs/translation-jobs.service';

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
      {
        seasonNumber: undefined,
        episodeNumber: undefined,
        releaseHint: undefined,
      },
    );
    expect(jobsRepository.createJob).toHaveBeenCalledWith(
      expect.objectContaining({
        sourceType: TranslationSourceType.catalog,
        title: 'Dune: Part Two',
        sourceName: 'OpenSubtitles BluRay',
        parsedFileId: null,
        mediaRef: { mediaId: 'dune_part_two' },
        subtitleSourceRef: {
          subtitleSourceId: stableSubtitleSourceId,
          fallbackSubtitleSourceId: stableSubtitleSourceId,
        },
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

  // -------------------------------------------------------------------------
  // createJob – upload error paths
  // -------------------------------------------------------------------------

  it('throws ValidationDomainError when upload job is missing parsedFileId', async () => {
    const service = new TranslationJobsService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(
      service.createJob(device, {
        sourceType: TranslationSourceTypeDto.Upload,
        // parsedFileId intentionally omitted
        targetLanguage: PrismaAppLanguage.fr,
      }),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });

  // -------------------------------------------------------------------------
  // createJob – catalog error paths
  // -------------------------------------------------------------------------

  it('throws ValidationDomainError when catalog job is missing mediaId', async () => {
    const service = new TranslationJobsService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(
      service.createJob(device, {
        sourceType: TranslationSourceTypeDto.Catalog,
        subtitleSourceId: stableSubtitleSourceId,
        // mediaId intentionally omitted
        targetLanguage: PrismaAppLanguage.fr,
      }),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });

  it('throws ValidationDomainError when catalog job is missing subtitleSourceId', async () => {
    const service = new TranslationJobsService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(
      service.createJob(device, {
        sourceType: TranslationSourceTypeDto.Catalog,
        mediaId: 'inception',
        // subtitleSourceId intentionally omitted
        targetLanguage: PrismaAppLanguage.fr,
      }),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });

  it('throws ValidationDomainError when the requested media title is not found', async () => {
    const catalogService = {
      findById: vi.fn().mockResolvedValue(null),
      getSubtitleSources: vi.fn().mockResolvedValue([]),
    } as unknown as CatalogService;

    const service = new TranslationJobsService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      catalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(
      service.createJob(device, {
        sourceType: TranslationSourceTypeDto.Catalog,
        mediaId: 'nonexistent-media',
        subtitleSourceId: stableSubtitleSourceId,
        targetLanguage: PrismaAppLanguage.fr,
      }),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });

  it('throws ValidationDomainError when the subtitle source is not in the catalog results', async () => {
    const catalogService = {
      findById: vi.fn().mockResolvedValue({ id: 'inception', title: 'Inception' }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: buildSubtitleSourceId('subdl', 'other-source'),
          label: 'Other Source',
          format: SubtitleFormat.srt,
          lineCount: 100,
        },
      ]),
    } as unknown as CatalogService;

    const service = new TranslationJobsService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      catalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    await expect(
      service.createJob(device, {
        sourceType: TranslationSourceTypeDto.Catalog,
        mediaId: 'inception',
        subtitleSourceId: stableSubtitleSourceId, // not in results above
        targetLanguage: PrismaAppLanguage.fr,
      }),
    ).rejects.toBeInstanceOf(ValidationDomainError);
  });

  // -------------------------------------------------------------------------
  // listJobs
  // -------------------------------------------------------------------------

  it('returns a paginated list of device-owned jobs', async () => {
    const jobsRepository = {
      listOwnedJobs: vi.fn().mockResolvedValue({
        items: [createJobEntity()],
        total: 1,
        page: 1,
        limit: 20,
      }),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationJobsService(
      jobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    const result = await service.listJobs(device, { page: 1, limit: 20 });

    expect(jobsRepository.listOwnedJobs).toHaveBeenCalledWith(
      expect.objectContaining({ clientDeviceId: device.id, page: 1, limit: 20 }),
    );
    expect(result.items).toHaveLength(1);
    expect(result.total).toBe(1);
  });

  // -------------------------------------------------------------------------
  // clearHistory
  // -------------------------------------------------------------------------

  it('delegates history clearing and returns { cleared: true }', async () => {
    const jobsRepository = {
      clearOwnedHistory: vi.fn().mockResolvedValue(undefined),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationJobsService(
      jobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    const result = await service.clearHistory(device);

    expect(jobsRepository.clearOwnedHistory).toHaveBeenCalledWith(device.id);
    expect(result.cleared).toBe(true);
  });

  // -------------------------------------------------------------------------
  // retryJob
  // -------------------------------------------------------------------------

  it('creates a new job with the same parameters as the original', async () => {
    const originalJob = createJobEntity({
      sourceType: TranslationSourceType.upload,
      parsedFileId: 'parsed-file-1',
      targetLanguage: PrismaAppLanguage.es,
    });
    const newJob = createJobEntity({ id: 'job-2', parsedFileId: 'parsed-file-1' });
    const parsedFileSummary = {
      id: 'parsed-file-1',
      fileName: 'sample.srt',
      format: SubtitleFormat.srt,
      lineCount: 2,
      durationMs: 6250,
    };

    const jobsRepository = {
      findOwnedJob: vi.fn().mockResolvedValue(originalJob),
      createJob: vi.fn().mockResolvedValue(newJob),
    } as unknown as TranslationJobsRepository;
    const subtitlesRepository = {
      findOwnedParsedFileSummary: vi.fn().mockResolvedValue(parsedFileSummary),
    } as unknown as SubtitlesRepository;
    const runner = { schedule: vi.fn() } as unknown as TranslationJobRunnerService;

    const service = new TranslationJobsService(
      jobsRepository,
      subtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      runner,
    );

    const retried = await service.retryJob(device, 'job-1');

    expect(retried.id).toBe('job-2');
    expect(jobsRepository.createJob).toHaveBeenCalledWith(
      expect.objectContaining({
        parsedFileId: 'parsed-file-1',
        targetLanguage: PrismaAppLanguage.es,
      }),
    );
    expect(runner.schedule).toHaveBeenCalledWith('job-2');
  });

  // -------------------------------------------------------------------------
  // exportJob – happy path
  // -------------------------------------------------------------------------

  it('exports a completed job in the original format when no override is given', async () => {
    const completedJob = createJobEntity({
      status: TranslationJobStatus.completed,
      format: SubtitleFormat.srt,
      title: 'Inception',
      targetLanguage: PrismaAppLanguage.fr,
    });

    const jobsRepository = {
      findOwnedJob: vi.fn().mockResolvedValue(completedJob),
      listAllOwnedJobCues: vi.fn().mockResolvedValue([
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_500,
          originalText: 'Dream bigger.',
          translatedText: 'Reve plus grand.',
        },
      ]),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationJobsService(
      jobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      new SubtitleExportService(),
      {} as TranslationJobRunnerService,
    );

    const exported = await service.exportJob(device, 'job-1');

    expect(exported.fileName).toMatch(/inception.*fr.*\.srt$/);
    expect(exported.content).toContain('Reve plus grand.');
  });
});
