import type { I18nMessageCatalog } from 'common/i18n/i18n.types';

export const ZH_MESSAGES: I18nMessageCatalog = {
  'errors.internal_error': '发生意外错误。',
  'errors.http_error': '发生意外的 HTTP 错误。',
  'errors.payload_too_large': '字幕文件超出上传限制。',
  'errors.upload_invalid': '上传的字幕文件无效。',
  'errors.rate_limited': '请求过多，请稍后重试。',
  'errors.db.unique_constraint': '违反了唯一记录约束。',
  'errors.db.invalid_reference': '关联记录引用无效。',
  'errors.subtitles.file_required': '字幕文件是必需的。',
  'errors.subtitles.upload_limit_exceeded': '字幕文件超出上传限制。',
  'errors.subtitles.no_valid_cues': '字幕文件不包含有效的字幕条目。',
  'errors.subtitles.invalid_timestamp': '无效的字幕时间戳：{value}',
  'errors.subtitles.unsupported_file_type':
    '不支持的文件类型，仅接受 .srt 和 .vtt 文件。',
  'errors.catalog.invalid_media_id': '请求的媒体 ID 无效。',
  'errors.catalog.not_found': '未找到请求的目录标题。',
  'errors.catalog.subtitles_unavailable': '该标题的字幕来源暂时不可用。',
  'errors.catalog.tv_only_episode_scope':
    'seasonNumber 和 episodeNumber 仅支持电视标题。',
  'errors.translation.export_requires_completion': '只有已完成的翻译任务才能导出。',
  'errors.translation.missing_upload_reference':
    '上传字幕翻译需要提供 parsedFileId。',
  'errors.translation.missing_catalog_reference':
    '目录翻译需要提供 mediaId 和 subtitleSourceId。',
  'errors.translation.media_not_found': '未找到请求的媒体标题。',
  'errors.translation.subtitle_source_not_found': '未找到请求的字幕来源。',
};
