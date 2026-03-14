import type { I18nMessageCatalog } from 'common/i18n/i18n.types';

export const EN_MESSAGES: I18nMessageCatalog = {
  'errors.internal_error': 'An unexpected error occurred.',
  'errors.http_error': 'An unexpected HTTP error occurred.',
  'errors.payload_too_large': 'Subtitle file exceeds the upload limit.',
  'errors.upload_invalid': 'The uploaded subtitle file is invalid.',
  'errors.rate_limited': 'Too many requests. Please try again later.',
  'errors.db.unique_constraint': 'A unique record constraint was violated.',
  'errors.db.invalid_reference': 'A related record reference is invalid.',
  'errors.subtitles.file_required': 'A subtitle file is required.',
  'errors.subtitles.upload_limit_exceeded':
    'Subtitle file exceeds the upload limit.',
  'errors.subtitles.no_valid_cues':
    'The subtitle file did not contain valid cues.',
  'errors.subtitles.invalid_timestamp': 'Invalid subtitle timestamp: {value}',
  'errors.subtitles.unsupported_file_type':
    'Unsupported file type. Only .srt and .vtt files are accepted.',
  'errors.catalog.invalid_media_id':
    'The requested catalog media id is invalid.',
  'errors.catalog.not_found': 'The requested catalog title was not found.',
  'errors.catalog.subtitles_unavailable':
    'Subtitle sources are temporarily unavailable for this title.',
  'errors.catalog.tv_only_episode_scope':
    'seasonNumber and episodeNumber are only supported for TV titles.',
  'errors.translation.export_requires_completion':
    'Only completed translation jobs can be exported.',
  'errors.translation.missing_upload_reference':
    'parsedFileId is required for uploaded subtitle translations.',
  'errors.translation.missing_catalog_reference':
    'mediaId and subtitleSourceId are required for catalog translations.',
  'errors.translation.media_not_found':
    'The requested media title was not found.',
  'errors.translation.subtitle_source_not_found':
    'The requested subtitle source was not found.',
};
