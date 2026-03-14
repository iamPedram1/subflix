import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

export type TranslationReuseDecision = {
  reuseAllowed: boolean;
  reusableJobId?: string;
  reuseReason?: string;
  translatedCues?: Array<
    Pick<SubtitleCue, 'cueIndex' | 'startMs' | 'endMs'> & {
      translatedText: string;
    }
  >;
};
