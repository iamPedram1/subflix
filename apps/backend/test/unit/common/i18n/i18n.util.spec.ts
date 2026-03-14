import { describe, expect, it } from 'vitest';

import { AppLanguage } from 'common/domain/enums/app-language.enum';
import {
  resolveLocaleFromAcceptLanguage,
  translate,
} from 'common/i18n/i18n.util';

describe('i18n.util', () => {
  describe('resolveLocaleFromAcceptLanguage', () => {
    it('falls back to English when header is missing', () => {
      expect(resolveLocaleFromAcceptLanguage(undefined)).toBe(
        AppLanguage.English,
      );
    });

    it('resolves a supported base language from region tags', () => {
      expect(resolveLocaleFromAcceptLanguage('fr-CA,fr;q=0.8,en;q=0.7')).toBe(
        AppLanguage.French,
      );
    });

    it('resolves the highest-q supported language', () => {
      expect(resolveLocaleFromAcceptLanguage('zz;q=1,ar;q=0.9,en;q=0.8')).toBe(
        AppLanguage.Arabic,
      );
    });

    it('falls back to English when nothing matches', () => {
      expect(resolveLocaleFromAcceptLanguage('zz,xx;q=0.2')).toBe(
        AppLanguage.English,
      );
    });
  });

  describe('translate', () => {
    it('uses English strings when a locale catalog is missing', () => {
      expect(translate(AppLanguage.Spanish, 'errors.rate_limited')).toBe(
        'Too many requests. Please try again later.',
      );
    });
  });
});
