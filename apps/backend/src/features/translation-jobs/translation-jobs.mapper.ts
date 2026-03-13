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
>;

type TranslationPreviewCueSource = Pick<
  TranslationJobCue,
  'cueIndex' | 'startMs' | 'endMs' | 'originalText' | 'translatedText'
>;

/** Maps a persisted translation job into the public summary shape used by the API. */
export const toTranslationJobSummary = (job: TranslationJobSummarySource) => ({
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
