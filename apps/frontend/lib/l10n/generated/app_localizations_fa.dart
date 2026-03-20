// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get brandSubtitleCompact => 'هوش زیرنویس';

  @override
  String get brandSubtitleFull => 'استودیوی ترجمه زیرنویس با هوش مصنوعی';

  @override
  String get comingSoonMessage => 'هنوز در حال آماده کردن این صفحه هستیم.';

  @override
  String get comingSoonTitle => 'به‌زودی';

  @override
  String exportFailedSnack(Object error) {
    return 'خروجی ناموفق بود: $error';
  }

  @override
  String get exportSubtitleLabel => 'خروجی گرفتن از زیرنویس ترجمه‌شده';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName در $path ذخیره شد';
  }

  @override
  String get exportingLabel => 'در حال خروجی گرفتن...';

  @override
  String get heroBadge => 'جریان حرفه‌ای زیرنویس';

  @override
  String get heroBody =>
      'بین کاتالوگ قابل جستجو یا آپلود مستقیم فایل یکی را انتخاب کن، سپس در چند دقیقه پیش‌نمایش بگیر و زیرنویس نهایی را خروجی بگیر.';

  @override
  String get heroHeadline =>
      'زیرنویس فیلم و سریال را با یک جریان در حد استودیو ترجمه کن.';

  @override
  String get heroSearchCta => 'جستجوی فیلم / سریال';

  @override
  String get heroStatLanguagesTitle => '۱۰ زبان';

  @override
  String get heroStatLanguagesValue => 'آماده پیش‌نمایش';

  @override
  String get heroStatMockTitle => 'APIهای ماک';

  @override
  String get heroStatMockValue => 'آماده اتصال به بک‌اند';

  @override
  String get heroStatPathsTitle => '۲ مسیر';

  @override
  String get heroStatPathsValue => 'جستجو یا آپلود';

  @override
  String get heroSubtitle =>
      'در کاتالوگ فیلم و سریال جستجو کن، منبع انتخاب کن و در چند دقیقه خروجی تمیز بگیر.';

  @override
  String get heroTitle => 'زیرنویس‌ها را سریع‌تر ترجمه کن';

  @override
  String get heroUploadCta => 'آپلود زیرنویس';

  @override
  String historyCountLabel(Object count) {
    return '$count ترجمه';
  }

  @override
  String get historyEmptyMessage =>
      'بعد از کامل کردن فرایند جستجو یا آپلود، ترجمه‌های انجام‌شده اینجا ظاهر می‌شوند.';

  @override
  String get historyEmptyTitle => 'تاریخچه خالی است';

  @override
  String get historyFailedItemMessage =>
      'ترجمه ناموفق بود. برای شروع دوباره لمس کن.';

  @override
  String get historyFailedTitle => 'بارگذاری تاریخچه ممکن نشد';

  @override
  String get historyFilterAiTranslated => 'ترجمه‌شده با هوش مصنوعی';

  @override
  String get historyFilterAll => 'همه';

  @override
  String get historyFilterCompleted => 'تکمیل‌شده';

  @override
  String get historyFilterFailed => 'ناموفق';

  @override
  String get historyFilterMovies => 'فیلم‌ها';

  @override
  String get historyFilterReused => 'استفاده‌شده دوباره';

  @override
  String get historyFilterSeries => 'سریال‌ها';

  @override
  String get historySubtitle =>
      'کارهای قبلی را دوباره باز کن، پیش‌نمایش را دوباره ببین یا بعداً خروجی بگیر.';

  @override
  String get historyTitle => 'تاریخچه ترجمه‌ها';

  @override
  String get homeFailedRecentTitle => 'بارگذاری کارهای اخیر ممکن نشد';

  @override
  String get homeFutureSubtitle =>
      'ریپازیتوری‌های ماک قابل تعویض باعث می‌شوند کد UI از تغییرات بک‌اند در امان بماند.';

  @override
  String get homeFutureTitle => 'ریپازیتوری‌های آماده آینده';

  @override
  String get homeNoRecentMessage =>
      'با جستجوی فیلم یا آپلود فایل زیرنویس شروع کن تا ترجمه‌های اخیرت اینجا دیده شوند.';

  @override
  String get homeNoRecentTitle => 'هنوز کاری در بخش اخیرها نیست';

  @override
  String get homePreviewSubtitle =>
      'قبل از خروجی گرفتن، نتیجه را در حالت اصلی، ترجمه‌شده یا دوزبانه بررسی کن.';

  @override
  String get homePreviewTitle => 'جریان ترجمه با محوریت پیش‌نمایش';

  @override
  String get homeQuickHistory => 'تاریخچه';

  @override
  String get homeQuickSearch => 'جستجو';

  @override
  String get homeQuickUpload => 'آپلود';

  @override
  String get homeRecentJobsSubtitle =>
      'آخرین جلسه‌های ترجمه‌ات را بدون شروع از صفر دوباره باز کن.';

  @override
  String get homeRecentJobsTitle => 'کارهای اخیر';

  @override
  String get homeSearchPlaceholder => 'جستجوی فیلم یا سریال...';

  @override
  String get homeStatesSubtitle =>
      'لودینگ، حالت خالی، تلاش دوباره، اعتبارسنجی و سناریوهای آفلاین آزمایشی از همان روز اول جزئی از UX هستند.';

  @override
  String get homeStatesTitle => 'همه وضعیت‌های لازم در نظر گرفته شده';

  @override
  String get homeTrendingNow => 'ترندهای فعلی';

  @override
  String get homeTrustSubtitle =>
      'فعلاً آزمایشی است، اما ساختارش مثل یک محصول واقعی و قابل انتشار طراحی شده.';

  @override
  String get homeTrustTitle => 'چرا تیم‌ها به آن اعتماد می‌کنند';

  @override
  String get homeViewAll => 'مشاهده همه';

  @override
  String get homeWelcomeSubtitle => 'زیرنویس پیدا کن و ترجمه کن';

  @override
  String get homeWelcomeTitle => 'خوش برگشتی';

  @override
  String jobConfidence(Object level) {
    return 'اطمینان: $level';
  }

  @override
  String get jobOpenPreview => 'باز کردن پیش‌نمایش';

  @override
  String get jobReuseSubtitle => 'استفاده دوباره از زیرنویس';

  @override
  String get jobReuseTranslation => 'استفاده دوباره از ترجمه';

  @override
  String get legalBodyAbout =>
      'SubFlix یک کلاینت Flutter با حس‌وحال پریمیوم برای ترجمه زیرنویس با هوش مصنوعی است. این بیلد از ریپازیتوری‌های ماک، تأخیر مصنوعی و ذخیره‌سازی محلی استفاده می‌کند تا قبل از اتصال بک‌اند واقعی، UI و معماری به بلوغ برسند.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix فعلاً فقط ترجیحات آزمایشی و تاریخچه ترجمه را با ذخیره‌سازی محلی روی دستگاه نگه می‌دارد. در آینده می‌توان این بخش را با یک بک‌اند واقعی به ذخیره‌سازی احراز هویت‌شده، مسیرهای ممیزی و سیاست‌های نگه‌داری سمت سرور ارتقا داد.';

  @override
  String get legalBodySupport =>
      'بخش پشتیبانی فعلاً فقط جای‌نگهدار است. در نسخه واقعی، این قسمت می‌تواند بدون تغییر در ساختار اپ به ایمیل، گزارش مشکل و پشتیبانی حساب‌های پریمیوم متصل شود.';

  @override
  String get legalBodyTerms =>
      'این نسخه آزمایشی برای سنجش جریان‌های محصول، وضعیت‌های رابط کاربری و مرزهای معماری ساخته شده است. وقتی بعداً یک بک‌اند واقعی مبتنی بر NestJS و Postgres متصل شود، بخش حقوقی هم می‌تواند با شرایط واقعی سرویس و متن‌های مربوط به پردازش داده گسترش پیدا کند.';

  @override
  String get legalPlaceholderBody =>
      'این صفحه در نسخه دمو فقط یک جای‌نگهدار است. آن را به محتوای حقوقی واقعی محصولت وصل کن.';

  @override
  String get legalTitleAbout => 'درباره SubFlix';

  @override
  String get legalTitlePrivacy => 'حریم خصوصی';

  @override
  String get legalTitleSupport => 'پشتیبانی';

  @override
  String get legalTitleTerms => 'شرایط استفاده';

  @override
  String get mediaTypeMovie => 'فیلم';

  @override
  String get mediaTypeSeries => 'سریال';

  @override
  String get metadataEstimatedDuration => 'مدت زمان تقریبی';

  @override
  String get metadataFormat => 'فرمت';

  @override
  String get metadataLanguages => 'زبان‌ها';

  @override
  String get metadataLines => 'خطوط';

  @override
  String get navHistory => 'تاریخچه';

  @override
  String get navHome => 'خانه';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get noTitlesMatchedMessage =>
      'نتوانستیم این عنوان را در کاتالوگ آزمایشی پیدا کنیم. یک جستجوی کلی‌تر یا یکی از عنوان‌های پیشنهادی را امتحان کن.';

  @override
  String get noTitlesMatchedTitle => 'نتیجه‌ای پیدا نشد';

  @override
  String get onboardingContinue => 'ادامه';

  @override
  String get onboardingEnterApp => 'ورود به SubFlix';

  @override
  String get onboardingNext => 'بعدی';

  @override
  String get onboardingPage1Description =>
      'یک عنوان جستجو کن، منابع زیرنویس انگلیسی موجود را ببین و جریان ترجمه‌ای را شروع کن که سریع و روان احساس می‌شود.';

  @override
  String get onboardingPage1Eyebrow => 'جستجو و دریافت';

  @override
  String get onboardingPage1Highlight1 => 'کاتالوگ ماک قطعی برای توسعه مطمئن';

  @override
  String get onboardingPage1Highlight2 =>
      'برچسب کیفیت منبع و نشان فرمت زیرنویس';

  @override
  String get onboardingPage1Highlight3 =>
      'طوری ساخته شده که بعداً به بک‌اند واقعی وصل شود';

  @override
  String get onboardingPage1Title =>
      'فیلم یا سریال پیدا کن و زیرنویس آماده ترجمه را بگیر.';

  @override
  String get onboardingPage2Description =>
      'فایل زیرنویس را وارد کن، فرمت را اعتبارسنجی کن و بدون خروج از اپ همان مسیر ترجمه حرفه‌ای را اجرا کن.';

  @override
  String get onboardingPage2Eyebrow => 'فایل خودت را بیاور';

  @override
  String get onboardingPage2Highlight1 =>
      'اعتبارسنجی محلی فایل و حالت‌های تلاش دوباره روان';

  @override
  String get onboardingPage2Highlight2 =>
      'تنظیمات ترجمه یکدست برای آپلود و جستجو';

  @override
  String get onboardingPage2Highlight3 =>
      'قبل از خروجی گرفتن پیش‌نمایش ببین تا چیزی مبهم نماند';

  @override
  String get onboardingPage2Title =>
      'وقتی فایل را داری، `.srt` یا `.vtt` آپلود کن.';

  @override
  String get onboardingPage3Description =>
      'بین نمایش اصلی، ترجمه‌شده و دوزبانه جابه‌جا شو، به تاریخچه سر بزن و وقتی نتیجه درست بود فایل تمیز زیرنویس را خروجی بگیر.';

  @override
  String get onboardingPage3Eyebrow => 'ترجمه و خروجی';

  @override
  String get onboardingPage3Highlight1 =>
      'کنترل‌های سریع پیش‌نمایش همراه با متادیتا و جستجو';

  @override
  String get onboardingPage3Highlight2 =>
      'تاریخچه، کارهای قبلی را فقط با یک لمس در دسترس نگه می‌دارد';

  @override
  String get onboardingPage3Highlight3 =>
      'طراحی‌شده مثل یک ابزار رسانه‌ای پریمیوم، نه یک دمو';

  @override
  String get onboardingPage3Title =>
      'زبان مقصد را انتخاب کن، پیش‌نمایش ببین و فوری خروجی بگیر.';

  @override
  String get onboardingSkip => 'رد کردن';

  @override
  String get onboardingStart => 'شروع ترجمه';

  @override
  String get previewFailedTitle => 'بارگذاری پیش‌نمایش ناموفق بود';

  @override
  String get previewModeBilingual => 'دوزبانه';

  @override
  String get previewModeOriginal => 'اصل';

  @override
  String get previewModeTranslated => 'ترجمه‌شده';

  @override
  String get previewNoMatchesMessage =>
      'یک عبارت دیگر را جستجو کن یا فیلتر را پاک کن تا کل ترجمه را ببینی.';

  @override
  String get previewNoMatchesTitle => 'هیچ خطی پیدا نشد';

  @override
  String get previewNotReadyMessage =>
      'ترجمه تمام شده، اما بک‌اند هنوز cueهای پیش‌نمایش را برنگردانده است. کمی بعد دوباره این صفحه را بارگذاری کن.';

  @override
  String get previewNotReadyTitle => 'cueهای پیش‌نمایش هنوز آماده نیستند';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get retryTranslation => 'ترجمه دوباره';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'نتوانستیم تشخیص دهیم کدام فصل باید بارگذاری شود. دوباره از جستجو شروع کن.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'قسمت‌های فصل';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'نتوانستیم تشخیص دهیم کدام سریال باید بارگذاری شود. دوباره از جستجو شروع کن.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'فصل‌های سریال';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'نتوانستیم تشخیص دهیم منابع زیرنویس برای کدام عنوان باید بارگذاری شوند. دوباره از جستجو شروع کن.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'منابع زیرنویس';

  @override
  String get routeMissingTranslationProgressMessage =>
      'هیچ درخواست ترجمه‌ای ارسال نشده است. یک ترجمه جدید را از مسیر جستجو یا آپلود شروع کن.';

  @override
  String get routeMissingTranslationProgressTitle => 'روند ترجمه';

  @override
  String get routeMissingTranslationSetupMessage =>
      'قبل از باز شدن صفحه تنظیمات ترجمه، وجود یک منبع زیرنویس ضروری است.';

  @override
  String get routeMissingTranslationSetupTitle => 'تنظیمات ترجمه';

  @override
  String get searchFailedTitle => 'جستجو ناموفق بود';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count نتیجه برای \"$query\" پیدا شد';
  }

  @override
  String get searchHintText =>
      'مثلاً Dune یا Breaking Bad یا Severance را جستجو کن...';

  @override
  String get searchLoadingLabel => 'در حال جستجو...';

  @override
  String get searchMockMessage =>
      'برای دیدن جریان انتخاب منبع زیرنویس، عنوان‌هایی مثل Inception، Dune، Breaking Bad، Severance یا The Last of Us را امتحان کن.';

  @override
  String get searchMockTitle => 'هر چیزی را در کاتالوگ آزمایشی جستجو کن';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'یک عنوان پیدا کن، منابع زیرنویس را بررسی کن و فقط با چند لمس ترجمه را شروع کن.';

  @override
  String get searchMovieOrSeriesTitle => 'جستجوی فیلم یا سریال';

  @override
  String searchNoResultsFor(Object query) {
    return 'نتیجه‌ای برای \"$query\" پیدا نشد';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'محبوبیت $score';
  }

  @override
  String get searchTitles => 'جستجوی عنوان‌ها';

  @override
  String get searchTrendingTitle => 'جستجوهای پرطرفدار';

  @override
  String get searchTryDifferentKeywords => 'با کلمات کلیدی دیگری جستجو کن.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'قسمت $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'حدود $runtime دقیقه';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount قسمت$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'فصل $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'فصل $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount قسمت$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'یک فصل از $title را انتخاب کن تا قسمت‌های موجود را ببینی.';
  }

  @override
  String get seriesSeasonsTitle => 'یک فصل انتخاب کن';

  @override
  String get settingsAboutTitle => 'درباره SubFlix';

  @override
  String get settingsCacheCleared => 'کش پاک شد';

  @override
  String get settingsClearCache => 'پاک کردن کش';

  @override
  String get settingsContactTitle => 'تماس با ما';

  @override
  String get settingsFailedTitle => 'بارگذاری تنظیمات ناموفق بود';

  @override
  String get settingsHelpCenterTitle => 'مرکز راهنما';

  @override
  String get settingsHistoryClearedSnack =>
      'تاریخچه ترجمه برای این دستگاه پاک شد';

  @override
  String get settingsLanguageLabel => 'زبان مقصد ترجیحی';

  @override
  String get settingsMaintenanceSubtitle =>
      'کارهای ترجمه وابسته به بک‌اند را برای این دستگاه پاک کن و با یک تاریخچه خالی شروع کن.';

  @override
  String get settingsMaintenanceTitle => 'نگه‌داری';

  @override
  String get settingsNotificationsSubtitle => 'تنظیمات اعلان‌ها را مدیریت کن';

  @override
  String get settingsNotificationsTitle => 'اعلان‌ها';

  @override
  String get settingsPremiumSubtitle =>
      'بعداً می‌توانیم اشتراک‌ها، پرداخت و همگام‌سازی پروژه ابری را اینجا وصل کنیم.';

  @override
  String get settingsPremiumTitle => 'بخش پریمیوم آزمایشی';

  @override
  String get settingsPrivacySubtitle => 'محتوای آزمایشی حریم خصوصی';

  @override
  String get settingsPrivacyTitle => 'حریم خصوصی';

  @override
  String get settingsProfileName => 'کاربر SubFlix';

  @override
  String get settingsProfileTier => 'عضو پریمیوم';

  @override
  String get settingsSubtitle => 'ترجیحاتت را مدیریت کن';

  @override
  String get settingsSupportSubtitle => 'صفحه نمونه برای راهنما و تماس';

  @override
  String get settingsSupportTitle => 'بخش پشتیبانی آزمایشی';

  @override
  String get settingsTermsSubtitle => 'محتوای آزمایشی شرایط استفاده';

  @override
  String get settingsTermsTitle => 'شرایط استفاده';

  @override
  String get settingsThemeLabel => 'ظاهر';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String settingsVersion(Object version) {
    return 'نسخه $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'در حال آماده‌سازی استودیوی زیرنویس تو';

  @override
  String get splashSubtitle => 'ترجمه زیرنویس با هوش مصنوعی';

  @override
  String get startTranslation => 'شروع ترجمه';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads دانلود';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'منبع زیرنویس $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount خط';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'امتیاز $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'یک منبع زیرنویس انتخاب کن و وارد تنظیمات ترجمه‌ای شو که برای زمان‌بندی زیرنویس بهینه شده است.';

  @override
  String get subtitleSourcesBannerTitle => 'ترجمه با هوش مصنوعی در دسترس است';

  @override
  String get subtitleSourcesFailedTitle => 'بارگذاری منابع زیرنویس ممکن نشد';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'برای $title$target یک منبع زیرنویس انتخاب کن و در مرحله بعد زبان مقصد را مشخص کن.';
  }

  @override
  String get subtitleSourcesTitle => 'منابع زیرنویس انگلیسی';

  @override
  String get targetLanguage => 'زبان مقصد';

  @override
  String get themeDark => 'تیره';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get translateSetupAutoDetect => 'تشخیص خودکار فرمت';

  @override
  String get translateSetupAutoDetectBody =>
      'ساختار مناسب خروجی زیرنویس را به‌صورت خودکار انتخاب می‌کند.';

  @override
  String get translateSetupLanguageTitle => 'ترجمه به';

  @override
  String get translateSetupOptionsTitle => 'گزینه‌ها';

  @override
  String get translateSetupPreserveTiming => 'حفظ زمان‌بندی';

  @override
  String get translateSetupPreserveTimingBody =>
      'زمان‌بندی اصلی زیرنویس را با فایل مبدأ هماهنگ نگه می‌دارد.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'جریان ترجمه ما این زیرنویس را با حفظ زمان‌بندی و ساختار تمیز cueها به $language تبدیل می‌کند.';
  }

  @override
  String get translateSetupReadyTitle => 'ترجمه با هوش مصنوعی آماده است';

  @override
  String get translateSetupSelectLanguage => 'انتخاب زبان';

  @override
  String get translateSetupSourceTitle => 'زیرنویس مبدأ';

  @override
  String get translateSetupSubtitle =>
      'زبان مقصد را انتخاب کن، منبع زیرنویس را بررسی کن و بعد کار ترجمه را در بک‌اند شروع کن.';

  @override
  String get translateSetupTitle => 'تنظیمات ترجمه';

  @override
  String get translationFailedMessage => 'مشکلی پیش آمد.';

  @override
  String get translationFailedTitle => 'ترجمه کامل نشد';

  @override
  String get translationPreviewHeader => 'زیرنویس‌های ترجمه‌شده را بررسی کن';

  @override
  String get translationPreviewSearchHint => 'جستجو در خطوط زیرنویس';

  @override
  String get translationPreviewSubtitle =>
      'در cueها جستجو کن، حالت نمایش را عوض کن و وقتی نتیجه درست بود خروجی بگیر.';

  @override
  String get translationPreviewTitle => 'پیش‌نمایش ترجمه';

  @override
  String get translationProgressHeadline =>
      'ترجمه زیرنویس با هوش مصنوعی در حال انجام است';

  @override
  String get translationProgressTitle => 'روند ترجمه';

  @override
  String get translationResultCompleteSubtitle =>
      'زیرنویس تو برای پیش‌نمایش یا دانلود آماده است.';

  @override
  String get translationResultCompleteTitle => 'ترجمه کامل شد';

  @override
  String get translationResultConfidenceLabel => 'میزان اطمینان ترجمه';

  @override
  String get translationResultDetailsTitle => 'جزئیات ترجمه';

  @override
  String get translationResultDownloadCta => 'دانلود زیرنویس';

  @override
  String get translationResultHomeCta => 'بازگشت به خانه';

  @override
  String get translationResultMediaLabel => 'عنوان اثر';

  @override
  String get translationResultMethodAi => 'ترجمه‌شده با هوش مصنوعی';

  @override
  String get translationResultMetricsTitle => 'شاخص‌های کیفیت';

  @override
  String get translationResultPreviewCta => 'پیش‌نمایش زیرنویس';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'در $duration پردازش شد';
  }

  @override
  String get translationResultSourceLabel => 'زبان مبدأ';

  @override
  String get translationResultTargetLabel => 'زبان مقصد';

  @override
  String get translationResultTimingLabel => 'دقت زمان‌بندی';

  @override
  String get translationResultTimingPreserved => 'زمان‌بندی حفظ شده';

  @override
  String get translationResultWarning =>
      'بعضی اصطلاحات تخصصی شاید هنوز برای درک بهتر بافت جمله به یک بازبینی انسانی سریع نیاز داشته باشند.';

  @override
  String get translationStageAligning =>
      'در حال هماهنگ‌سازی زمان‌ها و فضای صحنه';

  @override
  String get translationStageGenerating => 'در حال تولید ترجمه زیرنویس';

  @override
  String get translationStageIdle => 'در انتظار درخواست ترجمه';

  @override
  String get translationStagePreparing => 'در حال آماده‌سازی بسته زیرنویس';

  @override
  String get translationStageQueued => 'در صف ترجمه';

  @override
  String get translationStageReadability => 'در حال اعمال بازبینی خوانایی';

  @override
  String get translationStageReady => 'ترجمه آماده است';

  @override
  String get tryAgain => 'دوباره امتحان کن';

  @override
  String get uploadChooseFile => 'انتخاب فایل زیرنویس';

  @override
  String get uploadChooseFileShort => 'انتخاب فایل';

  @override
  String get uploadContinueSetup => 'ادامه به تنظیمات ترجمه';

  @override
  String get uploadEnglishSource => 'منبع انگلیسی';

  @override
  String get uploadFailedFallback => 'لطفاً یک فایل زیرنویس دیگر را امتحان کن.';

  @override
  String get uploadFailedMessage =>
      'نتوانستیم این فایل زیرنویس را بخوانیم. یک فایل دیگر یا خروجی سبک‌تر را امتحان کن.';

  @override
  String get uploadFailedTitle => 'وارد کردن فایل ناموفق بود';

  @override
  String get uploadIntroSubtitle =>
      'یک فایل انگلیسی `.srt` یا `.vtt` وارد کن، بگذار بک‌اند آن را بررسی و پردازش کند، سپس وارد مرحله تنظیم ترجمه شو.';

  @override
  String get uploadIntroTitle => 'فایل زیرنویس خودت را بیاور';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount خط';
  }

  @override
  String get uploadMetadataTitle => 'جزئیات زیرنویس';

  @override
  String get uploadOpeningPicker => 'در حال باز کردن انتخاب‌گر فایل...';

  @override
  String get uploadPickSubtitle => 'فایل زیرنویس را انتخاب کن';

  @override
  String get uploadPickedFile => 'فایل زیرنویس انتخاب شد';

  @override
  String get uploadReadyTitle => 'آماده ترجمه';

  @override
  String get uploadSubtitleTitle => 'آپلود زیرنویس';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'فایل‌های زیرنویس انگلیسی `.srt` و `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'فرمت‌های پشتیبانی‌شده';

  @override
  String get uploadUseDemoFile => 'استفاده از فایل نمونه';
}
