import { AppLanguage } from '@prisma/client';
import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

export const TRANSLATION_PROVIDER_PORT = Symbol('TRANSLATION_PROVIDER_PORT');

export interface TranslationProviderPort {
  translate(params: {
    title: string;
    targetLanguage: AppLanguage;
    cues: SubtitleCue[];
  }): Promise<string[]>;
}
