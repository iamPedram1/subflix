import { Injectable } from '@nestjs/common';
import { AppLanguage } from '@prisma/client';

import { delay } from 'common/utils/delay.util';

import { TranslationProviderPort } from 'features/translation-jobs/ports/translation-provider.port';

const translationPrefixes: Record<AppLanguage, string> = {
  en: '',
  es: 'Version espanola: ',
  ar: 'نسخة عربية: ',
  fr: 'Version francaise: ',
  de: 'Deutsche Fassung: ',
  pt: 'Versao portuguesa: ',
  ja: '日本語版: ',
  ko: '한국어 버전: ',
  hi: 'हिंदी संस्करण: ',
  tr: 'Turkce surum: ',
  fa: 'Persian version: ',
  zh: 'Chinese version: ',
};

@Injectable()
/** Mock translation adapter that mimics latency and deterministic translated output. */
export class MockTranslationProvider implements TranslationProviderPort {
  /** Translates normalized cues into a prefixed mock language variant. */
  async translate(params: {
    title: string;
    targetLanguage: AppLanguage;
    cues: { text: string }[];
  }): Promise<string[]> {
    await delay(450);

    if (params.title.toLowerCase().includes('error')) {
      throw new Error('Mock translation provider failed.');
    }

    const prefix = translationPrefixes[params.targetLanguage];
    return params.cues.map((cue) =>
      params.targetLanguage === 'en' ? cue.text : `${prefix}${cue.text}`,
    );
  }
}
