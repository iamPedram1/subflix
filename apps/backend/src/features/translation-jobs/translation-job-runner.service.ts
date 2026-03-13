import { Inject, Injectable, Logger } from '@nestjs/common';
import {
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { delay } from 'src/common/utils/delay.util';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { SubtitleCue } from 'src/features/subtitles/models/subtitle-cue.model';
import { SubtitlesRepository } from 'src/features/subtitles/subtitles.repository';

import {
  TRANSLATION_PROVIDER_PORT,
  TranslationProviderPort,
} from './ports/translation-provider.port';
import { TranslationJobsRepository } from './translation-jobs.repository';

type PersistedJobCue = Parameters<
  TranslationJobsRepository['replaceJobCues']
>[1][number];

/**
 * Executes translation jobs asynchronously inside the API process.
 *
 * The service is intentionally isolated so it can later be replaced by an
 * external queue worker without changing controller or orchestration logic.
 */
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

  /** Schedules a persisted job to run after the request lifecycle completes. */
  schedule(jobId: string): void {
    setTimeout(() => {
      void this.run(jobId);
    }, 0);
  }

  /** Processes a single translation job from queued state to completion or failure. */
  async run(jobId: string): Promise<void> {
    const job = await this.translationJobsRepository.getJobForRunner(jobId);
    if (!job) {
      return;
    }

    try {
      await this.markProgress(jobId, {
        stageLabel: 'Loading source subtitle cues',
        progress: 0.18,
        startedAt: new Date(),
        errorMessage: null,
      });

      const sourceCues = await this.loadSourceCues(job);

      await delay(250);
      await this.markProgress(jobId, {
        stageLabel: 'Translating subtitle lines',
        progress: 0.56,
      });

      const translatedLines = await this.translationProvider.translate({
        title: job.title,
        targetLanguage: job.targetLanguage,
        cues: sourceCues,
      });

      await delay(220);
      await this.markProgress(jobId, {
        stageLabel: 'Building preview and export payloads',
        progress: 0.86,
      });

      await this.translationJobsRepository.replaceJobCues(
        jobId,
        this.buildPersistedJobCues(sourceCues, translatedLines),
      );

      await this.translationJobsRepository.updateJob(jobId, {
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        progress: 1,
        completedAt: new Date(),
      });
    } catch (error) {
      this.logger.error(error);
      await this.markFailure(jobId, error);
    }
  }

  /** Loads normalized source cues for either uploaded or catalog-backed jobs. */
  private async loadSourceCues(job: TranslationJob): Promise<SubtitleCue[]> {
    if (job.sourceType === TranslationSourceType.upload) {
      return this.loadUploadedSourceCues(job);
    }

    const references = this.getCatalogReferences(job);
    return this.catalogService.getSubtitleCues(
      references.mediaId,
      references.subtitleSourceId,
    );
  }

  /** Loads normalized cues from a previously parsed upload owned by the device. */
  private async loadUploadedSourceCues(
    job: TranslationJob,
  ): Promise<SubtitleCue[]> {
    const parsedFile = await this.subtitlesRepository.findOwnedParsedFile({
      clientDeviceId: job.clientDeviceId,
      parsedFileId: this.requireParsedFileId(job),
    });

    return parsedFile.cues.map((cue) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      text: cue.text,
    }));
  }

  /** Extracts and validates the catalog references needed to replay a catalog job. */
  private getCatalogReferences(job: TranslationJob): {
    mediaId: string;
    subtitleSourceId: string;
  } {
    const mediaId = (job.mediaRef as { mediaId?: string } | null)?.mediaId;
    const subtitleSourceId = (
      job.subtitleSourceRef as { subtitleSourceId?: string } | null
    )?.subtitleSourceId;

    if (!mediaId || !subtitleSourceId) {
      throw new Error('Catalog translation job is missing source references.');
    }

    return {
      mediaId,
      subtitleSourceId,
    };
  }

  /** Ensures upload-backed jobs always point to a stored parsed subtitle file. */
  private requireParsedFileId(job: TranslationJob): string {
    if (!job.parsedFileId) {
      throw new Error('Upload translation job is missing parsedFileId.');
    }

    return job.parsedFileId;
  }

  /** Writes a translating progress update using the shared public job status. */
  private markProgress(
    jobId: string,
    data: {
      stageLabel: string;
      progress: number;
      startedAt?: Date;
      errorMessage?: string | null;
    },
  ) {
    return this.translationJobsRepository.updateJob(jobId, {
      status: TranslationJobStatus.translating,
      stageLabel: data.stageLabel,
      progress: data.progress,
      ...(data.startedAt ? { startedAt: data.startedAt } : {}),
      ...(data.errorMessage !== undefined
        ? { errorMessage: data.errorMessage }
        : {}),
    });
  }

  /** Maps translated lines into the persisted cue payload used for preview and export. */
  private buildPersistedJobCues(
    sourceCues: SubtitleCue[],
    translatedLines: string[],
  ): PersistedJobCue[] {
    return sourceCues.map((cue, index) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      originalText: cue.text,
      translatedText: translatedLines[index] ?? cue.text,
    }));
  }

  /** Marks the job as failed while preserving a human-readable error message. */
  private markFailure(jobId: string, error: unknown) {
    return this.translationJobsRepository.updateJob(jobId, {
      status: TranslationJobStatus.failed,
      stageLabel: 'Translation failed',
      errorMessage:
        error instanceof Error ? error.message : 'Translation failed.',
    });
  }
}
