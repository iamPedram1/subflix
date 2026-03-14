import { TranslationJob, TranslationJobCue } from '@prisma/client';

type TranslationJobSummarySource = Pick<
  TranslationJob,
  | 'id'
  | 'status'
  | 'stageLabel'
  | 'progress'
  | 'title'
  | 'sourceName'
  | 'sourceType'
  | 'sourceLanguage'
  | 'targetLanguage'
  | 'format'
  | 'createdAt'
  | 'updatedAt'
  | 'lineCount'
  | 'durationMs'
  | 'errorMessage'
  | 'subtitleSourceRef'
>;

type TranslationPreviewCueSource = Pick<
  TranslationJobCue,
  'cueIndex' | 'startMs' | 'endMs' | 'originalText' | 'translatedText'
>;

const toOptionalSubtitleSourceMetadataFields = (subtitleSourceRef: unknown) => {
  if (!subtitleSourceRef || typeof subtitleSourceRef !== 'object') {
    return {};
  }

  const quality = (subtitleSourceRef as { quality?: unknown }).quality;
  const timing = (subtitleSourceRef as { timing?: unknown }).timing;
  const acquisition = (subtitleSourceRef as { acquisition?: unknown })
    .acquisition;

  const fields: Record<string, unknown> = {};

  if (quality && typeof quality === 'object') {
    const candidate = quality as {
      confidenceScore?: unknown;
      confidenceLevel?: unknown;
      warnings?: unknown;
    };

    const subtitleConfidenceScore =
      typeof candidate.confidenceScore === 'number'
        ? candidate.confidenceScore
        : undefined;
    const subtitleConfidenceLevel =
      typeof candidate.confidenceLevel === 'string'
        ? candidate.confidenceLevel
        : undefined;
    const subtitleWarnings = Array.isArray(candidate.warnings)
      ? candidate.warnings.filter((warning) => typeof warning === 'string')
      : undefined;

    if (subtitleConfidenceScore !== undefined) {
      fields.subtitleConfidenceScore = subtitleConfidenceScore;
    }
    if (subtitleConfidenceLevel !== undefined) {
      fields.subtitleConfidenceLevel = subtitleConfidenceLevel;
    }
    if (subtitleWarnings !== undefined) {
      fields.subtitleWarnings = subtitleWarnings;
    }
  }

  if (timing && typeof timing === 'object') {
    const candidate = timing as {
      detectedOffsetMs?: unknown;
      confidence?: unknown;
      appliedCorrection?: unknown;
    };

    if (typeof candidate.detectedOffsetMs === 'number') {
      fields.subtitleTimingOffsetMs = candidate.detectedOffsetMs;
    }
    if (typeof candidate.confidence === 'number') {
      fields.subtitleTimingConfidence = candidate.confidence;
    }
    if (typeof candidate.appliedCorrection === 'boolean') {
      fields.subtitleTimingCorrected = candidate.appliedCorrection;
    }
  }

  if (acquisition && typeof acquisition === 'object') {
    const candidate = acquisition as {
      mode?: unknown;
      reusedExistingSubtitle?: unknown;
      reusedSubtitleConfidenceScore?: unknown;
      reusedSubtitleConfidenceLevel?: unknown;
    };

    if (typeof candidate.mode === 'string') {
      fields.subtitleAcquisitionMode = candidate.mode;
    }
    if (typeof candidate.reusedExistingSubtitle === 'boolean') {
      fields.reusedExistingSubtitle = candidate.reusedExistingSubtitle;
    }
    if (typeof candidate.reusedSubtitleConfidenceScore === 'number') {
      fields.reusedSubtitleConfidenceScore =
        candidate.reusedSubtitleConfidenceScore;
    }
    if (typeof candidate.reusedSubtitleConfidenceLevel === 'string') {
      fields.reusedSubtitleConfidenceLevel =
        candidate.reusedSubtitleConfidenceLevel;
    }
  }

  return fields;
};

/** Maps a persisted translation job into the public summary shape used by the API. */
export const toTranslationJobSummary = (job: TranslationJobSummarySource) => ({
  ...toOptionalSubtitleSourceMetadataFields(job.subtitleSourceRef),
  id: job.id,
  status: job.status,
  stageLabel: job.stageLabel,
  progress: job.progress,
  title: job.title,
  sourceName: job.sourceName,
  sourceType: job.sourceType,
  sourceLanguage: job.sourceLanguage,
  targetLanguage: job.targetLanguage,
  format: job.format,
  createdAt: job.createdAt,
  updatedAt: job.updatedAt,
  lineCount: job.lineCount,
  durationMs: job.durationMs,
  errorMessage: job.errorMessage,
});

/** Maps a persisted cue into the preview payload returned by the API. */
export const toTranslationPreviewCue = (cue: TranslationPreviewCueSource) => ({
  cueIndex: cue.cueIndex,
  startMs: cue.startMs,
  endMs: cue.endMs,
  originalText: cue.originalText,
  translatedText: cue.translatedText,
});
