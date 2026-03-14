import { SubtitleFormat } from '@prisma/client';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

export type SubtitleAcquisitionMode =
  | 'existing_target_subtitle'
  | 'ai_translation';

export type SubtitleAcquisitionDecision = {
  acquisitionMode: SubtitleAcquisitionMode;
  subtitleSourceIdToUse: string;
  selectedLanguageCode: string;
  requestedTargetLanguage: string;
  reusedExistingSubtitle: boolean;
  reason: string;
  subtitleSourceLabel?: string;
  subtitleSourceFormat?: SubtitleFormat;
  reusedSubtitleQuality?: {
    confidenceScore: number;
    confidenceLevel: 'high' | 'medium' | 'low';
    warnings: string[];
  };
  cues?: SubtitleCue[];
};
