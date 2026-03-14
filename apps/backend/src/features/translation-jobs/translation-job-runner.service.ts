import { Inject, Injectable, Logger } from '@nestjs/common';
import {
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import { delay } from 'common/utils/delay.util';
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

type PersistedCatalogSubtitleSourceRef = {
  subtitleSourceId?: string;
  seasonNumber?: unknown;
  episodeNumber?: unknown;
  releaseHint?: unknown;
  quality?: unknown;
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

type PersistedCatalogSourceMetadata = {
  quality: PersistedSubtitleQualityMetadata;
  timing: PersistedSubtitleTimingMetadata | null;
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
  private readonly logger = new Logger(TranslationJobRunnerService.name);
  private readonly scheduledJobIds = new Set<string>();
  private readonly activeJobIds = new Set<string>();

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly catalogService: CatalogService,
    private readonly subtitleQualityEvaluationService: SubtitleQualityEvaluationService,
    private readonly subtitleTimingAlignmentService: SubtitleTimingAlignmentService,
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

    try {
      const job =
        await this.translationJobsRepository.claimQueuedJobForRunner(jobId);
      if (!job) {
        return;
      }

      try {
        const loadedSourceCues = await this.loadSourceCues(job);
        const sourceCues =
          job.sourceType === TranslationSourceType.catalog
            ? await this.applyCatalogQualityAndAlignment(job, loadedSourceCues)
            : loadedSourceCues;

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
    } finally {
      this.activeJobIds.delete(jobId);
    }
  }

  /** Loads normalized source cues for either uploaded or catalog-backed jobs. */
  private async loadSourceCues(job: TranslationJob): Promise<SubtitleCue[]> {
    if (job.sourceType === TranslationSourceType.upload) {
      return this.loadUploadedSourceCues(job);
    }

    const references = this.getCatalogReferences(job);
    const reusable =
      await this.translationJobsRepository.findReusableCatalogSourceCues({
        clientDeviceId: job.clientDeviceId,
        mediaId: references.mediaId,
        subtitleSourceId: references.subtitleSourceId,
        excludeJobId: job.id,
      });

    if (reusable.length > 0) {
      return reusable;
    }

    return this.catalogService.getSubtitleCues(
      references.mediaId,
      references.subtitleSourceId,
    );
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
    seasonNumber?: number;
    episodeNumber?: number;
    releaseHint?: string;
  } {
    const mediaId = (job.mediaRef as { mediaId?: string } | null)?.mediaId;
    const subtitleSourceRef =
      job.subtitleSourceRef as PersistedCatalogSubtitleSourceRef | null;
    const subtitleSourceId = subtitleSourceRef?.subtitleSourceId;

    if (!mediaId || !subtitleSourceId) {
      throw new Error('Catalog translation job is missing source references.');
    }

    return {
      mediaId,
      subtitleSourceId,
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

  private async applyCatalogQualityAndAlignment(
    job: TranslationJob,
    cues: SubtitleCue[],
  ) {
    const references = this.getCatalogReferences(job);
    const resolvedMedia = await this.catalogService.findById(
      references.mediaId,
    );
    const media = resolvedMedia ?? this.buildFallbackMedia(job, references);

    const evaluation = this.subtitleQualityEvaluationService.evaluateCatalogJob(
      {
        media,
        cues,
        sourceName: job.sourceName,
        subtitleSourceId: references.subtitleSourceId,
        releaseHint: references.releaseHint,
        seasonNumber: references.seasonNumber,
        episodeNumber: references.episodeNumber,
      },
    );

    if (evaluation.shouldBlockAutoUse) {
      await this.persistCatalogSourceMetadata(job, cues, {
        quality: evaluation,
        timing: null,
      });
      throw new Error(
        'The selected subtitle file appears invalid or unusable. Please choose a different subtitle source.',
      );
    }

    const alignment =
      this.subtitleTimingAlignmentService.alignCatalogCues(cues);

    await this.persistCatalogSourceMetadata(job, alignment.cues, {
      quality: evaluation,
      timing: alignment.analysis,
    });

    return alignment.cues;
  }

  private persistCatalogSourceMetadata(
    job: TranslationJob,
    cues: SubtitleCue[],
    metadata: PersistedCatalogSourceMetadata,
  ) {
    const durationMs = cues.reduce((max, cue) => Math.max(max, cue.endMs), 0);
    const existingSubtitleSourceRef =
      (job.subtitleSourceRef as Record<string, unknown> | null) ?? {};

    return this.translationJobsRepository.updateJob(job.id, {
      lineCount: cues.length,
      durationMs,
      subtitleSourceRef: {
        ...existingSubtitleSourceRef,
        quality: {
          confidenceScore: metadata.quality.confidenceScore,
          confidenceLevel: metadata.quality.confidenceLevel,
          warnings: metadata.quality.warnings,
        },
        ...(metadata.timing
          ? {
              timing: {
                detectedOffsetMs: metadata.timing.detectedOffsetMs,
                appliedCorrection: metadata.timing.appliedCorrection,
                confidence: metadata.timing.confidence,
              },
            }
          : {}),
      },
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
