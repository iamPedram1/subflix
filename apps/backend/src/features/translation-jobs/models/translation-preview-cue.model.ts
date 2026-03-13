export type TranslationPreviewCue = {
  cueIndex: number;
  startMs: number;
  endMs: number;
  originalText: string;
  translatedText: string | null;
};
