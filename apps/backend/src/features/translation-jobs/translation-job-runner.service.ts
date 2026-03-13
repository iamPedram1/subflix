import { Inject, Injectable, Logger } from '@nestjs/common';
import { AppLanguage, TranslationJobStatus, TranslationSourceType } from '@prisma/client';

import { CatalogService } from 'src/features/catalog/catalog.service';
import { SubtitlesRepository } from 'src/features/subtitles/subtitles.repository';

import { TRANSLATION_PROVIDER_PORT, TranslationProviderPort } from './ports/translation-provider.port';
import { TranslationJobsRepository } from './translation-jobs.repository';

const wait = async (milliseconds: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));

@Injectable()
export class TranslationJobRunnerService {
  private readonly logger = new Logger(TranslationJobRunnerService.name);

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly catalogService: CatalogService,
    @Inject(TRANSLATION_PROVIDER_PORT)
    private readonly translationProvider: TranslationProviderPort,
  ) {}

  schedule(jobId: string): void {
    setTimeout(() => {
      void this.run(jobId);
    }, 0);
  }

  async run(jobId: string): Promise<void> {
    const job = await this.translationJobsRepository.getJobForRunner(jobId);
    if (!job) {
      return;
    }

    try {
      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.translating,
        stageLabel: 'Loading source subtitle cues',
        progress: 0.18,
        startedAt: new Date(),
        errorMessage: null,
      });

      const sourceCues =
        job.sourceType === TranslationSourceType.upload
          ? (
              await this.subtitlesRepository.findOwnedParsedFile({
                clientDeviceId: job.clientDeviceId,
                parsedFileId: job.parsedFileId!,
              })
            ).cues.map((cue) => ({
              cueIndex: cue.cueIndex,
              startMs: cue.startMs,
              endMs: cue.endMs,
              text: cue.text,
            }))
          : await this.catalogService.getSubtitleCues(
              String((job.mediaRef as { mediaId: string }).mediaId),
              String(
                (job.subtitleSourceRef as { subtitleSourceId: string })
                  .subtitleSourceId,
              ),
            );

      await wait(250);
      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.translating,
        stageLabel: 'Translating subtitle lines',
        progress: 0.56,
      });

      const translatedLines = await this.translationProvider.translate({
        title: job.title,
        targetLanguage: job.targetLanguage as AppLanguage,
        cues: sourceCues,
      });

      await wait(220);
      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.translating,
        stageLabel: 'Building preview and export payloads',
        progress: 0.86,
      });

      await this.translationJobsRepository.replaceJobCues(
        jobId,
        sourceCues.map((cue, index) => ({
          cueIndex: cue.cueIndex,
          startMs: cue.startMs,
          endMs: cue.endMs,
          originalText: cue.text,
          translatedText: translatedLines[index] ?? cue.text,
        })),
      );

      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        progress: 1,
        completedAt: new Date(),
      });
    } catch (error) {
      this.logger.error(error);
      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.failed,
        stageLabel: 'Translation failed',
        errorMessage:
          error instanceof Error ? error.message : 'Translation failed.',
      });
    }
  }
}
