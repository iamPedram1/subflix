import { Injectable } from '@nestjs/common';
import { AppLanguage } from '@prisma/client';

import { TranslationProviderPort } from '../ports/translation-provider.port';

const wait = async (milliseconds: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));

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
};

@Injectable()
export class MockTranslationProvider implements TranslationProviderPort {
  async translate(params: {
    title: string;
    targetLanguage: AppLanguage;
    cues: { text: string }[];
  }): Promise<string[]> {
    await wait(450);

    if (params.title.toLowerCase().includes('error')) {
      throw new Error('Mock translation provider failed.');
    }

    const prefix = translationPrefixes[params.targetLanguage];
    return params.cues.map((cue) =>
      params.targetLanguage === 'en' ? cue.text : `${prefix}${cue.text}`,
    );
  }
}
