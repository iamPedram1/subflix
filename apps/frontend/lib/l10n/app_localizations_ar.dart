// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get brandSubtitleCompact => 'ذكاء الترجمة';

  @override
  String get brandSubtitleFull => 'استوديو ترجمة الترجمة بالذكاء الاصطناعي';

  @override
  String get comingSoonMessage => 'ما زلنا نجهّز هذه الشاشة.';

  @override
  String get comingSoonTitle => 'قريبًا';

  @override
  String exportFailedSnack(Object error) {
    return 'فشل التصدير: $error';
  }

  @override
  String get exportSubtitleLabel => 'تصدير الترجمة المترجمة';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'تم تصدير $fileName إلى $path';
  }

  @override
  String get exportingLabel => 'جارٍ التصدير...';

  @override
  String get heroBadge => 'مسار ترجمة احترافي';

  @override
  String get heroBody =>
      'اختر بين فهرس عناوين قابل للبحث أو رفع ملف مباشر، ثم عاين وصدّر ترجمات مصقولة خلال دقائق.';

  @override
  String get heroHeadline =>
      'ترجم ترجمات الأفلام والمسلسلات بمسار عمل بمستوى الاستوديو.';

  @override
  String get heroSearchCta => 'ابحث عن فيلم / مسلسل';

  @override
  String get heroStatLanguagesTitle => '10 لغات';

  @override
  String get heroStatLanguagesValue => 'جاهزة للمعاينة';

  @override
  String get heroStatMockTitle => 'واجهات وهمية';

  @override
  String get heroStatMockValue => 'نقطة جاهزة للخادم';

  @override
  String get heroStatPathsTitle => 'مساران';

  @override
  String get heroStatPathsValue => 'بحث أو رفع';

  @override
  String get heroSubtitle =>
      'ابحث في فهارس الأفلام والمسلسلات، واختر المصادر، وصدّر ترجمات مصقولة خلال دقائق.';

  @override
  String get heroTitle => 'ترجم الترجمات بسرعة أكبر';

  @override
  String get heroUploadCta => 'رفع الترجمة';

  @override
  String historyCountLabel(Object count) {
    return '$count ترجمة';
  }

  @override
  String get historyEmptyMessage =>
      'ستظهر مهام الترجمة المنجزة هنا بعد إكمال مسار البحث أو الرفع.';

  @override
  String get historyEmptyTitle => 'السجل فارغ';

  @override
  String get historyFailedItemMessage => 'فشلت الترجمة. اضغط للبدء من جديد.';

  @override
  String get historyFailedTitle => 'تعذّر تحميل السجل';

  @override
  String get historyFilterAiTranslated => 'مترجمة بالذكاء الاصطناعي';

  @override
  String get historyFilterAll => 'الكل';

  @override
  String get historyFilterCompleted => 'مكتملة';

  @override
  String get historyFilterFailed => 'فاشلة';

  @override
  String get historyFilterMovies => 'الأفلام';

  @override
  String get historyFilterReused => 'معاد استخدامها';

  @override
  String get historyFilterSeries => 'المسلسلات';

  @override
  String get historySubtitle =>
      'أعد فتح مهام الترجمة السابقة، وراجع المعاينة مجددًا، أو صدّرها لاحقًا.';

  @override
  String get historyTitle => 'سجل الترجمات';

  @override
  String get homeFailedRecentTitle => 'تعذّر تحميل المهام الأخيرة';

  @override
  String get homeFutureSubtitle =>
      'تُبقي المستودعات التجريبية القابلة للاستبدال واجهة المستخدم معزولة عن تغييرات الخادم.';

  @override
  String get homeFutureTitle => 'مستودعات جاهزة للمستقبل';

  @override
  String get homeNoRecentMessage =>
      'ابدأ بالبحث عن فيلم أو ارفع ملف ترجمة، وستظهر ترجماتك الأخيرة هنا.';

  @override
  String get homeNoRecentTitle => 'لا توجد مهام حديثة بعد';

  @override
  String get homePreviewSubtitle =>
      'راجع النتائج قبل التصدير عبر العرض الأصلي أو المترجم أو الثنائي اللغة.';

  @override
  String get homePreviewTitle => 'مسار ترجمة قائم على المعاينة أولًا';

  @override
  String get homeQuickHistory => 'السجل';

  @override
  String get homeQuickSearch => 'بحث';

  @override
  String get homeQuickUpload => 'رفع';

  @override
  String get homeRecentJobsSubtitle =>
      'أعد فتح أحدث جلسات الترجمة لديك دون البدء من الصفر.';

  @override
  String get homeRecentJobsTitle => 'المهام الأخيرة';

  @override
  String get homeSearchPlaceholder => 'ابحث عن أفلام أو مسلسلات...';

  @override
  String get homeStatesSubtitle =>
      'التحميل، والفراغ، وإعادة المحاولة، والتحقق، وسيناريوهات عدم الاتصال التجريبية جزء من تجربة الاستخدام منذ اليوم الأول.';

  @override
  String get homeStatesTitle => 'حالات استخدام سلسة مضمّنة';

  @override
  String get homeTrendingNow => 'الرائج الآن';

  @override
  String get homeTrustSubtitle =>
      'مُحاكى اليوم، لكنه مبني كمنتج قابل للإطلاق فعليًا.';

  @override
  String get homeTrustTitle => 'لماذا تثق به الفرق';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeWelcomeSubtitle => 'اعثر على الترجمات وترجمها';

  @override
  String get homeWelcomeTitle => 'مرحبًا بعودتك';

  @override
  String jobConfidence(Object level) {
    return 'الثقة: $level';
  }

  @override
  String get jobOpenPreview => 'فتح المعاينة';

  @override
  String get jobReuseSubtitle => 'إعادة استخدام ملف الترجمة';

  @override
  String get jobReuseTranslation => 'إعادة استخدام الترجمة';

  @override
  String get legalBodyAbout =>
      'SubFlix عميل Flutter بطابع احترافي لترجمة الترجمة بالذكاء الاصطناعي. تستخدم هذه النسخة مستودعات وهمية، وتأخيرًا اصطناعيًا، وتخزينًا محليًا حتى تتطور الواجهة والبنية قبل ربط خادم حقيقي.';

  @override
  String get legalBodyPrivacy =>
      'يخزن SubFlix حاليًا التفضيلات التجريبية وسجل الترجمة فقط على الجهاز عبر التخزين المحلي. يمكن أن يستبدل تكامل خادم مستقبلي ذلك بتخزين موثّق، ومسارات تدقيق، وسياسات احتفاظ تُدار من الخادم.';

  @override
  String get legalBodySupport =>
      'الدعم مجرد عنصر نائب حاليًا. في إصدار الإنتاج يمكن لهذا القسم أن يتصل بالبريد الإلكتروني، وتقارير المشكلات، ومساعدة الحسابات المميزة مع بقاء هيكل التطبيق كما هو.';

  @override
  String get legalBodyTerms =>
      'تهدف هذه النسخة التجريبية إلى اختبار تدفقات المنتج، وحالات الواجهة، وحدود البنية. وعندما يتم ربط خادم إنتاجي يعتمد على NestJS وPostgres لاحقًا، يمكن توسيع السطح القانوني بشروط خدمة حقيقية وصياغات لمعالجة البيانات.';

  @override
  String get legalPlaceholderBody =>
      'هذه الصفحة مجرد عنصر نائب في التطبيق التجريبي. اربطها بمحتواك القانوني الحقيقي في نسخة الإنتاج.';

  @override
  String get legalTitleAbout => 'حول SubFlix';

  @override
  String get legalTitlePrivacy => 'سياسة الخصوصية';

  @override
  String get legalTitleSupport => 'الدعم';

  @override
  String get legalTitleTerms => 'شروط الخدمة';

  @override
  String get mediaTypeMovie => 'فيلم';

  @override
  String get mediaTypeSeries => 'مسلسل';

  @override
  String get metadataEstimatedDuration => 'المدة التقديرية';

  @override
  String get metadataFormat => 'الصيغة';

  @override
  String get metadataLanguages => 'اللغات';

  @override
  String get metadataLines => 'الأسطر';

  @override
  String get navHistory => 'السجل';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get noTitlesMatchedMessage =>
      'لم نتمكن من العثور على هذا العنوان في الفهرس التجريبي. جرّب بحثًا أوسع أو أحد العناوين المقترحة.';

  @override
  String get noTitlesMatchedTitle => 'لا توجد نتائج مطابقة';

  @override
  String get onboardingContinue => 'متابعة';

  @override
  String get onboardingEnterApp => 'ادخل إلى SubFlix';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingPage1Description =>
      'ابحث عن عنوان، وراجع مصادر الترجمة الإنجليزية المتاحة، وابدأ مسار ترجمة يبدو فوريًا.';

  @override
  String get onboardingPage1Eyebrow => 'ابحث واجلب';

  @override
  String get onboardingPage1Highlight1 => 'فهرس تجريبي حتمي لتطوير موثوق';

  @override
  String get onboardingPage1Highlight2 => 'بطاقات جودة المصدر وشارات الصيغة';

  @override
  String get onboardingPage1Highlight3 => 'مصمم ليستبدل بخادم حقيقي لاحقًا';

  @override
  String get onboardingPage1Title =>
      'اعثر على أفلام أو مسلسلات واسحب ترجمات جاهزة للترجمة.';

  @override
  String get onboardingPage2Description =>
      'استورد ملف الترجمة، وتحقق من الصيغة، وشغّل مسار الترجمة المصقول نفسه دون مغادرة التطبيق.';

  @override
  String get onboardingPage2Eyebrow => 'استخدم ملفك الخاص';

  @override
  String get onboardingPage2Highlight1 =>
      'تحقق محلي من الملفات مع حالات إعادة محاولة سلسة';

  @override
  String get onboardingPage2Highlight2 => 'إعداد ترجمة متسق بين الرفع والبحث';

  @override
  String get onboardingPage2Highlight3 =>
      'عاين قبل التصدير حتى لا يبدو شيء غامضًا';

  @override
  String get onboardingPage2Title =>
      'ارفع ملفات `.srt` أو `.vtt` عندما تكون الترجمة لديك بالفعل.';

  @override
  String get onboardingPage3Description =>
      'بدّل بين العرض الأصلي والمترجم والثنائي اللغة، وارجع إلى السجل، وصدّر ملفات ترجمة نظيفة عندما تبدو النتيجة صحيحة.';

  @override
  String get onboardingPage3Eyebrow => 'ترجم وصدّر';

  @override
  String get onboardingPage3Highlight1 =>
      'عناصر معاينة سريعة مع البيانات الوصفية والبحث';

  @override
  String get onboardingPage3Highlight2 =>
      'يبقي السجل المهام السابقة على بُعد لمسة';

  @override
  String get onboardingPage3Highlight3 =>
      'مصمم كأداة وسائط احترافية لا كعرض تجريبي';

  @override
  String get onboardingPage3Title =>
      'اختر اللغات المستهدفة، وعاين الترجمة، وصدّر فورًا.';

  @override
  String get onboardingSkip => 'تخطَّ';

  @override
  String get onboardingStart => 'ابدأ الترجمة';

  @override
  String get previewFailedTitle => 'فشل تحميل المعاينة';

  @override
  String get previewModeBilingual => 'ثنائي اللغة';

  @override
  String get previewModeOriginal => 'الأصل';

  @override
  String get previewModeTranslated => 'المترجم';

  @override
  String get previewNoMatchesMessage =>
      'جرّب كلمة بحث مختلفة أو أزل التصفية لمراجعة الترجمة كاملة.';

  @override
  String get previewNoMatchesTitle => 'لم تتم مطابقة أي أسطر';

  @override
  String get previewNotReadyMessage =>
      'اكتملت الترجمة، لكن الخادم لم يُرجع أسطر المعاينة بعد. جرّب إعادة تحميل هذه الشاشة بعد لحظة.';

  @override
  String get previewNotReadyTitle => 'أسطر المعاينة غير متاحة بعد';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get retryTranslation => 'إعادة الترجمة';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'لم نتمكن من تحديد الموسم المطلوب تحميله. ابدأ مجددًا من البحث.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'حلقات الموسم';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'لم نتمكن من تحديد المسلسل المطلوب تحميله. ابدأ مجددًا من البحث.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'مواسم المسلسل';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'لم نتمكن من تحديد العنوان الذي يجب تحميل مصادر الترجمة له. ابدأ مجددًا من البحث.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'مصادر الترجمة';

  @override
  String get routeMissingTranslationProgressMessage =>
      'لم يتم توفير طلب ترجمة. ابدأ ترجمة جديدة من البحث أو الرفع.';

  @override
  String get routeMissingTranslationProgressTitle => 'تقدّم الترجمة';

  @override
  String get routeMissingTranslationSetupMessage =>
      'مصدر الترجمة مطلوب قبل فتح شاشة إعداد الترجمة.';

  @override
  String get routeMissingTranslationSetupTitle => 'إعداد الترجمة';

  @override
  String get searchFailedTitle => 'فشل البحث';

  @override
  String searchFoundResults(Object count, Object query) {
    return 'تم العثور على $count نتيجة لعبارة \'\'$query\'\'';
  }

  @override
  String get searchHintText => 'ابحث عن Dune أو Breaking Bad أو Severance...';

  @override
  String get searchLoadingLabel => 'جارٍ البحث...';

  @override
  String get searchMockMessage =>
      'جرّب عناوين مثل Inception أو Dune أو Breaking Bad أو Severance أو The Last of Us لاستكشاف مسار مصادر الترجمة.';

  @override
  String get searchMockTitle => 'ابحث عن أي شيء في الفهرس التجريبي';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'اعثر على عنوان، وتفقّد مصادر الترجمة، وابدأ مهمة الترجمة ببضع لمسات.';

  @override
  String get searchMovieOrSeriesTitle => 'ابحث عن فيلم أو مسلسل';

  @override
  String searchNoResultsFor(Object query) {
    return 'لم يتم العثور على نتائج لعبارة \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'الشعبية $score';
  }

  @override
  String get searchTitles => 'البحث عن العناوين';

  @override
  String get searchTrendingTitle => 'عمليات البحث الرائجة';

  @override
  String get searchTryDifferentKeywords => 'جرّب البحث بكلمات مختلفة.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'الحلقة $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'حوالي $runtime دقيقة';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount حلقة$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'الموسم $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'الموسم $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount حلقة$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'اختر موسمًا من $title لتصفّح الحلقات المتاحة.';
  }

  @override
  String get seriesSeasonsTitle => 'اختر موسمًا';

  @override
  String get settingsAboutTitle => 'حول SubFlix';

  @override
  String get settingsCacheCleared => 'تم مسح الذاكرة المؤقتة';

  @override
  String get settingsClearCache => 'مسح الذاكرة المؤقتة';

  @override
  String get settingsContactTitle => 'تواصل معنا';

  @override
  String get settingsFailedTitle => 'فشل تحميل الإعدادات';

  @override
  String get settingsHelpCenterTitle => 'مركز المساعدة';

  @override
  String get settingsHistoryClearedSnack => 'تم مسح سجل الترجمة لهذا الجهاز';

  @override
  String get settingsLanguageLabel => 'اللغة المستهدفة المفضلة';

  @override
  String get settingsMaintenanceSubtitle =>
      'امسح مهام الترجمة التابعة للخادم لهذا الجهاز وابدأ بسجل فارغ.';

  @override
  String get settingsMaintenanceTitle => 'الصيانة';

  @override
  String get settingsNotificationsSubtitle => 'أدر تفضيلات الإشعارات';

  @override
  String get settingsNotificationsTitle => 'الإشعارات';

  @override
  String get settingsPremiumSubtitle =>
      'لاحقًا يمكننا ربط الاشتراكات والفوترة ومزامنة المشاريع السحابية هنا.';

  @override
  String get settingsPremiumTitle => 'عنصر مميز تجريبي';

  @override
  String get settingsPrivacySubtitle => 'محتوى خصوصية تجريبي';

  @override
  String get settingsPrivacyTitle => 'سياسة الخصوصية';

  @override
  String get settingsProfileName => 'مستخدم SubFlix';

  @override
  String get settingsProfileTier => 'عضو مميز';

  @override
  String get settingsSubtitle => 'أدر تفضيلاتك';

  @override
  String get settingsSupportSubtitle => 'صفحة مساعدة واتصال تجريبية';

  @override
  String get settingsSupportTitle => 'قسم دعم تجريبي';

  @override
  String get settingsTermsSubtitle => 'محتوى شروط تجريبي';

  @override
  String get settingsTermsTitle => 'شروط الخدمة';

  @override
  String get settingsThemeLabel => 'المظهر';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String settingsVersion(Object version) {
    return 'الإصدار $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'جارٍ تجهيز استوديو الترجمة الخاص بك';

  @override
  String get splashSubtitle => 'ترجمة ترجمة مدعومة بالذكاء الاصطناعي';

  @override
  String get startTranslation => 'بدء الترجمة';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads تنزيلًا';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'مصدر ترجمة $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount سطرًا';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'التقييم $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'اختر مصدر ترجمة وتابع إلى إعداد ترجمة مصقول ومهيأ لتوقيت الترجمة.';

  @override
  String get subtitleSourcesBannerTitle => 'الترجمة بالذكاء الاصطناعي متاحة';

  @override
  String get subtitleSourcesFailedTitle => 'تعذّر تحميل مصادر الترجمة';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'اختر مصدر ترجمة لـ $title$target، ثم اختر اللغة المستهدفة في الخطوة التالية.';
  }

  @override
  String get subtitleSourcesTitle => 'مصادر الترجمة الإنجليزية';

  @override
  String get targetLanguage => 'اللغة المستهدفة';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeSystem => 'النظام';

  @override
  String get translateSetupAutoDetect => 'اكتشاف الصيغة تلقائيًا';

  @override
  String get translateSetupAutoDetectBody =>
      'اختر بنية إخراج الترجمة المناسبة تلقائيًا.';

  @override
  String get translateSetupLanguageTitle => 'الترجمة إلى';

  @override
  String get translateSetupOptionsTitle => 'الخيارات';

  @override
  String get translateSetupPreserveTiming => 'الحفاظ على التوقيت';

  @override
  String get translateSetupPreserveTimingBody =>
      'أبقِ توقيتات الترجمة الأصلية متطابقة مع الملف المصدر.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'سيحوّل مسار الترجمة لدينا هذه الترجمة إلى $language مع الحفاظ على التوقيت وبنية الأسطر بشكل نظيف.';
  }

  @override
  String get translateSetupReadyTitle => 'الترجمة بالذكاء الاصطناعي جاهزة';

  @override
  String get translateSetupSelectLanguage => 'اختر اللغة';

  @override
  String get translateSetupSourceTitle => 'الترجمة المصدر';

  @override
  String get translateSetupSubtitle =>
      'اختر اللغة المستهدفة، وراجع مصدر الترجمة، ثم ابدأ مهمة الترجمة في الخادم.';

  @override
  String get translateSetupTitle => 'إعداد الترجمة';

  @override
  String get translationFailedMessage => 'حدث خطأ ما.';

  @override
  String get translationFailedTitle => 'تعذّر إكمال الترجمة';

  @override
  String get translationPreviewHeader => 'راجع الترجمات المترجمة';

  @override
  String get translationPreviewSearchHint => 'ابحث في أسطر الترجمة';

  @override
  String get translationPreviewSubtitle =>
      'ابحث داخل الأسطر، وبدّل أوضاع المعاينة، ثم صدّر الملف عندما تبدو الترجمة مناسبة.';

  @override
  String get translationPreviewTitle => 'معاينة الترجمة';

  @override
  String get translationProgressHeadline =>
      'ترجمة الترجمة بالذكاء الاصطناعي قيد التنفيذ';

  @override
  String get translationProgressTitle => 'تقدّم الترجمة';

  @override
  String get translationResultCompleteSubtitle =>
      'أصبحت الترجمة جاهزة للمعاينة أو التنزيل.';

  @override
  String get translationResultCompleteTitle => 'اكتملت الترجمة';

  @override
  String get translationResultConfidenceLabel => 'ثقة الترجمة';

  @override
  String get translationResultDetailsTitle => 'تفاصيل الترجمة';

  @override
  String get translationResultDownloadCta => 'تنزيل الترجمة';

  @override
  String get translationResultHomeCta => 'العودة إلى الرئيسية';

  @override
  String get translationResultMediaLabel => 'عنوان العمل';

  @override
  String get translationResultMethodAi => 'مترجمة بالذكاء الاصطناعي';

  @override
  String get translationResultMetricsTitle => 'مقاييس الجودة';

  @override
  String get translationResultPreviewCta => 'معاينة الترجمة';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'تمت المعالجة خلال $duration';
  }

  @override
  String get translationResultSourceLabel => 'لغة المصدر';

  @override
  String get translationResultTargetLabel => 'اللغة المستهدفة';

  @override
  String get translationResultTimingLabel => 'دقة التوقيت';

  @override
  String get translationResultTimingPreserved => 'تم الحفاظ على التوقيت';

  @override
  String get translationResultWarning =>
      'قد تستفيد بعض المصطلحات التقنية من مراجعة بشرية سريعة لفهم السياق.';

  @override
  String get translationStageAligning =>
      'جارٍ مواءمة الطوابع الزمنية وسياق المشهد';

  @override
  String get translationStageGenerating => 'جارٍ إنشاء الترجمة';

  @override
  String get translationStageIdle => 'بانتظار طلب ترجمة';

  @override
  String get translationStagePreparing => 'جارٍ تجهيز حزمة الترجمة';

  @override
  String get translationStageQueued => 'في انتظار الدور للترجمة';

  @override
  String get translationStageReadability => 'جارٍ تحسين قابلية القراءة';

  @override
  String get translationStageReady => 'الترجمة جاهزة';

  @override
  String get tryAgain => 'جرّب مرة أخرى';

  @override
  String get uploadChooseFile => 'اختر ملف ترجمة';

  @override
  String get uploadChooseFileShort => 'اختر ملفًا';

  @override
  String get uploadContinueSetup => 'متابعة إلى إعداد الترجمة';

  @override
  String get uploadEnglishSource => 'المصدر الإنجليزي';

  @override
  String get uploadFailedFallback => 'يرجى تجربة ملف ترجمة آخر.';

  @override
  String get uploadFailedMessage =>
      'تعذّرت قراءة ملف الترجمة هذا. جرّب ملفًا آخر أو ملف تصدير أصغر.';

  @override
  String get uploadFailedTitle => 'فشل استيراد الملف';

  @override
  String get uploadIntroSubtitle =>
      'استورد ملف `.srt` أو `.vtt` باللغة الإنجليزية، ودع الخادم يتحقق منه ويحلّله، ثم تابع إلى إعداد الترجمة.';

  @override
  String get uploadIntroTitle => 'استخدم ملف الترجمة الخاص بك';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount سطرًا';
  }

  @override
  String get uploadMetadataTitle => 'تفاصيل الترجمة';

  @override
  String get uploadOpeningPicker => 'جارٍ فتح أداة الاختيار...';

  @override
  String get uploadPickSubtitle => 'اختر ملف الترجمة';

  @override
  String get uploadPickedFile => 'تم اختيار ملف الترجمة';

  @override
  String get uploadReadyTitle => 'جاهز للترجمة';

  @override
  String get uploadSubtitleTitle => 'رفع الترجمة';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'ملفات ترجمة إنجليزية بصيغة `.srt` و `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'الصيغ المدعومة';

  @override
  String get uploadUseDemoFile => 'استخدام ملف تجريبي';
}
