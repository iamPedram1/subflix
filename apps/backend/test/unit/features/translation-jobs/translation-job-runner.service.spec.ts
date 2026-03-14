import { Logger } from '@nestjs/common';
import {
  AppLanguage,
  SubtitleFormat,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { CatalogService } from 'features/catalog/catalog.service';
import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';
import { TranslationProviderPort } from 'features/translation-jobs/ports/translation-provider.port';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

describe('TranslationJobRunnerService', () => {
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

  const stableSubtitleSourceId = buildSubtitleSourceId('subdl', 'source-1');

  it('schedules job execution asynchronously', async () => {
    vi.useFakeTimers();

    const service = new TranslationJobRunnerService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      {} as TranslationProviderPort,
    );
    const runSpy = vi.spyOn(service, 'run').mockResolvedValue();

    service.schedule('job-1');

    expect(runSpy).not.toHaveBeenCalled();

    await vi.runAllTimersAsync();

    expect(runSpy).toHaveBeenCalledWith('job-1');
  });

  it('coalesces duplicate schedule requests for the same job id', async () => {
    vi.useFakeTimers();

    const service = new TranslationJobRunnerService(
      {} as TranslationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      {} as TranslationProviderPort,
    );
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

    const translationJobsRepository = {
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(createRunnerJob()),
      updateJob: vi.fn().mockResolvedValue(undefined),
      replaceJobCues: vi.fn().mockResolvedValue(undefined),
    } as unknown as TranslationJobsRepository;
    const subtitlesRepository = {
      listOwnedParsedFileCues: vi.fn().mockResolvedValue([
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_500,
          text: 'We only have one clean pass.',
        },
      ]),
    } as unknown as SubtitlesRepository;
    const translationProvider = {
      translate: vi.fn().mockRejectedValue(new Error('Provider exploded.')),
    } as unknown as TranslationProviderPort;

    const service = new TranslationJobRunnerService(
      translationJobsRepository,
      subtitlesRepository,
      {} as CatalogService,
      translationProvider,
    );

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(
      translationJobsRepository.claimQueuedJobForRunner,
    ).toHaveBeenCalledWith('job-1');
    expect(translationJobsRepository.updateJob).toHaveBeenNthCalledWith(
      1,
      'job-1',
      expect.objectContaining({
        status: TranslationJobStatus.translating,
        stageLabel: 'Translating subtitle lines',
        progress: 0.56,
      }),
    );
    expect(translationJobsRepository.updateJob).toHaveBeenLastCalledWith(
      'job-1',
      expect.objectContaining({
        status: TranslationJobStatus.failed,
        stageLabel: 'Translation failed',
        errorMessage: 'Provider exploded.',
      }),
    );
    expect(translationJobsRepository.replaceJobCues).not.toHaveBeenCalled();
  });

  it('does nothing when another runner already claimed the job', async () => {
    const translationJobsRepository = {
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(null),
      updateJob: vi.fn(),
      replaceJobCues: vi.fn(),
    } as unknown as TranslationJobsRepository;
    const translationProvider = {
      translate: vi.fn(),
    } as unknown as TranslationProviderPort;

    const service = new TranslationJobRunnerService(
      translationJobsRepository,
      {} as SubtitlesRepository,
      {} as CatalogService,
      translationProvider,
    );

    await service.run('job-1');

    expect(
      translationJobsRepository.claimQueuedJobForRunner,
    ).toHaveBeenCalledWith('job-1');
    expect(translationJobsRepository.updateJob).not.toHaveBeenCalled();
    expect(translationJobsRepository.replaceJobCues).not.toHaveBeenCalled();
    expect(translationProvider.translate).not.toHaveBeenCalled();
  });

  it('reuses stable catalog subtitle source ids when loading cues', async () => {
    vi.useFakeTimers();

    const translationJobsRepository = {
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
      findReusableCatalogSourceCues: vi.fn().mockResolvedValue([]),
      updateJob: vi.fn().mockResolvedValue(undefined),
      replaceJobCues: vi.fn().mockResolvedValue(undefined),
    } as unknown as TranslationJobsRepository;
    const catalogService = {
      getSubtitleCues: vi.fn().mockResolvedValue([
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_000,
          text: 'Dream bigger.',
        },
      ]),
    } as unknown as CatalogService;
    const translationProvider = {
      translate: vi.fn().mockResolvedValue(['Dream bigger.']),
    } as unknown as TranslationProviderPort;

    const service = new TranslationJobRunnerService(
      translationJobsRepository,
      {} as SubtitlesRepository,
      catalogService,
      translationProvider,
    );

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

    const translationJobsRepository = {
      claimQueuedJobForRunner: vi.fn().mockResolvedValue(
        createRunnerJob({
          sourceType: TranslationSourceType.catalog,
          parsedFileId: null,
          mediaRef: { mediaId: 'movie_27205' },
          subtitleSourceRef: { subtitleSourceId: stableSubtitleSourceId },
        }),
      ),
      findReusableCatalogSourceCues: vi.fn().mockResolvedValue([
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_000,
          text: 'Dream bigger.',
        },
      ]),
      updateJob: vi.fn().mockResolvedValue(undefined),
      replaceJobCues: vi.fn().mockResolvedValue(undefined),
    } as unknown as TranslationJobsRepository;
    const catalogService = {
      getSubtitleCues: vi.fn(),
    } as unknown as CatalogService;
    const translationProvider = {
      translate: vi.fn().mockResolvedValue(['Dream bigger.']),
    } as unknown as TranslationProviderPort;

    const service = new TranslationJobRunnerService(
      translationJobsRepository,
      {} as SubtitlesRepository,
      catalogService,
      translationProvider,
    );

    const runPromise = service.run('job-1');
    await vi.runAllTimersAsync();
    await runPromise;

    expect(
      translationJobsRepository.findReusableCatalogSourceCues,
    ).toHaveBeenCalledWith(
      expect.objectContaining({
        mediaId: 'movie_27205',
        subtitleSourceId: stableSubtitleSourceId,
      }),
    );
    expect(catalogService.getSubtitleCues).not.toHaveBeenCalled();
  });
});
