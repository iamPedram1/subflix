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

const toOptionalSubtitleQualityFields = (subtitleSourceRef: unknown) => {
  if (!subtitleSourceRef || typeof subtitleSourceRef !== 'object') {
    return {};
  }

  const quality = (subtitleSourceRef as { quality?: unknown }).quality;
  if (!quality || typeof quality !== 'object') {
    return {};
  }

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

  return {
    ...(subtitleConfidenceScore !== undefined
      ? { subtitleConfidenceScore }
      : {}),
    ...(subtitleConfidenceLevel !== undefined
      ? { subtitleConfidenceLevel }
      : {}),
    ...(subtitleWarnings !== undefined ? { subtitleWarnings } : {}),
  };
};

/** Maps a persisted translation job into the public summary shape used by the API. */
export const toTranslationJobSummary = (job: TranslationJobSummarySource) => ({
  ...toOptionalSubtitleQualityFields(job.subtitleSourceRef),
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
