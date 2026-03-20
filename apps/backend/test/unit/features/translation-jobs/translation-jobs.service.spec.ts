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

// ---------------------------------------------------------------------------
// Shared fixtures
// ---------------------------------------------------------------------------

const stableSubtitleSourceId = buildSubtitleSourceId('subdl', 'source-1');

const device = {
  id: 'device-1',
  deviceId: 'device-header-1',
  createdAt: new Date(),
  updatedAt: new Date(),
} satisfies ClientDevice;

const createJobEntity = (overrides: Partial<TranslationJob> = {}): TranslationJob => ({
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
  jobMeta: null,
  mediaRef: null,
  subtitleSourceRef: null,
  createdAt: new Date(),
  updatedAt: new Date(),
  startedAt: null,
  completedAt: null,
  ...overrides,
});

// ---------------------------------------------------------------------------
// Mock factories
// ---------------------------------------------------------------------------

const makeJobsRepository = (
  overrides: Partial<{
    createJob: ReturnType<typeof vi.fn>;
    findOwnedJob: ReturnType<typeof vi.fn>;
    listOwnedJobs: ReturnType<typeof vi.fn>;
    clearOwnedHistory: ReturnType<typeof vi.fn>;
    listAllOwnedJobCues: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobsRepository =>
  ({
    createJob: vi.fn().mockResolvedValue(createJobEntity()),
    findOwnedJob: vi.fn().mockResolvedValue(null),
    listOwnedJobs: vi.fn().mockResolvedValue({ items: [], total: 0, page: 1, limit: 20 }),
    clearOwnedHistory: vi.fn().mockResolvedValue(undefined),
    listAllOwnedJobCues: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as TranslationJobsRepository;

const makeSubtitlesRepository = (
  overrides: Partial<{
    findOwnedParsedFileSummary: ReturnType<typeof vi.fn>;
  }> = {},
): SubtitlesRepository =>
  ({
    findOwnedParsedFileSummary: vi.fn().mockResolvedValue(null),
    ...overrides,
  }) as unknown as SubtitlesRepository;

const makeCatalogService = (
  overrides: Partial<{
    findById: ReturnType<typeof vi.fn>;
    getSubtitleSources: ReturnType<typeof vi.fn>;
  }> = {},
): CatalogService =>
  ({
    findById: vi.fn().mockResolvedValue(null),
    getSubtitleSources: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as CatalogService;

const makeRunner = (
  overrides: Partial<{ schedule: ReturnType<typeof vi.fn> }> = {},
): TranslationJobRunnerService =>
  ({
    schedule: vi.fn(),
    ...overrides,
  }) as unknown as TranslationJobRunnerService;

// ---------------------------------------------------------------------------
// Service builder
// ---------------------------------------------------------------------------

const buildService = ({
  jobsRepository = makeJobsRepository(),
  subtitlesRepository = makeSubtitlesRepository(),
  catalogService = makeCatalogService(),
  runner = makeRunner(),
}: Partial<{
  jobsRepository: TranslationJobsRepository;
  subtitlesRepository: SubtitlesRepository;
  catalogService: CatalogService;
  runner: TranslationJobRunnerService;
}> = {}): TranslationJobsService =>
  new TranslationJobsService(
    jobsRepository,
    subtitlesRepository,
    catalogService,
    new SubtitleExportService(),
    runner,
  );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('TranslationJobsService', () => {
  it('creates an upload translation job and schedules the runner', async () => {
    const jobsRepository = makeJobsRepository({
      createJob: vi.fn().mockResolvedValue(createJobEntity()),
    });
    const subtitlesRepository = makeSubtitlesRepository({
      findOwnedParsedFileSummary: vi.fn().mockResolvedValue({
        id: 'parsed-file-1',
        fileName: 'sample.srt',
        format: SubtitleFormat.srt,
        lineCount: 2,
        durationMs: 6250,
      }),
    });
    const runner = makeRunner({ schedule: vi.fn() });
    const service = buildService({ jobsRepository, subtitlesRepository, runner });

    const result = await service.createJob(device, {
      sourceType: TranslationSourceTypeDto.Upload,
      parsedFileId: 'parsed-file-1',
      targetLanguage: AppLanguage.French,
    });

    expect(result.id).toBe('job-1');
    expect(subtitlesRepository.findOwnedParsedFileSummary).toHaveBeenCalledWith({
      clientDeviceId: device.id,
      parsedFileId: 'parsed-file-1',
    });
    expect(jobsRepository.createJob).toHaveBeenCalled();
    expect(runner.schedule).toHaveBeenCalledWith('job-1');
  });

  it('creates a catalog translation job from the selected source metadata', async () => {
    const jobsRepository = makeJobsRepository({
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
    });
    const catalogService = makeCatalogService({
      findById: vi.fn().mockResolvedValue({ id: 'dune_part_two', title: 'Dune: Part Two' }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: stableSubtitleSourceId,
          label: 'OpenSubtitles BluRay',
          format: SubtitleFormat.srt,
          lineCount: 1_248,
        },
      ]),
    });
    const runner = makeRunner({ schedule: vi.fn() });
    const service = buildService({ jobsRepository, catalogService, runner });

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
    const jobsRepository = makeJobsRepository({
      findOwnedJob: vi.fn().mockResolvedValue(
        createJobEntity({ status: TranslationJobStatus.queued }),
      ),
    });
    const service = buildService({ jobsRepository });

    await expect(service.exportJob(device, 'job-1')).rejects.toBeInstanceOf(
      ValidationDomainError,
    );
  });

  it('blocks retry while a job is still active', async () => {
    const jobsRepository = makeJobsRepository({
      findOwnedJob: vi.fn().mockResolvedValue(
        createJobEntity({ status: TranslationJobStatus.translating }),
      ),
    });
    const service = buildService({ jobsRepository });

    await expect(service.retryJob(device, 'job-1')).rejects.toBeInstanceOf(
      ValidationDomainError,
    );
  });

  // -------------------------------------------------------------------------
  // createJob – upload error paths
  // -------------------------------------------------------------------------

  it('throws ValidationDomainError when upload job is missing parsedFileId', async () => {
    const service = buildService();

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
    const service = buildService();

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
    const service = buildService();

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
    const catalogService = makeCatalogService({
      findById: vi.fn().mockResolvedValue(null),
    });
    const service = buildService({ catalogService });

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
    const catalogService = makeCatalogService({
      findById: vi.fn().mockResolvedValue({ id: 'inception', title: 'Inception' }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: buildSubtitleSourceId('subdl', 'other-source'),
          label: 'Other Source',
          format: SubtitleFormat.srt,
          lineCount: 100,
        },
      ]),
    });
    const service = buildService({ catalogService });

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
    const jobsRepository = makeJobsRepository({
      listOwnedJobs: vi.fn().mockResolvedValue({
        items: [createJobEntity()],
        total: 1,
        page: 1,
        limit: 20,
      }),
    });
    const service = buildService({ jobsRepository });

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
    const jobsRepository = makeJobsRepository({
      clearOwnedHistory: vi.fn().mockResolvedValue(undefined),
    });
    const service = buildService({ jobsRepository });

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
      status: TranslationJobStatus.completed,
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

    const jobsRepository = makeJobsRepository({
      findOwnedJob: vi.fn().mockResolvedValue(originalJob),
      createJob: vi.fn().mockResolvedValue(newJob),
    });
    const subtitlesRepository = makeSubtitlesRepository({
      findOwnedParsedFileSummary: vi.fn().mockResolvedValue(parsedFileSummary),
    });
    const runner = makeRunner({ schedule: vi.fn() });
    const service = buildService({ jobsRepository, subtitlesRepository, runner });

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
    const jobsRepository = makeJobsRepository({
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
    });
    const service = buildService({ jobsRepository });

    const exported = await service.exportJob(device, 'job-1');

    expect(exported.fileName).toMatch(/inception.*fr.*\.srt$/);
    expect(exported.content).toContain('Reve plus grand.');
  });
});
