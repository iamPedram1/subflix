import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('de'),
    Locale('fa'),
    Locale('ar'),
    Locale('ja'),
    Locale('zh'),
    Locale('hi'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const List<LocalizationsDelegate<dynamic>> globalDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': <String, String>{
      'appTitle': 'SubFlix',
      'searchTitles': 'Search titles',
      'searchMovieOrSeriesTitle': 'Search movie or series',
      'searchMovieOrSeriesSubtitle':
          'Find a title, inspect subtitle sources, and launch a translation job with a few taps.',
      'searchHintText': 'Search for Dune, Breaking Bad, Severance...',
      'searchMockTitle': 'Search anything in the mock catalog',
      'searchMockMessage':
          'Try titles like Inception, Dune, Breaking Bad, Severance, or The Last of Us to explore the subtitle source flow.',
      'searchFailedTitle': 'Search failed',
      'noTitlesMatchedTitle': 'No titles matched',
      'noTitlesMatchedMessage':
          'We could not find that title in the mock catalog. Try a broader search or one of the suggested shows.',
      'retry': 'Retry',
      'retryTranslation': 'Retry translation',
      'uploadSubtitleTitle': 'Upload subtitle',
      'uploadIntroTitle': 'Bring your own subtitle file',
      'uploadIntroSubtitle':
          'Import an English `.srt` or `.vtt` file, let the backend validate and parse it, then continue into translation setup.',
      'uploadChooseFile': 'Choose subtitle file',
      'uploadSupportedFormatsTitle': 'Supported formats',
      'uploadSupportedFormatsSubtitle': 'English `.srt` and `.vtt` subtitle files',
      'uploadOpeningPicker': 'Opening picker...',
      'uploadChooseFileShort': 'Choose file',
      'uploadPickSubtitle': 'Pick subtitle file',
      'uploadPickedFile': 'Picked subtitle file',
      'uploadUseDemoFile': 'Use demo file',
      'uploadFailedTitle': 'File import failed',
      'uploadFailedMessage':
          'We could not read this subtitle file. Try a different file or pick a smaller export.',
      'uploadFailedFallback': 'Please try another subtitle file.',
      'tryAgain': 'Try again',
      'uploadMetadataTitle': 'Subtitle details',
      'uploadReadyTitle': 'Ready to translate',
      'uploadLineCount': '{lineCount} lines',
      'uploadEnglishSource': 'English source',
      'uploadContinueSetup': 'Continue to translation setup',
      'translateSetupTitle': 'Translate setup',
      'translateSetupSubtitle':
          'Choose the target language, review the subtitle source, and start the backend translation job.',
      'subtitleSourceFormatLabel': '{format} subtitle source',
      'targetLanguage': 'Target language',
      'startTranslation': 'Start translation',
      'translationProgressTitle': 'Translation progress',
      'translationProgressHeadline': 'AI subtitle translation in progress',
      'translationFailedTitle': 'Translation could not finish',
      'translationFailedMessage': 'Something went wrong.',
      'translationStageQueued': 'Queued for translation',
      'translationStageIdle': 'Waiting for a translation request',
      'translationStagePreparing': 'Preparing subtitle package',
      'translationStageAligning': 'Aligning timestamps and scene context',
      'translationStageGenerating': 'Generating subtitle translation',
      'translationStageReadability': 'Applying readability pass',
      'translationStageReady': 'Translation ready',
      'translationPreviewTitle': 'Translation preview',
      'translationPreviewHeader': 'Review translated subtitles',
      'translationPreviewSubtitle':
          'Search inside cues, switch preview modes, then export once the translation looks right.',
      'translationPreviewSearchHint': 'Search subtitle lines',
      'previewModeOriginal': 'Original',
      'previewModeTranslated': 'Translated',
      'previewModeBilingual': 'Bilingual',
      'previewNotReadyTitle': 'Preview cues are not available yet',
      'previewNotReadyMessage':
          'The translation finished, but the backend did not return preview cues yet. Try reloading this screen in a moment.',
      'previewNoMatchesTitle': 'No subtitle lines matched',
      'previewNoMatchesMessage':
          'Try a different search term or clear the filter to inspect the full translation.',
      'previewFailedTitle': 'Preview failed to load',
      'exportingLabel': 'Exporting...',
      'exportSubtitleLabel': 'Export translated subtitle',
      'exportedSnack':
          'Exported {fileName} to {path}',
      'exportFailedSnack': 'Export failed: {error}',
      'metadataFormat': 'Format',
      'metadataLines': 'Lines',
      'metadataLanguages': 'Languages',
      'metadataEstimatedDuration': 'Estimated duration',
      'subtitleSourcesTitle': 'English subtitle sources',
      'subtitleSourcesSubtitle':
          'Pick a subtitle source for {title}{target}, then choose the target language in the next step.',
      'subtitleSourcesFailedTitle': 'Could not load subtitle sources',
      'seriesSeasonsTitle': 'Choose a season',
      'seriesSeasonsSubtitle':
          'Pick a season of {title} to browse available episodes.',
      'seriesSeasonLabel': 'Season {seasonNumber}',
      'seriesSeasonMeta': '{episodeCount} episodes{year}',
      'seriesEpisodesTitle': 'Season {seasonNumber}',
      'seriesEpisodesSubtitle': '{episodeCount} episodes{year}',
      'seriesEpisodeLabel': 'Episode {episodeNumber}',
      'seriesEpisodeMeta': 'Approx. {runtime} min',
      'historyTitle': 'Translation history',
      'historySubtitle':
          'Reopen previous subtitle jobs, inspect the preview again, or export them later.',
      'historyEmptyTitle': 'History is empty',
      'historyEmptyMessage':
          'Your translated subtitle jobs will appear here after you complete a search or upload workflow.',
      'historyFailedTitle': 'Could not load history',
      'homeRecentJobsTitle': 'Recent jobs',
      'homeRecentJobsSubtitle':
          'Reopen your latest subtitle sessions without starting over.',
      'homeNoRecentTitle': 'No recent jobs yet',
      'homeNoRecentMessage':
          'Start with a movie search or upload a subtitle file and your recent translations will appear here.',
      'homeFailedRecentTitle': 'Could not load recent jobs',
      'homeTrustTitle': 'Why teams trust it',
      'homeTrustSubtitle':
          'Mocked today, but structured like a product that can ship for real.',
      'homeFutureTitle': 'Future-ready repositories',
      'homeFutureSubtitle':
          'Swappable mock repositories keep UI code insulated from backend changes.',
      'homePreviewTitle': 'Preview-first translation flow',
      'homePreviewSubtitle':
          'Inspect results before export with original, translated, or bilingual views.',
      'homeStatesTitle': 'Graceful states included',
      'homeStatesSubtitle':
          'Loading, empty, retry, validation, and mock offline scenarios are part of the UX from day one.',
      'navHome': 'Home',
      'navHistory': 'History',
      'navSettings': 'Settings',
      'heroTitle': 'Translate subtitles faster',
      'heroSubtitle':
          'Search movie and series catalogs, pick sources, and export polished translations in minutes.',
      'heroBadge': 'Premium subtitle workflow',
      'heroHeadline':
          'Translate movie and series subtitles with a studio-grade flow.',
      'heroBody':
          'Choose between a searchable title catalog or direct file upload, then preview and export polished subtitles in minutes.',
      'heroSearchCta': 'Search movie / series',
      'heroUploadCta': 'Upload subtitle',
      'heroStatPathsTitle': '2 paths',
      'heroStatPathsValue': 'Search or upload',
      'heroStatLanguagesTitle': '10 languages',
      'heroStatLanguagesValue': 'Ready for preview',
      'heroStatMockTitle': 'Mock APIs',
      'heroStatMockValue': 'Backend-ready seam',
      'settingsTitle': 'Settings',
      'settingsSubtitle':
          'Manage subtitle defaults, appearance, app information, and placeholder premium controls.',
      'settingsLanguageLabel': 'Preferred target language',
      'settingsThemeLabel': 'Appearance',
      'themeSystem': 'System',
      'themeDark': 'Dark',
      'themeLight': 'Light',
      'settingsPremiumTitle': 'Premium placeholder',
      'settingsPremiumSubtitle':
          'Later we can connect subscriptions, billing, and cloud project sync here.',
      'settingsSupportTitle': 'Support placeholder',
      'settingsSupportSubtitle': 'Mock help and contact page',
      'settingsPrivacyTitle': 'Privacy policy',
      'settingsPrivacySubtitle': 'Mock privacy content',
      'settingsTermsTitle': 'Terms of service',
      'settingsTermsSubtitle': 'Mock terms content',
      'settingsMaintenanceTitle': 'Maintenance',
      'settingsMaintenanceSubtitle':
          'Clear backend-owned translation jobs for this device and start with an empty history state.',
      'settingsHistoryClearedSnack':
          'Translation history cleared for this device',
      'settingsAboutTitle': 'About SubFlix',
      'settingsVersion': 'Version {version}',
      'settingsClearCache': 'Clear cache',
      'settingsCacheCleared': 'Cache cleared',
      'settingsFailedTitle': 'Settings failed to load',
      'legalPlaceholderBody':
          'This page is a placeholder in the demo app. Hook it up to your production legal content.',
      'legalTitlePrivacy': 'Privacy Policy',
      'legalTitleTerms': 'Terms of Service',
      'legalTitleSupport': 'Support',
      'legalTitleAbout': 'About SubFlix',
      'legalBodyPrivacy':
          'SubFlix currently stores only mock preferences and translation history on device through local persistence. A future backend integration can replace this with authenticated storage, audit trails, and server-managed retention policies.',
      'legalBodyTerms':
          'This mock build is intended to exercise product flows, UI states, and architecture boundaries. When a production NestJS and Postgres backend is connected later, the legal surface can be expanded with real service terms and data processing language.',
      'legalBodySupport':
          'Support is a placeholder for now. In a production release this section can connect to email, issue reporting, and premium account help while keeping the app shell unchanged.',
      'legalBodyAbout':
          'SubFlix is a premium-style Flutter client for AI subtitle translation. This build uses mock repositories, artificial latency, and local persistence so the UI and architecture can evolve before a real backend is attached.',
      'routeMissingSubtitleSourcesTitle': 'Subtitle sources',
      'routeMissingSubtitleSourcesMessage':
          'We could not determine which title to load subtitle sources for. Start again from search.',
      'routeMissingSeriesSeasonsTitle': 'Series seasons',
      'routeMissingSeriesSeasonsMessage':
          'We could not determine which series to load. Start again from search.',
      'routeMissingSeasonEpisodesTitle': 'Season episodes',
      'routeMissingSeasonEpisodesMessage':
          'We could not determine which season to load. Start again from search.',
      'routeMissingTranslationSetupTitle': 'Translation setup',
      'routeMissingTranslationSetupMessage':
          'A subtitle source is required before the translation setup screen can open.',
      'routeMissingTranslationProgressTitle': 'Translation progress',
      'routeMissingTranslationProgressMessage':
          'No translation request was provided. Start a new translation from search or upload.',
      'searchResultPopularity': 'Popularity {score}',
      'subtitleSourceLines': '{lineCount} lines',
      'subtitleSourceDownloads': '{downloads} downloads',
      'subtitleSourceRating': '{rating} rating',
      'subtitleSourceHiLabel': 'HI / SDH',
      'mediaTypeMovie': 'Movie',
      'mediaTypeSeries': 'Series',
      'jobReuseTranslation': 'Reuse translation',
      'jobReuseSubtitle': 'Reuse subtitle',
      'jobConfidence': 'Confidence: {level}',
      'jobOpenPreview': 'Open preview',
      'onboardingPage1Title':
          'Find movies or series and pull ready-to-translate subtitles.',
      'onboardingPage1Eyebrow': 'Search and fetch',
      'onboardingPage1Description':
          'Search a title, review the available English subtitle sources, and launch a translation workflow that feels instant.',
      'onboardingPage1Highlight1':
          'Deterministic mock catalog for reliable development',
      'onboardingPage1Highlight2':
          'Subtitle source quality labels and format badges',
      'onboardingPage1Highlight3':
          'Built to swap into a real backend later',
      'onboardingPage2Title':
          'Upload `.srt` or `.vtt` files when you already have the script.',
      'onboardingPage2Eyebrow': 'Bring your own file',
      'onboardingPage2Description':
          'Import your subtitle file, validate the format, and run the same polished translation pipeline without leaving the app.',
      'onboardingPage2Highlight1':
          'Local file validation and graceful retry states',
      'onboardingPage2Highlight2':
          'Consistent translation setup for uploads and search',
      'onboardingPage2Highlight3':
          'Preview before export so nothing feels opaque',
      'onboardingPage3Title':
          'Pick target languages, preview subtitles, and export instantly.',
      'onboardingPage3Eyebrow': 'Translate and export',
      'onboardingPage3Description':
          'Switch between original, translated, and bilingual views, revisit history, and export clean subtitle files once the result looks right.',
      'onboardingPage3Highlight1': 'Fast preview controls with metadata and search',
      'onboardingPage3Highlight2': 'History keeps previous jobs a tap away',
      'onboardingPage3Highlight3':
          'Designed like a premium media tool, not a demo',
      'onboardingStart': 'Start translation',
      'onboardingNext': 'Next',
      'onboardingSkip': 'Skip',
      'onboardingContinue': 'Continue',
      'onboardingEnterApp': 'Enter SubFlix',
      'splashHeadline': 'SubFlix',
      'splashSubtitle': 'AI-powered subtitle translation',
      'splashPreparing': 'Preparing your subtitle studio',
      'brandSubtitleCompact': 'Subtitle intelligence',
      'brandSubtitleFull': 'AI subtitle translation studio',
      'comingSoonTitle': 'Coming soon',
      'comingSoonMessage': 'We are still preparing this screen.',
    },
  };

  String _t(String key) =>
      _localizedValues[locale.languageCode]?[key] ??
      _localizedValues['en']![key]!;

  String _format(String key, Map<String, String> params) {
    var value = _t(key);
    params.forEach((paramKey, paramValue) {
      value = value.replaceAll('{$paramKey}', paramValue);
    });
    return value;
  }

  String get appTitle => _t('appTitle');
  String get searchTitles => _t('searchTitles');
  String get searchMovieOrSeriesTitle => _t('searchMovieOrSeriesTitle');
  String get searchMovieOrSeriesSubtitle => _t('searchMovieOrSeriesSubtitle');
  String get searchHintText => _t('searchHintText');
  String get searchMockTitle => _t('searchMockTitle');
  String get searchMockMessage => _t('searchMockMessage');
  String get searchFailedTitle => _t('searchFailedTitle');
  String get noTitlesMatchedTitle => _t('noTitlesMatchedTitle');
  String get noTitlesMatchedMessage => _t('noTitlesMatchedMessage');
  String get retry => _t('retry');
  String get retryTranslation => _t('retryTranslation');
  String get uploadSubtitleTitle => _t('uploadSubtitleTitle');
  String get uploadIntroTitle => _t('uploadIntroTitle');
  String get uploadIntroSubtitle => _t('uploadIntroSubtitle');
  String get uploadChooseFile => _t('uploadChooseFile');
  String get uploadSupportedFormatsTitle => _t('uploadSupportedFormatsTitle');
  String get uploadSupportedFormatsSubtitle =>
      _t('uploadSupportedFormatsSubtitle');
  String get uploadOpeningPicker => _t('uploadOpeningPicker');
  String get uploadChooseFileShort => _t('uploadChooseFileShort');
  String get uploadPickSubtitle => _t('uploadPickSubtitle');
  String get uploadPickedFile => _t('uploadPickedFile');
  String get uploadUseDemoFile => _t('uploadUseDemoFile');
  String get uploadFailedTitle => _t('uploadFailedTitle');
  String get uploadFailedMessage => _t('uploadFailedMessage');
  String get uploadFailedFallback => _t('uploadFailedFallback');
  String get tryAgain => _t('tryAgain');
  String get uploadMetadataTitle => _t('uploadMetadataTitle');
  String get uploadReadyTitle => _t('uploadReadyTitle');
  String uploadLineCount(int lineCount) =>
      _format('uploadLineCount', <String, String>{
        'lineCount': '$lineCount',
      });
  String get uploadEnglishSource => _t('uploadEnglishSource');
  String get uploadContinueSetup => _t('uploadContinueSetup');
  String get translateSetupTitle => _t('translateSetupTitle');
  String get translateSetupSubtitle => _t('translateSetupSubtitle');
  String subtitleSourceFormatLabel(String format) =>
      _format('subtitleSourceFormatLabel', <String, String>{
        'format': format,
      });
  String get targetLanguage => _t('targetLanguage');
  String get startTranslation => _t('startTranslation');
  String get translationProgressTitle => _t('translationProgressTitle');
  String get translationProgressHeadline => _t('translationProgressHeadline');
  String get translationFailedTitle => _t('translationFailedTitle');
  String get translationFailedMessage => _t('translationFailedMessage');
  String get translationStageQueued => _t('translationStageQueued');
  String get translationStageIdle => _t('translationStageIdle');
  String get translationStagePreparing => _t('translationStagePreparing');
  String get translationStageAligning => _t('translationStageAligning');
  String get translationStageGenerating => _t('translationStageGenerating');
  String get translationStageReadability => _t('translationStageReadability');
  String get translationStageReady => _t('translationStageReady');
  String get translationPreviewTitle => _t('translationPreviewTitle');
  String get translationPreviewHeader => _t('translationPreviewHeader');
  String get translationPreviewSubtitle => _t('translationPreviewSubtitle');
  String get translationPreviewSearchHint => _t('translationPreviewSearchHint');
  String get previewModeOriginal => _t('previewModeOriginal');
  String get previewModeTranslated => _t('previewModeTranslated');
  String get previewModeBilingual => _t('previewModeBilingual');
  String get previewNotReadyTitle => _t('previewNotReadyTitle');
  String get previewNotReadyMessage => _t('previewNotReadyMessage');
  String get previewNoMatchesTitle => _t('previewNoMatchesTitle');
  String get previewNoMatchesMessage => _t('previewNoMatchesMessage');
  String get previewFailedTitle => _t('previewFailedTitle');
  String get exportingLabel => _t('exportingLabel');
  String get exportSubtitleLabel => _t('exportSubtitleLabel');
  String exportedSnack(String fileName, String path) =>
      _format('exportedSnack', <String, String>{
        'fileName': fileName,
        'path': path,
      });
  String exportFailedSnack(String error) =>
      _format('exportFailedSnack', <String, String>{'error': error});
  String get metadataFormat => _t('metadataFormat');
  String get metadataLines => _t('metadataLines');
  String get metadataLanguages => _t('metadataLanguages');
  String get metadataEstimatedDuration => _t('metadataEstimatedDuration');
  String get subtitleSourcesTitle => _t('subtitleSourcesTitle');
  String subtitleSourcesSubtitle(String title, String target) =>
      _format('subtitleSourcesSubtitle', <String, String>{
        'title': title,
        'target': target,
      });
  String get subtitleSourcesFailedTitle => _t('subtitleSourcesFailedTitle');
  String get seriesSeasonsTitle => _t('seriesSeasonsTitle');
  String seriesSeasonsSubtitle(String title) =>
      _format('seriesSeasonsSubtitle', <String, String>{'title': title});
  String seriesSeasonLabel(int seasonNumber) =>
      _format('seriesSeasonLabel', <String, String>{
        'seasonNumber': '$seasonNumber',
      });
  String seriesSeasonMeta(int episodeCount, String year) =>
      _format('seriesSeasonMeta', <String, String>{
        'episodeCount': '$episodeCount',
        'year': year,
      });
  String seriesEpisodesTitle(int seasonNumber) =>
      _format('seriesEpisodesTitle', <String, String>{
        'seasonNumber': '$seasonNumber',
      });
  String seriesEpisodesSubtitle(int episodeCount, String year) =>
      _format('seriesEpisodesSubtitle', <String, String>{
        'episodeCount': '$episodeCount',
        'year': year,
      });
  String seriesEpisodeLabel(int episodeNumber) =>
      _format('seriesEpisodeLabel', <String, String>{
        'episodeNumber': '$episodeNumber',
      });
  String seriesEpisodeMeta(int runtime) =>
      _format('seriesEpisodeMeta', <String, String>{
        'runtime': '$runtime',
      });
  String get historyTitle => _t('historyTitle');
  String get historySubtitle => _t('historySubtitle');
  String get historyEmptyTitle => _t('historyEmptyTitle');
  String get historyEmptyMessage => _t('historyEmptyMessage');
  String get historyFailedTitle => _t('historyFailedTitle');
  String get homeRecentJobsTitle => _t('homeRecentJobsTitle');
  String get homeRecentJobsSubtitle => _t('homeRecentJobsSubtitle');
  String get homeNoRecentTitle => _t('homeNoRecentTitle');
  String get homeNoRecentMessage => _t('homeNoRecentMessage');
  String get homeFailedRecentTitle => _t('homeFailedRecentTitle');
  String get homeTrustTitle => _t('homeTrustTitle');
  String get homeTrustSubtitle => _t('homeTrustSubtitle');
  String get homeFutureTitle => _t('homeFutureTitle');
  String get homeFutureSubtitle => _t('homeFutureSubtitle');
  String get homePreviewTitle => _t('homePreviewTitle');
  String get homePreviewSubtitle => _t('homePreviewSubtitle');
  String get homeStatesTitle => _t('homeStatesTitle');
  String get homeStatesSubtitle => _t('homeStatesSubtitle');
  String get navHome => _t('navHome');
  String get navHistory => _t('navHistory');
  String get navSettings => _t('navSettings');
  String get heroTitle => _t('heroTitle');
  String get heroSubtitle => _t('heroSubtitle');
  String get heroBadge => _t('heroBadge');
  String get heroHeadline => _t('heroHeadline');
  String get heroBody => _t('heroBody');
  String get heroSearchCta => _t('heroSearchCta');
  String get heroUploadCta => _t('heroUploadCta');
  String get heroStatPathsTitle => _t('heroStatPathsTitle');
  String get heroStatPathsValue => _t('heroStatPathsValue');
  String get heroStatLanguagesTitle => _t('heroStatLanguagesTitle');
  String get heroStatLanguagesValue => _t('heroStatLanguagesValue');
  String get heroStatMockTitle => _t('heroStatMockTitle');
  String get heroStatMockValue => _t('heroStatMockValue');
  String get settingsTitle => _t('settingsTitle');
  String get settingsSubtitle => _t('settingsSubtitle');
  String get settingsLanguageLabel => _t('settingsLanguageLabel');
  String get settingsThemeLabel => _t('settingsThemeLabel');
  String get themeSystem => _t('themeSystem');
  String get themeDark => _t('themeDark');
  String get themeLight => _t('themeLight');
  String get settingsPremiumTitle => _t('settingsPremiumTitle');
  String get settingsPremiumSubtitle => _t('settingsPremiumSubtitle');
  String get settingsSupportTitle => _t('settingsSupportTitle');
  String get settingsSupportSubtitle => _t('settingsSupportSubtitle');
  String get settingsPrivacyTitle => _t('settingsPrivacyTitle');
  String get settingsPrivacySubtitle => _t('settingsPrivacySubtitle');
  String get settingsTermsTitle => _t('settingsTermsTitle');
  String get settingsTermsSubtitle => _t('settingsTermsSubtitle');
  String get settingsMaintenanceTitle => _t('settingsMaintenanceTitle');
  String get settingsMaintenanceSubtitle => _t('settingsMaintenanceSubtitle');
  String get settingsHistoryClearedSnack => _t('settingsHistoryClearedSnack');
  String get settingsAboutTitle => _t('settingsAboutTitle');
  String settingsVersion(String version) =>
      _format('settingsVersion', <String, String>{'version': version});
  String get settingsClearCache => _t('settingsClearCache');
  String get settingsCacheCleared => _t('settingsCacheCleared');
  String get settingsFailedTitle => _t('settingsFailedTitle');
  String get legalPlaceholderBody => _t('legalPlaceholderBody');
  String get legalTitlePrivacy => _t('legalTitlePrivacy');
  String get legalTitleTerms => _t('legalTitleTerms');
  String get legalTitleSupport => _t('legalTitleSupport');
  String get legalTitleAbout => _t('legalTitleAbout');
  String get legalBodyPrivacy => _t('legalBodyPrivacy');
  String get legalBodyTerms => _t('legalBodyTerms');
  String get legalBodySupport => _t('legalBodySupport');
  String get legalBodyAbout => _t('legalBodyAbout');
  String get routeMissingSubtitleSourcesTitle =>
      _t('routeMissingSubtitleSourcesTitle');
  String get routeMissingSubtitleSourcesMessage =>
      _t('routeMissingSubtitleSourcesMessage');
  String get routeMissingSeriesSeasonsTitle =>
      _t('routeMissingSeriesSeasonsTitle');
  String get routeMissingSeriesSeasonsMessage =>
      _t('routeMissingSeriesSeasonsMessage');
  String get routeMissingSeasonEpisodesTitle =>
      _t('routeMissingSeasonEpisodesTitle');
  String get routeMissingSeasonEpisodesMessage =>
      _t('routeMissingSeasonEpisodesMessage');
  String get routeMissingTranslationSetupTitle =>
      _t('routeMissingTranslationSetupTitle');
  String get routeMissingTranslationSetupMessage =>
      _t('routeMissingTranslationSetupMessage');
  String get routeMissingTranslationProgressTitle =>
      _t('routeMissingTranslationProgressTitle');
  String get routeMissingTranslationProgressMessage =>
      _t('routeMissingTranslationProgressMessage');
  String searchResultPopularity(String score) =>
      _format('searchResultPopularity', <String, String>{'score': score});
  String subtitleSourceLines(String lineCount) =>
      _format('subtitleSourceLines', <String, String>{'lineCount': lineCount});
  String subtitleSourceDownloads(String downloads) => _format(
        'subtitleSourceDownloads',
        <String, String>{'downloads': downloads},
      );
  String subtitleSourceRating(String rating) =>
      _format('subtitleSourceRating', <String, String>{'rating': rating});
  String get subtitleSourceHiLabel => _t('subtitleSourceHiLabel');
  String get mediaTypeMovie => _t('mediaTypeMovie');
  String get mediaTypeSeries => _t('mediaTypeSeries');
  String get jobReuseTranslation => _t('jobReuseTranslation');
  String get jobReuseSubtitle => _t('jobReuseSubtitle');
  String jobConfidence(String level) =>
      _format('jobConfidence', <String, String>{'level': level});
  String get jobOpenPreview => _t('jobOpenPreview');
  String get onboardingPage1Title => _t('onboardingPage1Title');
  String get onboardingPage1Eyebrow => _t('onboardingPage1Eyebrow');
  String get onboardingPage1Description => _t('onboardingPage1Description');
  String get onboardingPage1Highlight1 => _t('onboardingPage1Highlight1');
  String get onboardingPage1Highlight2 => _t('onboardingPage1Highlight2');
  String get onboardingPage1Highlight3 => _t('onboardingPage1Highlight3');
  String get onboardingPage2Title => _t('onboardingPage2Title');
  String get onboardingPage2Eyebrow => _t('onboardingPage2Eyebrow');
  String get onboardingPage2Description => _t('onboardingPage2Description');
  String get onboardingPage2Highlight1 => _t('onboardingPage2Highlight1');
  String get onboardingPage2Highlight2 => _t('onboardingPage2Highlight2');
  String get onboardingPage2Highlight3 => _t('onboardingPage2Highlight3');
  String get onboardingPage3Title => _t('onboardingPage3Title');
  String get onboardingPage3Eyebrow => _t('onboardingPage3Eyebrow');
  String get onboardingPage3Description => _t('onboardingPage3Description');
  String get onboardingPage3Highlight1 => _t('onboardingPage3Highlight1');
  String get onboardingPage3Highlight2 => _t('onboardingPage3Highlight2');
  String get onboardingPage3Highlight3 => _t('onboardingPage3Highlight3');
  String get onboardingStart => _t('onboardingStart');
  String get onboardingNext => _t('onboardingNext');
  String get onboardingSkip => _t('onboardingSkip');
  String get onboardingContinue => _t('onboardingContinue');
  String get onboardingEnterApp => _t('onboardingEnterApp');
  String get splashHeadline => _t('splashHeadline');
  String get splashSubtitle => _t('splashSubtitle');
  String get splashPreparing => _t('splashPreparing');
  String get brandSubtitleCompact => _t('brandSubtitleCompact');
  String get brandSubtitleFull => _t('brandSubtitleFull');
  String get comingSoonTitle => _t('comingSoonTitle');
  String get comingSoonMessage => _t('comingSoonMessage');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this);
}
