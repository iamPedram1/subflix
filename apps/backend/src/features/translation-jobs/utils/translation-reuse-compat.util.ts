import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

export type TranslatedCue = Pick<
  SubtitleCue,
  'cueIndex' | 'startMs' | 'endMs'
> & {
  translatedText: string;
};

export type TranslationReuseCompatibility = {
  compatible: boolean;
  reason: string;
};

export const checkTranslationReuseCompatibility = (
  currentCues: SubtitleCue[],
  candidateCues: Array<TranslatedCue>,
): TranslationReuseCompatibility => {
  if (currentCues.length === 0) {
    return { compatible: false, reason: 'current_cues_empty' };
  }

  if (candidateCues.length === 0) {
    return { compatible: false, reason: 'candidate_cues_empty' };
  }

  if (currentCues.length !== candidateCues.length) {
    return { compatible: false, reason: 'cue_count_mismatch' };
  }

  for (let index = 0; index < currentCues.length; index += 1) {
    const current = currentCues[index];
    const candidate = candidateCues[index];

    if (
      current.cueIndex !== candidate.cueIndex ||
      current.startMs !== candidate.startMs ||
      current.endMs !== candidate.endMs
    ) {
      return { compatible: false, reason: 'cue_timing_mismatch' };
    }

    if (!candidate.translatedText.trim()) {
      return { compatible: false, reason: 'missing_translated_text' };
    }
  }

  return { compatible: true, reason: 'compatible' };
};
