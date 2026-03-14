import type { I18nMessageCatalog } from 'common/i18n/i18n.types';

export const AR_MESSAGES: I18nMessageCatalog = {
  'errors.internal_error': 'حدث خطأ غير متوقع.',
  'errors.http_error': 'حدث خطأ HTTP غير متوقع.',
  'errors.payload_too_large': 'حجم ملف الترجمة يتجاوز حد الرفع.',
  'errors.upload_invalid': 'ملف الترجمة المرفوع غير صالح.',
  'errors.rate_limited': 'طلبات كثيرة جدا. يرجى المحاولة لاحقا.',
  'errors.db.unique_constraint': 'تم انتهاك قيد فريد في قاعدة البيانات.',
  'errors.db.invalid_reference': 'مرجع سجل مرتبط غير صالح.',
  'errors.subtitles.file_required': 'ملف الترجمة مطلوب.',
  'errors.subtitles.upload_limit_exceeded': 'حجم ملف الترجمة يتجاوز حد الرفع.',
  'errors.subtitles.no_valid_cues': 'لم يحتوي ملف الترجمة على مقاطع صالحة.',
  'errors.subtitles.invalid_timestamp': 'طابع زمني غير صالح: {value}',
  'errors.subtitles.unsupported_file_type':
    'نوع الملف غير مدعوم. يتم قبول ملفات .srt و .vtt فقط.',
  'errors.catalog.invalid_media_id': 'معرف الوسائط المطلوب غير صالح.',
  'errors.catalog.not_found': 'لم يتم العثور على العنوان المطلوب.',
  'errors.catalog.subtitles_unavailable':
    'مصادر الترجمة غير متاحة مؤقتا لهذا العنوان.',
  'errors.catalog.tv_only_episode_scope':
    'seasonNumber و episodeNumber مدعومان لعناوين التلفاز فقط.',
  'errors.translation.export_requires_completion':
    'يمكن تصدير مهام الترجمة المكتملة فقط.',
  'errors.translation.missing_upload_reference':
    'parsedFileId مطلوب لترجمات ملفات الترجمة المرفوعة.',
  'errors.translation.missing_catalog_reference':
    'mediaId و subtitleSourceId مطلوبان لترجمات الكتالوج.',
  'errors.translation.media_not_found': 'لم يتم العثور على الوسائط المطلوبة.',
  'errors.translation.subtitle_source_not_found':
    'لم يتم العثور على مصدر الترجمة المطلوب.',
};
