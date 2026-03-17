import { Inject, Injectable } from '@nestjs/common';
import {
  Prisma,
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { delay } from 'common/utils/delay.util';
import { StructuredLogger } from 'common/utils/structured-logger';
import { timed } from 'common/utils/timed.util';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';
import { CatalogService } from 'features/catalog/catalog.service';
import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { SubtitleTimingAlignmentService } from 'features/catalog/subtitle-timing-alignment.service';
import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';

import {
  TRANSLATION_PROVIDER_PORT,
  TranslationProviderPort,
} from 'features/translation-jobs/ports/translation-provider.port';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { SubtitleAcquisitionStrategyService } from 'features/translation-jobs/subtitle-acquisition-strategy.service';
import { SubtitleAcquisitionDecision } from 'features/translation-jobs/models/subtitle-acquisition-decision.model';
import { TranslationReuseService } from 'features/translation-jobs/translation-reuse.service';
import {
  applyAttemptFailed,
  applyAttemptStarted,
  parseJobRetryMeta,
} from 'features/translation-jobs/utils/job-staleness.util';

type PersistedCatalogSubtitleSourceRef = {
  subtitleSourceId?: string;
  fallbackSubtitleSourceId?: unknown;
  selectedSubtitleSourceId?: unknown;
  seasonNumber?: unknown;
  episodeNumber?: unknown;
  releaseHint?: unknown;
  acquisition?: unknown;
  quality?: unknown;
  timing?: unknown;
};

type PersistedSubtitleQualityMetadata = {
  confidenceScore: number;
  confidenceLevel: string;
  warnings: string[];
};

type PersistedSubtitleTimingMetadata = {
  detectedOffsetMs: number;
  appliedCorrection: boolean;
  confidence: number;
};

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
  private readonly log = new StructuredLogger(TranslationJobRunnerService.name);
  private readonly scheduledJobIds = new Set<string>();
  private readonly activeJobIds = new Set<string>();

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly catalogService: CatalogService,
    private readonly subtitleQualityEvaluationService: SubtitleQualityEvaluationService,
    private readonly subtitleTimingAlignmentService: SubtitleTimingAlignmentService,
    private readonly subtitleAcquisitionStrategyService: SubtitleAcquisitionStrategyService,
    private readonly translationReuseService: TranslationReuseService,
    @Inject(TRANSLATION_PROVIDER_PORT)
    private readonly translationProvider: TranslationProviderPort,
  ) {}

  /** Schedules a persisted job to run after the request lifecycle completes. */
  schedule(jobId: string): void {
    if (this.scheduledJobIds.has(jobId) || this.activeJobIds.has(jobId)) {
      return;
    }

    this.scheduledJobIds.add(jobId);
    setTimeout(() => {
      this.scheduledJobIds.delete(jobId);
      void this.run(jobId);
    }, 0);
  }

  /** Processes a single translation job from queued state to completion or failure. */
  async run(jobId: string): Promise<void> {
    if (this.activeJobIds.has(jobId)) {
      return;
    }

    this.activeJobIds.add(jobId);
    const startedAt = Date.now();

    try {
      const job =
        await this.translationJobsRepository.claimQueuedJobForRunner(jobId);
      if (!job) {
        return;
      }

      // Increment attempt count now that the job has been claimed.
      const claimTime = new Date();
      const currentMeta = parseJobRetryMeta(job.jobMeta);
      const attemptMeta = applyAttemptStarted(currentMeta, claimTime);
      await this.translationJobsRepository.updateJob(jobId, {
        jobMeta: attemptMeta as unknown as Prisma.InputJsonValue,
      });

      this.log.info('translation.attempt.started', {
        jobId,
        attemptCount: attemptMeta.attemptCount,
        recoveredFromStall: attemptMeta.recoveredFromStall ?? false,
      });

      this.log.info('translation.started', {
        jobId,
        sourceType: job.sourceType,
        deviceId: job.clientDeviceId,
        targetLanguage: job.targetLanguage,
      });

      try {
        if (job.sourceType === TranslationSourceType.catalog) {
          await this.runCatalogJob(job);

          this.log.info('translation.completed', {
            jobId,
            sourceType: job.sourceType,
            durationMs: Date.now() - startedAt,
          });

          return;
        }

        const sourceCues = await this.loadUploadedSourceCues(job);

        await delay(250);
        await this.markProgress(jobId, {
          stageLabel: 'Translating subtitle lines',
          progress: 0.56,
        });

        const { result: translatedLines, durationMs: translationDurationMs } =
          await timed(() =>
            this.translationProvider.translate({
              title: job.title,
              targetLanguage: job.targetLanguage,
              cues: sourceCues,
            }),
          );

        this.log.info('translation.provider.completed', {
          jobId,
          cueCount: sourceCues.length,
          durationMs: translationDurationMs,
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

        this.log.info('translation.completed', {
          jobId,
          sourceType: job.sourceType,
          durationMs: Date.now() - startedAt,
        });
      } catch (error) {
        const failedAt = new Date();
        const failedMeta = applyAttemptFailed(
          attemptMeta,
          'execution_error',
          failedAt,
        );

        this.log.error('translation.failed', {
          jobId,
          sourceType: job.sourceType,
          errorType:
            error instanceof Error ? error.constructor.name : typeof error,
          message:
            error instanceof Error ? error.message : 'Translation failed.',
          durationMs: Date.now() - startedAt,
          attemptCount: failedMeta.attemptCount,
        });

        await this.markFailure(jobId, error, failedMeta);
      }
    } finally {
      this.activeJobIds.delete(jobId);
    }
  }

  private async runCatalogJob(job: TranslationJob): Promise<void> {
    const references = this.getCatalogReferences(job);
    const fallbackSubtitleSourceId = references.fallbackSubtitleSourceId;

    const decision =
      await this.subtitleAcquisitionStrategyService.decideCatalogAcquisition({
        mediaId: references.mediaId,
        fallbackSubtitleSourceId,
        targetLanguage: job.targetLanguage,
        seasonNumber: references.seasonNumber,
        episodeNumber: references.episodeNumber,
        releaseHint: references.releaseHint,
      });

    this.log.info('subtitle.acquisition.decision', {
      jobId: job.id,
      mediaId: references.mediaId,
      mode: decision.acquisitionMode,
      reason: decision.reason,
      subtitleSourceIdToUse: decision.subtitleSourceIdToUse,
      reusedExistingSubtitle: decision.reusedExistingSubtitle,
    });

    if (decision.acquisitionMode === 'existing_target_subtitle') {
      await this.completeCatalogJobWithReuse(job, references, decision);
      return;
    }

    await this.completeCatalogJobWithTranslation(job, references, decision);
  }

  private async completeCatalogJobWithReuse(
    job: TranslationJob,
    references: {
      mediaId: string;
      subtitleSourceId: string;
      fallbackSubtitleSourceId: string;
      seasonNumber?: number;
      episodeNumber?: number;
      releaseHint?: string;
    },
    decision: SubtitleAcquisitionDecision,
  ) {
    const cues =
      decision.cues ??
      (await this.catalogService.getSubtitleCues(
        references.mediaId,
        decision.subtitleSourceIdToUse,
      ));

    const media =
      (await this.catalogService.findById(references.mediaId)) ??
      this.buildFallbackMedia(job, references);

    const evaluation = this.subtitleQualityEvaluationService.evaluateCatalogJob(
      {
        media,
        cues,
        sourceName: decision.subtitleSourceLabel ?? job.sourceName,
        subtitleSourceId: decision.subtitleSourceIdToUse,
        releaseHint: references.releaseHint,
        seasonNumber: references.seasonNumber,
        episodeNumber: references.episodeNumber,
        expectedLanguageCode: decision.selectedLanguageCode,
      },
    );

    this.log.info('subtitle.quality.evaluated', {
      jobId: job.id,
      subtitleSourceId: decision.subtitleSourceIdToUse,
      confidenceScore: evaluation.confidenceScore,
      confidenceLevel: evaluation.confidenceLevel,
      warnings: evaluation.warnings,
      blocked: evaluation.shouldBlockAutoUse,
    });

    if (evaluation.shouldBlockAutoUse) {
      await this.persistCatalogAcquisitionResult(job, {
        cues,
        references,
        decision,
        quality: evaluation,
        timing: null,
        sourceName: decision.subtitleSourceLabel,
        format: decision.subtitleSourceFormat,
        sourceLanguage: job.targetLanguage,
      });
      throw new Error(
        'The selected subtitle file appears invalid or unusable. Please choose a different subtitle source.',
      );
    }

    const alignment =
      this.subtitleTimingAlignmentService.alignCatalogCues(cues);

    this.log.info('subtitle.timing.aligned', {
      jobId: job.id,
      detectedOffsetMs: alignment.analysis.detectedOffsetMs,
      appliedCorrection: alignment.analysis.appliedCorrection,
      confidence: alignment.analysis.confidence,
    });

    await this.persistCatalogAcquisitionResult(job, {
      cues: alignment.cues,
      references,
      decision,
      quality: evaluation,
      timing: alignment.analysis,
      sourceName: decision.subtitleSourceLabel,
      format: decision.subtitleSourceFormat,
      sourceLanguage: job.targetLanguage,
    });

    await delay(80);
    await this.markProgress(job.id, {
      stageLabel: 'Reusing existing subtitle',
      progress: 0.7,
    });

    await delay(120);
    await this.markProgress(job.id, {
      stageLabel: 'Building preview and export payloads',
      progress: 0.86,
    });

    await this.translationJobsRepository.replaceJobCues(
      job.id,
      this.buildReuseJobCues(alignment.cues),
    );

    await this.translationJobsRepository.updateJob(job.id, {
      status: TranslationJobStatus.completed,
      stageLabel: 'Subtitle ready',
      progress: 1,
      completedAt: new Date(),
    });
  }

  private async completeCatalogJobWithTranslation(
    job: TranslationJob,
    references: {
      mediaId: string;
      subtitleSourceId: string;
      fallbackSubtitleSourceId: string;
      seasonNumber?: number;
      episodeNumber?: number;
      releaseHint?: string;
    },
    decision: SubtitleAcquisitionDecision,
  ) {
    const subtitleSourceIdToTranslate = decision.subtitleSourceIdToUse;

    const loadedSourceCues = await this.loadCatalogSourceCues(job, {
      mediaId: references.mediaId,
      subtitleSourceId: subtitleSourceIdToTranslate,
    });

    const media =
      (await this.catalogService.findById(references.mediaId)) ??
      this.buildFallbackMedia(job, references);

    const evaluation = this.subtitleQualityEvaluationService.evaluateCatalogJob(
      {
        media,
        cues: loadedSourceCues,
        sourceName: job.sourceName,
        subtitleSourceId: subtitleSourceIdToTranslate,
        releaseHint: references.releaseHint,
        seasonNumber: references.seasonNumber,
        episodeNumber: references.episodeNumber,
        expectedLanguageCode: 'en',
      },
    );

    this.log.info('subtitle.quality.evaluated', {
      jobId: job.id,
      subtitleSourceId: subtitleSourceIdToTranslate,
      confidenceScore: evaluation.confidenceScore,
      confidenceLevel: evaluation.confidenceLevel,
      warnings: evaluation.warnings,
      blocked: evaluation.shouldBlockAutoUse,
    });

    if (evaluation.shouldBlockAutoUse) {
      await this.persistCatalogAcquisitionResult(job, {
        cues: loadedSourceCues,
        references,
        decision,
        quality: evaluation,
        timing: null,
        sourceLanguage: 'en',
      });
      throw new Error(
        'The selected subtitle file appears invalid or unusable. Please choose a different subtitle source.',
      );
    }

    const alignment =
      this.subtitleTimingAlignmentService.alignCatalogCues(loadedSourceCues);

    this.log.info('subtitle.timing.aligned', {
      jobId: job.id,
      detectedOffsetMs: alignment.analysis.detectedOffsetMs,
      appliedCorrection: alignment.analysis.appliedCorrection,
      confidence: alignment.analysis.confidence,
    });

    const reuseDecision =
      await this.translationReuseService.decideCatalogTranslationReuse({
        clientDeviceId: job.clientDeviceId,
        subtitleSourceId: subtitleSourceIdToTranslate,
        targetLanguage: job.targetLanguage,
        alignedCues: alignment.cues,
        excludeJobId: job.id,
      });

    await this.persistCatalogAcquisitionResult(job, {
      cues: alignment.cues,
      references,
      decision,
      quality: evaluation,
      timing: alignment.analysis,
      sourceLanguage: 'en',
      ...(reuseDecision.reuseAllowed && reuseDecision.reusableJobId
        ? {
            translationReuse: {
              reused: true,
              reusedFromJobId: reuseDecision.reusableJobId,
            },
          }
        : {}),
    });

    if (
      reuseDecision.reuseAllowed &&
      reuseDecision.reusableJobId &&
      reuseDecision.translatedCues
    ) {
      await delay(120);
      await this.markProgress(job.id, {
        stageLabel: 'Reusing previous translation',
        progress: 0.62,
      });

      await delay(140);
      await this.markProgress(job.id, {
        stageLabel: 'Building preview and export payloads',
        progress: 0.86,
      });

      await this.translationJobsRepository.replaceJobCues(
        job.id,
        this.buildReusedTranslationJobCues(
          alignment.cues,
          reuseDecision.translatedCues,
        ),
      );

      await this.translationJobsRepository.updateJob(job.id, {
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        progress: 1,
        completedAt: new Date(),
      });

      return;
    }

    await delay(250);
    await this.markProgress(job.id, {
      stageLabel: 'Translating subtitle lines',
      progress: 0.56,
    });

    const { result: translatedLines, durationMs: translationDurationMs } =
      await timed(() =>
        this.translationProvider.translate({
          title: job.title,
          targetLanguage: job.targetLanguage,
          cues: alignment.cues,
        }),
      );

    this.log.info('translation.provider.completed', {
      jobId: job.id,
      cueCount: alignment.cues.length,
      durationMs: translationDurationMs,
    });

    await delay(220);
    await this.markProgress(job.id, {
      stageLabel: 'Building preview and export payloads',
      progress: 0.86,
    });

    await this.translationJobsRepository.replaceJobCues(
      job.id,
      this.buildPersistedJobCues(alignment.cues, translatedLines),
    );

    await this.translationJobsRepository.updateJob(job.id, {
      status: TranslationJobStatus.completed,
      stageLabel: 'Translation ready',
      progress: 1,
      completedAt: new Date(),
    });
  }

  /** Loads normalized source cues for either uploaded or catalog-backed jobs. */
  private async loadCatalogSourceCues(
    job: TranslationJob,
    params: { mediaId: string; subtitleSourceId: string },
  ): Promise<SubtitleCue[]> {
    const reusable =
      await this.translationJobsRepository.findReusableCatalogSourceCues({
        clientDeviceId: job.clientDeviceId,
        mediaId: params.mediaId,
        subtitleSourceId: params.subtitleSourceId,
        excludeJobId: job.id,
      });

    if (reusable.length > 0) {
      this.log.info('subtitle.source.cues.reused', {
        jobId: job.id,
        mediaId: params.mediaId,
        subtitleSourceId: params.subtitleSourceId,
        cueCount: reusable.length,
      });
      return reusable;
    }

    const { result: cues, durationMs } = await timed(() =>
      this.catalogService.getSubtitleCues(
        params.mediaId,
        params.subtitleSourceId,
      ),
    );

    this.log.info('subtitle.source.cues.downloaded', {
      jobId: job.id,
      mediaId: params.mediaId,
      subtitleSourceId: params.subtitleSourceId,
      cueCount: cues.length,
      durationMs,
    });

    return cues;
  }

  /** Loads normalized cues from a previously parsed upload owned by the device. */
  private async loadUploadedSourceCues(
    job: TranslationJob,
  ): Promise<SubtitleCue[]> {
    return this.subtitlesRepository.listOwnedParsedFileCues({
      clientDeviceId: job.clientDeviceId,
      parsedFileId: this.requireParsedFileId(job),
    });
  }

  /** Extracts and validates the catalog references needed to replay a catalog job. */
  private getCatalogReferences(job: TranslationJob): {
    mediaId: string;
    subtitleSourceId: string;
    fallbackSubtitleSourceId: string;
    selectedSubtitleSourceId?: string;
    seasonNumber?: number;
    episodeNumber?: number;
    releaseHint?: string;
  } {
    const mediaId = (job.mediaRef as { mediaId?: string } | null)?.mediaId;
    const subtitleSourceRef =
      job.subtitleSourceRef as PersistedCatalogSubtitleSourceRef | null;
    const subtitleSourceId = subtitleSourceRef?.subtitleSourceId;
    const fallbackSubtitleSourceId =
      typeof subtitleSourceRef?.fallbackSubtitleSourceId === 'string'
        ? subtitleSourceRef.fallbackSubtitleSourceId
        : subtitleSourceId;
    const selectedSubtitleSourceId =
      typeof subtitleSourceRef?.selectedSubtitleSourceId === 'string'
        ? subtitleSourceRef.selectedSubtitleSourceId
        : undefined;

    if (!mediaId || !subtitleSourceId || !fallbackSubtitleSourceId) {
      throw new Error('Catalog translation job is missing source references.');
    }

    return {
      mediaId,
      subtitleSourceId,
      fallbackSubtitleSourceId,
      selectedSubtitleSourceId,
      seasonNumber:
        typeof subtitleSourceRef?.seasonNumber === 'number'
          ? subtitleSourceRef.seasonNumber
          : undefined,
      episodeNumber:
        typeof subtitleSourceRef?.episodeNumber === 'number'
          ? subtitleSourceRef.episodeNumber
          : undefined,
      releaseHint:
        typeof subtitleSourceRef?.releaseHint === 'string'
          ? subtitleSourceRef.releaseHint
          : undefined,
    };
  }

  private buildReuseJobCues(cues: SubtitleCue[]): PersistedJobCue[] {
    return cues.map((cue) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      originalText: cue.text,
      translatedText: cue.text,
    }));
  }

  private persistCatalogAcquisitionResult(
    job: TranslationJob,
    params: {
      cues: SubtitleCue[];
      references: {
        mediaId: string;
        subtitleSourceId: string;
        fallbackSubtitleSourceId: string;
        seasonNumber?: number;
        episodeNumber?: number;
        releaseHint?: string;
      };
      decision: SubtitleAcquisitionDecision;
      quality: PersistedSubtitleQualityMetadata;
      timing: PersistedSubtitleTimingMetadata | null;
      sourceName?: string;
      format?: TranslationJob['format'];
      sourceLanguage: TranslationJob['sourceLanguage'];
      translationReuse?: {
        reused: boolean;
        reusedFromJobId: string;
      };
    },
  ) {
    const existingSubtitleSourceRef =
      (job.subtitleSourceRef as Record<string, unknown> | null) ?? {};

    const durationMs = params.cues.reduce(
      (max, cue) => Math.max(max, cue.endMs),
      0,
    );

    return this.translationJobsRepository.updateJob(job.id, {
      ...(params.sourceName ? { sourceName: params.sourceName } : {}),
      ...(params.format ? { format: params.format } : {}),
      sourceLanguage: params.sourceLanguage,
      durationMs,
      subtitleSourceRef: {
        ...existingSubtitleSourceRef,
        fallbackSubtitleSourceId: params.references.fallbackSubtitleSourceId,
        selectedSubtitleSourceId: params.decision.subtitleSourceIdToUse,
        acquisition: {
          mode: params.decision.acquisitionMode,
          reusedExistingSubtitle: params.decision.reusedExistingSubtitle,
          requestedTargetLanguage: params.decision.requestedTargetLanguage,
          selectedLanguageCode: params.decision.selectedLanguageCode,
          reason: params.decision.reason,
          ...(params.decision.reusedSubtitleQuality
            ? {
                reusedSubtitleConfidenceScore:
                  params.decision.reusedSubtitleQuality.confidenceScore,
                reusedSubtitleConfidenceLevel:
                  params.decision.reusedSubtitleQuality.confidenceLevel,
              }
            : {}),
        },
        quality: {
          confidenceScore: params.quality.confidenceScore,
          confidenceLevel: params.quality.confidenceLevel,
          warnings: params.quality.warnings,
        },
        ...(params.timing
          ? {
              timing: {
                detectedOffsetMs: params.timing.detectedOffsetMs,
                appliedCorrection: params.timing.appliedCorrection,
                confidence: params.timing.confidence,
              },
            }
          : {}),
        ...(params.translationReuse
          ? { translationReuse: params.translationReuse }
          : {}),
      },
      lineCount: params.cues.length,
    });
  }

  private buildFallbackMedia(
    job: TranslationJob,
    references: {
      mediaId: string;
      seasonNumber?: number;
      episodeNumber?: number;
    },
  ): CatalogMediaDetails {
    const isTv =
      references.seasonNumber !== undefined ||
      references.episodeNumber !== undefined;

    return {
      id: references.mediaId,
      title: job.title,
      year: 0,
      mediaType: isTv ? SearchMediaType.Series : SearchMediaType.Movie,
      synopsis: '',
      genres: [],
      runtimeMinutes: 0,
      popularity: 0,
      providerMediaType: isTv ? 'tv' : 'movie',
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
      errorMessage?: string | null;
    },
  ) {
    return this.translationJobsRepository.updateJob(jobId, {
      status: TranslationJobStatus.translating,
      stageLabel: data.stageLabel,
      progress: data.progress,
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

  /** Marks the job as failed while preserving a human-readable error message and retry metadata. */
  private markFailure(
    jobId: string,
    error: unknown,
    meta?: import('features/translation-jobs/utils/job-staleness.util').JobRetryMeta,
  ) {
    return this.translationJobsRepository.updateJob(jobId, {
      status: TranslationJobStatus.failed,
      stageLabel: 'Translation failed',
      errorMessage:
        error instanceof Error ? error.message : 'Translation failed.',
      ...(meta ? { jobMeta: meta as unknown as Prisma.InputJsonValue } : {}),
    });
  }

  private buildReusedTranslationJobCues(
    sourceCues: SubtitleCue[],
    translatedCues: Array<{
      cueIndex: number;
      startMs: number;
      endMs: number;
      translatedText: string;
    }>,
  ): PersistedJobCue[] {
    return sourceCues.map((cue, index) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      originalText: cue.text,
      translatedText: translatedCues[index]?.translatedText ?? cue.text,
    }));
  }
}
