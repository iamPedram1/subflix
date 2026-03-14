import {
  AppLanguage,
  supportedLanguages,
} from 'common/domain/enums/app-language.enum';

import type {
  I18nArgs,
  I18nKey,
  I18nMessageCatalog,
  SupportedLocale,
} from 'common/i18n/i18n.types';
import { AR_MESSAGES } from 'common/i18n/messages/ar.messages';
import { EN_MESSAGES } from 'common/i18n/messages/en.messages';
import { FR_MESSAGES } from 'common/i18n/messages/fr.messages';

const MESSAGE_CATALOGS: Partial<Record<SupportedLocale, I18nMessageCatalog>> = {
  [AppLanguage.English]: EN_MESSAGES,
  [AppLanguage.French]: FR_MESSAGES,
  [AppLanguage.Arabic]: AR_MESSAGES,
};

const normalizeLocaleCandidate = (value: string): string => {
  return value.trim().toLowerCase();
};

export const resolveLocaleFromAcceptLanguage = (
  headerValue: string | undefined,
): SupportedLocale => {
  if (!headerValue?.trim()) {
    return AppLanguage.English;
  }

  const candidates = headerValue
    .split(',')
    .map((part) => part.trim())
    .map((part) => {
      const [tag, ...params] = part.split(';').map((segment) => segment.trim());
      const qParam = params.find((param) => param.startsWith('q='));
      const q = qParam ? Number(qParam.slice(2)) : 1;
      const normalizedTag = normalizeLocaleCandidate(tag ?? '');
      const base = normalizedTag.split('-', 1)[0] ?? normalizedTag;

      return {
        base,
        q: Number.isFinite(q) ? q : 0,
      };
    })
    .filter((candidate) => candidate.base.length > 0)
    .sort((left, right) => right.q - left.q);

  for (const candidate of candidates) {
    const base = candidate.base as SupportedLocale;
    if (supportedLanguages.includes(base)) {
      return base;
    }
  }

  return AppLanguage.English;
};

const formatTemplate = (template: string, args?: I18nArgs): string => {
  if (!args) {
    return template;
  }

  return template.replace(/\{(\w+)\}/g, (match, key: string) => {
    const value = args[key];
    return value === undefined ? match : String(value);
  });
};

export const isI18nKey = (key: string): key is I18nKey => {
  return key in EN_MESSAGES;
};

export const translate = (
  locale: SupportedLocale,
  key: I18nKey,
  args?: I18nArgs,
): string => {
  const catalog = MESSAGE_CATALOGS[locale] ?? EN_MESSAGES;
  const template =
    catalog[key] ?? EN_MESSAGES[key] ?? EN_MESSAGES['errors.internal_error'];
  return formatTemplate(template, args);
};
