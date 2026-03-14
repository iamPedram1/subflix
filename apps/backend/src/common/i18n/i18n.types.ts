import { AppLanguage } from 'common/domain/enums/app-language.enum';

export type SupportedLocale = AppLanguage;

export type I18nArgs = Record<string, string | number>;

export type I18nKey =
  | 'errors.internal_error'
  | 'errors.http_error'
  | 'errors.payload_too_large'
  | 'errors.upload_invalid'
  | 'errors.rate_limited'
  | 'errors.db.unique_constraint'
  | 'errors.db.invalid_reference'
  | 'errors.subtitles.file_required'
  | 'errors.subtitles.upload_limit_exceeded'
  | 'errors.subtitles.no_valid_cues'
  | 'errors.subtitles.invalid_timestamp'
  | 'errors.subtitles.unsupported_file_type'
  | 'errors.catalog.invalid_media_id'
  | 'errors.catalog.not_found'
  | 'errors.catalog.subtitles_unavailable'
  | 'errors.catalog.tv_only_episode_scope'
  | 'errors.translation.export_requires_completion'
  | 'errors.translation.missing_upload_reference'
  | 'errors.translation.missing_catalog_reference'
  | 'errors.translation.media_not_found'
  | 'errors.translation.subtitle_source_not_found';

export type I18nMessageCatalog = Record<I18nKey, string>;
