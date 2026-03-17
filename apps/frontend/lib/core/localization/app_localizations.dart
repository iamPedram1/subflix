import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:subflix/core/localization/strings_ar.dart';
import 'package:subflix/core/localization/strings_de.dart';
import 'package:subflix/core/localization/strings_en.dart';
import 'package:subflix/core/localization/strings_es.dart';
import 'package:subflix/core/localization/strings_fa.dart';
import 'package:subflix/core/localization/strings_fr.dart';
import 'package:subflix/core/localization/strings_hi.dart';
import 'package:subflix/core/localization/strings_ja.dart';
import 'package:subflix/core/localization/strings_pt.dart';
import 'package:subflix/core/localization/strings_zh.dart';

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
    Locale('pt'),
    Locale('es'),
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
        'en': kStringsEn,
        'fa': kStringsFa,
        'ar': kStringsAr,
        'fr': kStringsFr,
        'de': kStringsDe,
        'ja': kStringsJa,
        'zh': kStringsZh,
        'hi': kStringsHi,
        'pt': kStringsPt,
        'es': kStringsEs,
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
  String get searchTrendingTitle => _t('searchTrendingTitle');
  String get searchLoadingLabel => _t('searchLoadingLabel');
  String searchFoundResults(int count, String query) => _format(
    'searchFoundResults',
    <String, String>{'count': '$count', 'query': query},
  );
  String searchNoResultsFor(String query) =>
      _format('searchNoResultsFor', <String, String>{'query': query});
  String get searchTryDifferentKeywords => _t('searchTryDifferentKeywords');
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
      _format('uploadLineCount', <String, String>{'lineCount': '$lineCount'});
  String get uploadEnglishSource => _t('uploadEnglishSource');
  String get uploadContinueSetup => _t('uploadContinueSetup');
  String get translateSetupTitle => _t('translateSetupTitle');
  String get translateSetupSubtitle => _t('translateSetupSubtitle');
  String subtitleSourceFormatLabel(String format) =>
      _format('subtitleSourceFormatLabel', <String, String>{'format': format});
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
  String get translationResultCompleteTitle =>
      _t('translationResultCompleteTitle');
  String get translationResultCompleteSubtitle =>
      _t('translationResultCompleteSubtitle');
  String get translationResultDetailsTitle =>
      _t('translationResultDetailsTitle');
  String get translationResultMediaLabel => _t('translationResultMediaLabel');
  String get translationResultSourceLabel => _t('translationResultSourceLabel');
  String get translationResultTargetLabel => _t('translationResultTargetLabel');
  String get translationResultMethodAi => _t('translationResultMethodAi');
  String get translationResultMetricsTitle =>
      _t('translationResultMetricsTitle');
  String get translationResultConfidenceLabel =>
      _t('translationResultConfidenceLabel');
  String get translationResultTimingLabel => _t('translationResultTimingLabel');
  String get translationResultTimingPreserved =>
      _t('translationResultTimingPreserved');
  String translationResultProcessedIn(String duration) => _format(
    'translationResultProcessedIn',
    <String, String>{'duration': duration},
  );
  String get translationResultWarning => _t('translationResultWarning');
  String get translationResultPreviewCta => _t('translationResultPreviewCta');
  String get translationResultDownloadCta => _t('translationResultDownloadCta');
  String get translationResultHomeCta => _t('translationResultHomeCta');
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
  String exportedSnack(String fileName, String path) => _format(
    'exportedSnack',
    <String, String>{'fileName': fileName, 'path': path},
  );
  String exportFailedSnack(String error) =>
      _format('exportFailedSnack', <String, String>{'error': error});
  String get metadataFormat => _t('metadataFormat');
  String get metadataLines => _t('metadataLines');
  String get metadataLanguages => _t('metadataLanguages');
  String get metadataEstimatedDuration => _t('metadataEstimatedDuration');
  String get subtitleSourcesTitle => _t('subtitleSourcesTitle');
  String subtitleSourcesSubtitle(String title, String target) => _format(
    'subtitleSourcesSubtitle',
    <String, String>{'title': title, 'target': target},
  );
  String get subtitleSourcesFailedTitle => _t('subtitleSourcesFailedTitle');
  String get seriesSeasonsTitle => _t('seriesSeasonsTitle');
  String seriesSeasonsSubtitle(String title) =>
      _format('seriesSeasonsSubtitle', <String, String>{'title': title});
  String seriesSeasonLabel(int seasonNumber) => _format(
    'seriesSeasonLabel',
    <String, String>{'seasonNumber': '$seasonNumber'},
  );
  String seriesSeasonMeta(int episodeCount, String year) => _format(
    'seriesSeasonMeta',
    <String, String>{'episodeCount': '$episodeCount', 'year': year},
  );
  String seriesEpisodesTitle(int seasonNumber) => _format(
    'seriesEpisodesTitle',
    <String, String>{'seasonNumber': '$seasonNumber'},
  );
  String seriesEpisodesSubtitle(int episodeCount, String year) => _format(
    'seriesEpisodesSubtitle',
    <String, String>{'episodeCount': '$episodeCount', 'year': year},
  );
  String seriesEpisodeLabel(int episodeNumber) => _format(
    'seriesEpisodeLabel',
    <String, String>{'episodeNumber': '$episodeNumber'},
  );
  String seriesEpisodeMeta(int runtime) =>
      _format('seriesEpisodeMeta', <String, String>{'runtime': '$runtime'});
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
  String get homeWelcomeTitle => _t('homeWelcomeTitle');
  String get homeWelcomeSubtitle => _t('homeWelcomeSubtitle');
  String get homeSearchPlaceholder => _t('homeSearchPlaceholder');
  String get homeQuickSearch => _t('homeQuickSearch');
  String get homeQuickHistory => _t('homeQuickHistory');
  String get homeQuickUpload => _t('homeQuickUpload');
  String get homeViewAll => _t('homeViewAll');
  String get homeTrendingNow => _t('homeTrendingNow');
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
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
    (supported) => supported.languageCode == locale.languageCode,
  );

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
