import { Logger } from '@nestjs/common';
import {
  AppLanguage,
  SubtitleFormat,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { CatalogService } from 'src/features/catalog/catalog.service';
import { SubtitlesRepository } from 'src/features/subtitles/subtitles.repository';
import { TranslationProviderPort } from 'src/features/translation-jobs/ports/translation-provider.port';
import { TranslationJobRunnerService } from 'src/features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'src/features/translation-jobs/translation-jobs.repository';

describe('TranslationJobRunnerService', () => {
  const createRunnerJob = () => ({
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
  });

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
});
