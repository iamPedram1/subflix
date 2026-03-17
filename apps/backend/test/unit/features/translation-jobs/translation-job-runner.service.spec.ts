import { Logger } from '@nestjs/common';
import {
  AppLanguage,
  SubtitleFormat,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { CatalogService } from 'features/catalog/catalog.service';
import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { SubtitleTimingAlignmentService } from 'features/catalog/subtitle-timing-alignment.service';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';
import { TranslationProviderPort } from 'features/translation-jobs/ports/translation-provider.port';
import { SubtitleAcquisitionStrategyService } from 'features/translation-jobs/subtitle-acquisition-strategy.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { TranslationReuseService } from 'features/translation-jobs/translation-reuse.service';

// ---------------------------------------------------------------------------
// Shared fixture
// ---------------------------------------------------------------------------

const stableSubtitleSourceId = buildSubtitleSourceId('subdl', 'source-1');

const createRunnerJob = (overrides: Record<string, unknown> = {}) => ({
  id: 'job-1',
  clientDeviceId: 'device-1',
  sourceType: TranslationSourceType.upload,
  status: TranslationJobStatus.queued,
  stageLabel: 'Queued for translation',
  title: 'sample',
  sourceName: 'sample.srt',
  sourceLanguage: AppLanguage.en,
  targetLanguage: AppLanguage.fr,
  format: SubtitleFormat.srt,
  progress: 0.05,
  lineCount: 2,
  durationMs: 6_250,
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

// ---------------------------------------------------------------------------
// Mock factories
// ---------------------------------------------------------------------------

const makeJobsRepository = (
  overrides: Partial<{
    claimQueuedJobForRunner: ReturnType<typeof vi.fn>;
    updateJob: ReturnType<typeof vi.fn>;
    replaceJobCues: ReturnType<typeof vi.fn>;
    findReusableCatalogSourceCues: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobsRepository =>
  ({
    claimQueuedJobForRunner: vi.fn().mockResolvedValue(null),
    updateJob: vi.fn().mockResolvedValue(undefined),
    replaceJobCues: vi.fn().mockResolvedValue(undefined),
    findReusableCatalogSourceCues: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as TranslationJobsRepository;

const makeSubtitlesRepository = (
  overrides: Partial<{
    listOwnedParsedFileCues: ReturnType<typeof vi.fn>;
  }> = {},
): SubtitlesRepository =>
  ({
    listOwnedParsedFileCues: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as SubtitlesRepository;

const makeCatalogService = (
  overrides: Partial<{
    findById: ReturnType<typeof vi.fn>;
    getSubtitleCues: ReturnType<typeof vi.fn>;
  }> = {},
): CatalogService =>
  ({
    findById: vi.fn().mockResolvedValue(null),
    getSubtitleCues: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as CatalogService;

const makeQualityEvaluationService = (
  overrides: Partial<{
    evaluateCatalogJob: ReturnType<typeof vi.fn>;
  }> = {},
): SubtitleQualityEvaluationService =>
  ({
    evaluateCatalogJob: vi.fn().mockReturnValue({
      confidenceScore: 85,
      confidenceLevel: 'high',
      warnings: [],
      shouldBlockAutoUse: false,
      signals: {},
    }),
    ...overrides,
  }) as unknown as SubtitleQualityEvaluationService;

const makeTimingAlignmentService = (): SubtitleTimingAlignmentService =>
  ({
    alignCatalogCues: vi.fn((cues) => ({
      cues,
      analysis: {
        detectedOffsetMs: 0,
        confidence: 0,
        appliedCorrection: false,
        warnings: [],
      },
    })),
  }) as unknown as SubtitleTimingAlignmentService;

const makeAcquisitionStrategyService = (
  overrides: Partial<{
    decideCatalogAcquisition: ReturnType<typeof vi.fn>;
  }> = {},
): SubtitleAcquisitionStrategyService =>
  ({
    decideCatalogAcquisition: vi.fn().mockResolvedValue({
      acquisitionMode: 'ai_translation',
      subtitleSourceIdToUse: stableSubtitleSourceId,
      selectedLanguageCode: 'en',
      requestedTargetLanguage: 'fr',
      reusedExistingSubtitle: false,
      reason: 'no_target_subtitle_candidates',
    }),
    ...overrides,
  }) as unknown as SubtitleAcquisitionStrategyService;

const makeReuseService = (
  overrides: Partial<{
    decideCatalogTranslationReuse: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationReuseService =>
  ({
    decideCatalogTranslationReuse: vi.fn().mockResolvedValue({
      reuseAllowed: false,
      reuseReason: 'no_reusable_translation',
    }),
    ...overrides,
  }) as unknown as TranslationReuseService;

const makeTranslationProvider = (
  overrides: Partial<{
    translate: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationProviderPort =>
  ({
    translate: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as TranslationProviderPort;

// ---------------------------------------------------------------------------
// Service builder
// ---------------------------------------------------------------------------

const buildRunner = ({
  jobsRepository = makeJobsRepository(),
  subtitlesRepository = makeSubtitlesRepository(),
  catalogService = makeCatalogService(),
  qualityEvaluationService = makeQualityEvaluationService(),
  timingAlignmentService = makeTimingAlignmentService(),
  acquisitionStrategyService = makeAcquisitionStrategyService(),
  reuseService = makeReuseService(),
  translationProvider = makeTranslationProvider(),
}: Partial<{
  jobsRepository: TranslationJobsRepository;
  subtitlesRepository: SubtitlesRepository;
  catalogService: CatalogService;
  qualityEvaluationService: SubtitleQualityEvaluationService;
  timingAlignmentService: SubtitleTimingAlignmentService;
  acquisitionStrategyService: SubtitleAcquisitionStrategyService;
  reuseService: TranslationReuseService;
  translationProvider: TranslationProviderPort;
}> = {}): TranslationJobRunnerService =>
  new TranslationJobRunnerService(
    jobsRepository,
    subtitlesRepository,
    catalogService,
    qualityEvaluationService,
    timingAlignmentService,
    acquisitionStrategyService,
    reuseService,
    translationProvider,
  );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('TranslationJobRunnerService', () => {
  it('schedules job execution asynchronously', async () => {
    vi.useFakeTimers();
    const service = buildRunner();
    const runSpy = vi.spyOn(service, 'run').mockResolvedValue();

    service.schedule('job-1');

    expect(runSpy).not.toHaveBeenCalled();

    await vi.runAllTimersAsync();

    expect(runSpy).toHaveBeenCalledWith('job-1');
  });

  it('coalesces duplicate schedule requests for the same job id', async () => {
    vi.useFakeTimers();
    const service = buildRunner();
    const runSpy = vi.spyOn(service, 'run').mockResolvedValue();

    service.schedule('job-1');
    service.schedule('job-1');

    await vi.runAllTimersAsync();

    expect(runSpy).toHaveBeenCalledTimes(1);
    expect(runSpy).toHaveBeenCalledWith('job-1');
  });

  it('marks a job as failed when translation execution throws', async () => {
    vi.useFakeTimers();
    vi.spyOn(Logger.prototype, 'error').mockImplementation(() => undefined);

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(createRunnerJob()),
    });
    const subtitlesRepository = makeSubtitlesRepository({
      listOwnedParsedFileCues: vi.fn().mockResolvedValue([
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_500,
          text: 'We only have one clean pass.',
        },
      ]),
    });
    const translationProvider = makeTranslationProvider({
      translate: vi.fn().mockRejectedValue(new Error('Provider exploded.')),
    });

    const service = buildRunner({ jobsRepository, subtitlesRepository, translationProvider });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(jobsRepository.claimQueuedJobForRunner).toHaveBeenCalledWith('job-1');
    expect(jobsRepository.updateJob).toHaveBeenNthCalledWith(
      1,
      'job-1',
      expect.objectContaining({
        status: TranslationJobStatus.translating,
        stageLabel: 'Translating subtitle lines',
        progress: 0.56,
      }),
    );
    expect(jobsRepository.updateJob).toHaveBeenLastCalledWith(
      'job-1',
      expect.objectContaining({
        status: TranslationJobStatus.failed,
        stageLabel: 'Translation failed',
        errorMessage: 'Provider exploded.',
      }),
    );
    expect(jobsRepository.replaceJobCues).not.toHaveBeenCalled();
  });

  it('does nothing when another runner already claimed the job', async () => {
    const jobsRepository = makeJobsRepository(); // claimQueuedJobForRunner returns null by default
    const translationProvider = makeTranslationProvider();

    const service = buildRunner({ jobsRepository, translationProvider });

    await service.run('job-1');

    expect(jobsRepository.claimQueuedJobForRunner).toHaveBeenCalledWith('job-1');
    expect(jobsRepository.updateJob).not.toHaveBeenCalled();
    expect(jobsRepository.replaceJobCues).not.toHaveBeenCalled();
    expect(translationProvider.translate).not.toHaveBeenCalled();
  });

  it('reuses stable catalog subtitle source ids when loading cues', async () => {
    vi.useFakeTimers();

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
    });
    const catalogService = makeCatalogService({
      getSubtitleCues: vi.fn().mockResolvedValue([
        { cueIndex: 1, startMs: 1_000, endMs: 3_000, text: 'Dream bigger.' },
      ]),
    });
    const translationProvider = makeTranslationProvider({
      translate: vi.fn().mockResolvedValue(['Dream bigger.']),
    });

    const service = buildRunner({ jobsRepository, catalogService, translationProvider });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(catalogService.getSubtitleCues).toHaveBeenCalledWith(
      'movie_27205',
      stableSubtitleSourceId,
    );
  });

  it('reuses persisted catalog source cues before redownloading', async () => {
    vi.useFakeTimers();

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
      findReusableCatalogSourceCues: vi.fn().mockResolvedValue([
        { cueIndex: 1, startMs: 1_000, endMs: 3_000, text: 'Dream bigger.' },
      ]),
    });
    const catalogService = makeCatalogService(); // getSubtitleCues should NOT be called
    const translationProvider = makeTranslationProvider({
      translate: vi.fn().mockResolvedValue(['Dream bigger.']),
    });

    const service = buildRunner({ jobsRepository, catalogService, translationProvider });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(jobsRepository.findReusableCatalogSourceCues).toHaveBeenCalledWith(
      expect.objectContaining({
        mediaId: 'movie_27205',
        subtitleSourceId: stableSubtitleSourceId,
      }),
    );
    expect(catalogService.getSubtitleCues).not.toHaveBeenCalled();
  });

  it('fails early when catalog subtitle quality evaluation blocks auto use', async () => {
    vi.useFakeTimers();
    vi.spyOn(Logger.prototype, 'error').mockImplementation(() => undefined);

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
    });
    const catalogService = makeCatalogService({
      getSubtitleCues: vi.fn().mockResolvedValue([
        { cueIndex: 1, startMs: 5_000, endMs: 1_000, text: 'I am the one.' },
      ]),
    });
    const qualityEvaluationService = makeQualityEvaluationService({
      evaluateCatalogJob: vi.fn().mockReturnValue({
        confidenceScore: 5,
        confidenceLevel: 'low',
        warnings: ['invalid_timing_ranges'],
        shouldBlockAutoUse: true,
        signals: {},
      }),
    });
    const translationProvider = makeTranslationProvider();

    const service = buildRunner({
      jobsRepository,
      catalogService,
      qualityEvaluationService,
      translationProvider,
    });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(translationProvider.translate).not.toHaveBeenCalled();
    expect(jobsRepository.replaceJobCues).not.toHaveBeenCalled();
    expect(jobsRepository.updateJob).toHaveBeenLastCalledWith(
      'job-1',
      expect.objectContaining({
        status: TranslationJobStatus.failed,
        stageLabel: 'Translation failed',
      }),
    );
  });

  it('reuses an existing target-language subtitle and skips translation', async () => {
    vi.useFakeTimers();

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
    });
    const acquisitionStrategyService = makeAcquisitionStrategyService({
      decideCatalogAcquisition: vi.fn().mockResolvedValue({
        acquisitionMode: 'existing_target_subtitle',
        subtitleSourceIdToUse: 'ssrc:subdl:fr',
        selectedLanguageCode: 'fr',
        requestedTargetLanguage: 'fr',
        reusedExistingSubtitle: true,
        reason: 'allowed',
        subtitleSourceLabel: 'French Sub',
        subtitleSourceFormat: SubtitleFormat.srt,
        cues: [{ cueIndex: 1, startMs: 65_000, endMs: 67_000, text: 'Bonjour' }],
        reusedSubtitleQuality: {
          confidenceScore: 70,
          confidenceLevel: 'medium',
          warnings: [],
        },
      }),
    });
    const translationProvider = makeTranslationProvider();

    const service = buildRunner({ jobsRepository, acquisitionStrategyService, translationProvider });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(translationProvider.translate).not.toHaveBeenCalled();
    expect(jobsRepository.replaceJobCues).toHaveBeenCalledWith(
      'job-1',
      [
        expect.objectContaining({
          originalText: 'Bonjour',
          translatedText: 'Bonjour',
        }),
      ],
    );
  });

  it('reuses a previously completed translation and skips the translation provider', async () => {
    vi.useFakeTimers();

    const jobsRepository = makeJobsRepository({
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
    });
    const catalogService = makeCatalogService({
      getSubtitleCues: vi.fn().mockResolvedValue([
        { cueIndex: 1, startMs: 1_000, endMs: 3_000, text: 'Dream bigger.' },
      ]),
    });
    const reuseService = makeReuseService({
      decideCatalogTranslationReuse: vi.fn().mockResolvedValue({
        reuseAllowed: true,
        reusableJobId: 'job-old',
        reuseReason: 'reused_completed_translation',
        translatedCues: [
          {
            cueIndex: 1,
            startMs: 1_000,
            endMs: 3_000,
            translatedText: 'Reve plus grand.',
          },
        ],
      }),
    });
    const translationProvider = makeTranslationProvider();

    const service = buildRunner({
      jobsRepository,
      catalogService,
      reuseService,
      translationProvider,
    });

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(translationProvider.translate).not.toHaveBeenCalled();
    expect(jobsRepository.replaceJobCues).toHaveBeenCalledWith(
      'job-1',
      [
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_000,
          originalText: 'Dream bigger.',
          translatedText: 'Reve plus grand.',
        },
      ],
    );
    expect(jobsRepository.updateJob).toHaveBeenCalledWith(
      'job-1',
      expect.objectContaining({
        subtitleSourceRef: expect.objectContaining({
          translationReuse: {
            reused: true,
            reusedFromJobId: 'job-old',
          },
        }),
      }),
    );
  });
});
