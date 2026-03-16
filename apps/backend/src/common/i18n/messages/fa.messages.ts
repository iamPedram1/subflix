import type { I18nMessageCatalog } from 'common/i18n/i18n.types';

export const FA_MESSAGES: I18nMessageCatalog = {
  'errors.internal_error': 'خطای غیرمنتظره‌ای رخ داد.',
  'errors.http_error': 'خطای HTTP غیرمنتظره‌ای رخ داد.',
  'errors.payload_too_large': 'حجم فایل زیرنویس از حد مجاز آپلود بیشتر است.',
  'errors.upload_invalid': 'فایل زیرنویس آپلود شده معتبر نیست.',
  'errors.rate_limited': 'درخواست‌های بیش از حد. لطفاً بعداً دوباره امتحان کنید.',
  'errors.db.unique_constraint': 'نقض محدودیت یکتا در پایگاه داده.',
  'errors.db.invalid_reference': 'مرجع رکورد مرتبط نامعتبر است.',
  'errors.subtitles.file_required': 'فایل زیرنویس الزامی است.',
  'errors.subtitles.upload_limit_exceeded':
    'حجم فایل زیرنویس از حد مجاز آپلود بیشتر است.',
  'errors.subtitles.no_valid_cues':
    'فایل زیرنویس حاوی سرنخ‌های معتبر نبود.',
  'errors.subtitles.invalid_timestamp': 'زمان‌بندی زیرنویس نامعتبر: {value}',
  'errors.subtitles.unsupported_file_type':
    'نوع فایل پشتیبانی نمی‌شود. فقط فایل‌های .srt و .vtt پذیرفته می‌شوند.',
  'errors.catalog.invalid_media_id':
    'شناسه رسانه درخواستی نامعتبر است.',
  'errors.catalog.not_found': 'عنوان درخواستی یافت نشد.',
  'errors.catalog.subtitles_unavailable':
    'منابع زیرنویس برای این عنوان موقتاً در دسترس نیستند.',
  'errors.catalog.tv_only_episode_scope':
    'seasonNumber و episodeNumber فقط برای عناوین تلویزیونی پشتیبانی می‌شوند.',
  'errors.translation.export_requires_completion':
    'فقط کارهای ترجمه تکمیل‌شده قابل صدور هستند.',
  'errors.translation.missing_upload_reference':
    'parsedFileId برای ترجمه‌های فایل زیرنویس آپلودشده الزامی است.',
  'errors.translation.missing_catalog_reference':
    'mediaId و subtitleSourceId برای ترجمه‌های کاتالوگ الزامی هستند.',
  'errors.translation.media_not_found': 'عنوان رسانه درخواستی یافت نشد.',
  'errors.translation.subtitle_source_not_found':
    'منبع زیرنویس درخواستی یافت نشد.',
};
