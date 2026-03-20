// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get brandSubtitleCompact => 'Subtitle intelligence';

  @override
  String get brandSubtitleFull => 'AI subtitle translation studio';

  @override
  String get comingSoonMessage => 'We are still preparing this screen.';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String exportFailedSnack(Object error) {
    return 'Export failed: $error';
  }

  @override
  String get exportSubtitleLabel => 'Export translated subtitle';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'Exported $fileName to $path';
  }

  @override
  String get exportingLabel => 'Exporting...';

  @override
  String get heroBadge => 'Premium subtitle workflow';

  @override
  String get heroBody =>
      'Choose between a searchable title catalog or direct file upload, then preview and export polished subtitles in minutes.';

  @override
  String get heroHeadline =>
      'Translate movie and series subtitles with a studio-grade flow.';

  @override
  String get heroSearchCta => 'Search movie / series';

  @override
  String get heroStatLanguagesTitle => '10 languages';

  @override
  String get heroStatLanguagesValue => 'Ready for preview';

  @override
  String get heroStatMockTitle => 'Mock APIs';

  @override
  String get heroStatMockValue => 'Backend-ready seam';

  @override
  String get heroStatPathsTitle => '2 paths';

  @override
  String get heroStatPathsValue => 'Search or upload';

  @override
  String get heroSubtitle =>
      'Search movie and series catalogs, pick sources, and export polished translations in minutes.';

  @override
  String get heroTitle => 'Translate subtitles faster';

  @override
  String get heroUploadCta => 'Upload subtitle';

  @override
  String historyCountLabel(Object count) {
    return '$count translations';
  }

  @override
  String get historyEmptyMessage =>
      'Your translated subtitle jobs will appear here after you complete a search or upload workflow.';

  @override
  String get historyEmptyTitle => 'History is empty';

  @override
  String get historyFailedItemMessage =>
      'Translation failed. Tap to start again.';

  @override
  String get historyFailedTitle => 'Could not load history';

  @override
  String get historyFilterAiTranslated => 'AI translated';

  @override
  String get historyFilterAll => 'All';

  @override
  String get historyFilterCompleted => 'Completed';

  @override
  String get historyFilterFailed => 'Failed';

  @override
  String get historyFilterMovies => 'Movies';

  @override
  String get historyFilterReused => 'Reused';

  @override
  String get historyFilterSeries => 'Series';

  @override
  String get historySubtitle =>
      'Reopen previous subtitle jobs, inspect the preview again, or export them later.';

  @override
  String get historyTitle => 'Translation history';

  @override
  String get homeFailedRecentTitle => 'Could not load recent jobs';

  @override
  String get homeFutureSubtitle =>
      'Swappable mock repositories keep UI code insulated from backend changes.';

  @override
  String get homeFutureTitle => 'Future-ready repositories';

  @override
  String get homeNoRecentMessage =>
      'Start with a movie search or upload a subtitle file and your recent translations will appear here.';

  @override
  String get homeNoRecentTitle => 'No recent jobs yet';

  @override
  String get homePreviewSubtitle =>
      'Inspect results before export with original, translated, or bilingual views.';

  @override
  String get homePreviewTitle => 'Preview-first translation flow';

  @override
  String get homeQuickHistory => 'History';

  @override
  String get homeQuickSearch => 'Search';

  @override
  String get homeQuickUpload => 'Upload';

  @override
  String get homeRecentJobsSubtitle =>
      'Reopen your latest subtitle sessions without starting over.';

  @override
  String get homeRecentJobsTitle => 'Recent jobs';

  @override
  String get homeSearchPlaceholder => 'Search movies or series...';

  @override
  String get homeStatesSubtitle =>
      'Loading, empty, retry, validation, and mock offline scenarios are part of the UX from day one.';

  @override
  String get homeStatesTitle => 'Graceful states included';

  @override
  String get homeTrendingNow => 'Trending now';

  @override
  String get homeTrustSubtitle =>
      'Mocked today, but structured like a product that can ship for real.';

  @override
  String get homeTrustTitle => 'Why teams trust it';

  @override
  String get homeViewAll => 'View all';

  @override
  String get homeWelcomeSubtitle => 'Find and translate subtitles';

  @override
  String get homeWelcomeTitle => 'Welcome back';

  @override
  String jobConfidence(Object level) {
    return 'Confidence: $level';
  }

  @override
  String get jobOpenPreview => 'Open preview';

  @override
  String get jobReuseSubtitle => 'Reuse subtitle';

  @override
  String get jobReuseTranslation => 'Reuse translation';

  @override
  String get legalBodyAbout =>
      'SubFlix is a premium-style Flutter client for AI subtitle translation. This build uses mock repositories, artificial latency, and local persistence so the UI and architecture can evolve before a real backend is attached.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix currently stores only mock preferences and translation history on device through local persistence. A future backend integration can replace this with authenticated storage, audit trails, and server-managed retention policies.';

  @override
  String get legalBodySupport =>
      'Support is a placeholder for now. In a production release this section can connect to email, issue reporting, and premium account help while keeping the app shell unchanged.';

  @override
  String get legalBodyTerms =>
      'This mock build is intended to exercise product flows, UI states, and architecture boundaries. When a production NestJS and Postgres backend is connected later, the legal surface can be expanded with real service terms and data processing language.';

  @override
  String get legalPlaceholderBody =>
      'This page is a placeholder in the demo app. Hook it up to your production legal content.';

  @override
  String get legalTitleAbout => 'About SubFlix';

  @override
  String get legalTitlePrivacy => 'Privacy Policy';

  @override
  String get legalTitleSupport => 'Support';

  @override
  String get legalTitleTerms => 'Terms of Service';

  @override
  String get mediaTypeMovie => 'Movie';

  @override
  String get mediaTypeSeries => 'Series';

  @override
  String get metadataEstimatedDuration => 'Estimated duration';

  @override
  String get metadataFormat => 'Format';

  @override
  String get metadataLanguages => 'Languages';

  @override
  String get metadataLines => 'Lines';

  @override
  String get navHistory => 'History';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Settings';

  @override
  String get noTitlesMatchedMessage =>
      'We could not find that title in the mock catalog. Try a broader search or one of the suggested shows.';

  @override
  String get noTitlesMatchedTitle => 'No titles matched';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingEnterApp => 'Enter SubFlix';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingPage1Description =>
      'Search a title, review the available English subtitle sources, and launch a translation workflow that feels instant.';

  @override
  String get onboardingPage1Eyebrow => 'Search and fetch';

  @override
  String get onboardingPage1Highlight1 =>
      'Deterministic mock catalog for reliable development';

  @override
  String get onboardingPage1Highlight2 =>
      'Subtitle source quality labels and format badges';

  @override
  String get onboardingPage1Highlight3 =>
      'Built to swap into a real backend later';

  @override
  String get onboardingPage1Title =>
      'Find movies or series and pull ready-to-translate subtitles.';

  @override
  String get onboardingPage2Description =>
      'Import your subtitle file, validate the format, and run the same polished translation pipeline without leaving the app.';

  @override
  String get onboardingPage2Eyebrow => 'Bring your own file';

  @override
  String get onboardingPage2Highlight1 =>
      'Local file validation and graceful retry states';

  @override
  String get onboardingPage2Highlight2 =>
      'Consistent translation setup for uploads and search';

  @override
  String get onboardingPage2Highlight3 =>
      'Preview before export so nothing feels opaque';

  @override
  String get onboardingPage2Title =>
      'Upload `.srt` or `.vtt` files when you already have the script.';

  @override
  String get onboardingPage3Description =>
      'Switch between original, translated, and bilingual views, revisit history, and export clean subtitle files once the result looks right.';

  @override
  String get onboardingPage3Eyebrow => 'Translate and export';

  @override
  String get onboardingPage3Highlight1 =>
      'Fast preview controls with metadata and search';

  @override
  String get onboardingPage3Highlight2 =>
      'History keeps previous jobs a tap away';

  @override
  String get onboardingPage3Highlight3 =>
      'Designed like a premium media tool, not a demo';

  @override
  String get onboardingPage3Title =>
      'Pick target languages, preview subtitles, and export instantly.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingStart => 'Start translation';

  @override
  String get previewFailedTitle => 'Preview failed to load';

  @override
  String get previewModeBilingual => 'Bilingual';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Translated';

  @override
  String get previewNoMatchesMessage =>
      'Try a different search term or clear the filter to inspect the full translation.';

  @override
  String get previewNoMatchesTitle => 'No subtitle lines matched';

  @override
  String get previewNotReadyMessage =>
      'The translation finished, but the backend did not return preview cues yet. Try reloading this screen in a moment.';

  @override
  String get previewNotReadyTitle => 'Preview cues are not available yet';

  @override
  String get retry => 'Retry';

  @override
  String get retryTranslation => 'Retry translation';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'We could not determine which season to load. Start again from search.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Season episodes';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'We could not determine which series to load. Start again from search.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Series seasons';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'We could not determine which title to load subtitle sources for. Start again from search.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Subtitle sources';

  @override
  String get routeMissingTranslationProgressMessage =>
      'No translation request was provided. Start a new translation from search or upload.';

  @override
  String get routeMissingTranslationProgressTitle => 'Translation progress';

  @override
  String get routeMissingTranslationSetupMessage =>
      'A subtitle source is required before the translation setup screen can open.';

  @override
  String get routeMissingTranslationSetupTitle => 'Translation setup';

  @override
  String get searchFailedTitle => 'Search failed';

  @override
  String searchFoundResults(Object count, Object query) {
    return 'Found $count results for \"$query\"';
  }

  @override
  String get searchHintText => 'Search for Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Searching...';

  @override
  String get searchMockMessage =>
      'Try titles like Inception, Dune, Breaking Bad, Severance, or The Last of Us to explore the subtitle source flow.';

  @override
  String get searchMockTitle => 'Search anything in the mock catalog';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Find a title, inspect subtitle sources, and launch a translation job with a few taps.';

  @override
  String get searchMovieOrSeriesTitle => 'Search movie or series';

  @override
  String searchNoResultsFor(Object query) {
    return 'No results found for \"$query\"';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularity $score';
  }

  @override
  String get searchTitles => 'Search titles';

  @override
  String get searchTrendingTitle => 'Trending searches';

  @override
  String get searchTryDifferentKeywords =>
      'Try searching with different keywords.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Episode $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Approx. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount episodes$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Season $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Season $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount episodes$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Pick a season of $title to browse available episodes.';
  }

  @override
  String get seriesSeasonsTitle => 'Choose a season';

  @override
  String get settingsAboutTitle => 'About SubFlix';

  @override
  String get settingsCacheCleared => 'Cache cleared';

  @override
  String get settingsClearCache => 'Clear cache';

  @override
  String get settingsContactTitle => 'Contact us';

  @override
  String get settingsFailedTitle => 'Settings failed to load';

  @override
  String get settingsHelpCenterTitle => 'Help center';

  @override
  String get settingsHistoryClearedSnack =>
      'Translation history cleared for this device';

  @override
  String get settingsLanguageLabel => 'Preferred target language';

  @override
  String get settingsMaintenanceSubtitle =>
      'Clear backend-owned translation jobs for this device and start with an empty history state.';

  @override
  String get settingsMaintenanceTitle => 'Maintenance';

  @override
  String get settingsNotificationsSubtitle => 'Manage notification preferences';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsPremiumSubtitle =>
      'Later we can connect subscriptions, billing, and cloud project sync here.';

  @override
  String get settingsPremiumTitle => 'Premium placeholder';

  @override
  String get settingsPrivacySubtitle => 'Mock privacy content';

  @override
  String get settingsPrivacyTitle => 'Privacy policy';

  @override
  String get settingsProfileName => 'SubFlix User';

  @override
  String get settingsProfileTier => 'Premium member';

  @override
  String get settingsSubtitle => 'Manager your preferences';

  @override
  String get settingsSupportSubtitle => 'Mock help and contact page';

  @override
  String get settingsSupportTitle => 'Support placeholder';

  @override
  String get settingsTermsSubtitle => 'Mock terms content';

  @override
  String get settingsTermsTitle => 'Terms of service';

  @override
  String get settingsThemeLabel => 'Appearance';

  @override
  String get settingsTitle => 'Settings';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Preparing your subtitle studio';

  @override
  String get splashSubtitle => 'AI-powered subtitle translation';

  @override
  String get startTranslation => 'Start translation';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads downloads';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format subtitle source';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount lines';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return '$rating rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Select a subtitle source and continue into a polished translation setup tuned for subtitle timing.';

  @override
  String get subtitleSourcesBannerTitle => 'AI translation available';

  @override
  String get subtitleSourcesFailedTitle => 'Could not load subtitle sources';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Pick a subtitle source for $title$target, then choose the target language in the next step.';
  }

  @override
  String get subtitleSourcesTitle => 'English subtitle sources';

  @override
  String get targetLanguage => 'Target language';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get translateSetupAutoDetect => 'Auto-detect format';

  @override
  String get translateSetupAutoDetectBody =>
      'Choose the right subtitle output structure automatically.';

  @override
  String get translateSetupLanguageTitle => 'Translate to';

  @override
  String get translateSetupOptionsTitle => 'Options';

  @override
  String get translateSetupPreserveTiming => 'Preserve timing';

  @override
  String get translateSetupPreserveTimingBody =>
      'Keep original subtitle timings aligned to the source file.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Our translation flow will adapt this subtitle into $language with preserved timing and clean cue structure.';
  }

  @override
  String get translateSetupReadyTitle => 'AI translation ready';

  @override
  String get translateSetupSelectLanguage => 'Select language';

  @override
  String get translateSetupSourceTitle => 'Source subtitle';

  @override
  String get translateSetupSubtitle =>
      'Choose the target language, review the subtitle source, and start the backend translation job.';

  @override
  String get translateSetupTitle => 'Translate setup';

  @override
  String get translationFailedMessage => 'Something went wrong.';

  @override
  String get translationFailedTitle => 'Translation could not finish';

  @override
  String get translationPreviewHeader => 'Review translated subtitles';

  @override
  String get translationPreviewSearchHint => 'Search subtitle lines';

  @override
  String get translationPreviewSubtitle =>
      'Search inside cues, switch preview modes, then export once the translation looks right.';

  @override
  String get translationPreviewTitle => 'Translation preview';

  @override
  String get translationProgressHeadline =>
      'AI subtitle translation in progress';

  @override
  String get translationProgressTitle => 'Translation progress';

  @override
  String get translationResultCompleteSubtitle =>
      'Your subtitle is ready to preview or download.';

  @override
  String get translationResultCompleteTitle => 'Translation complete';

  @override
  String get translationResultConfidenceLabel => 'Translation confidence';

  @override
  String get translationResultDetailsTitle => 'Translation details';

  @override
  String get translationResultDownloadCta => 'Download subtitle';

  @override
  String get translationResultHomeCta => 'Back to home';

  @override
  String get translationResultMediaLabel => 'Media title';

  @override
  String get translationResultMethodAi => 'AI translated';

  @override
  String get translationResultMetricsTitle => 'Quality metrics';

  @override
  String get translationResultPreviewCta => 'Preview subtitle';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Processed in $duration';
  }

  @override
  String get translationResultSourceLabel => 'Source language';

  @override
  String get translationResultTargetLabel => 'Target language';

  @override
  String get translationResultTimingLabel => 'Timing accuracy';

  @override
  String get translationResultTimingPreserved => 'Timing preserved';

  @override
  String get translationResultWarning =>
      'Some technical terms may still benefit from a quick human review for context.';

  @override
  String get translationStageAligning =>
      'Aligning timestamps and scene context';

  @override
  String get translationStageGenerating => 'Generating subtitle translation';

  @override
  String get translationStageIdle => 'Waiting for a translation request';

  @override
  String get translationStagePreparing => 'Preparing subtitle package';

  @override
  String get translationStageQueued => 'Queued for translation';

  @override
  String get translationStageReadability => 'Applying readability pass';

  @override
  String get translationStageReady => 'Translation ready';

  @override
  String get tryAgain => 'Try again';

  @override
  String get uploadChooseFile => 'Choose subtitle file';

  @override
  String get uploadChooseFileShort => 'Choose file';

  @override
  String get uploadContinueSetup => 'Continue to translation setup';

  @override
  String get uploadEnglishSource => 'English source';

  @override
  String get uploadFailedFallback => 'Please try another subtitle file.';

  @override
  String get uploadFailedMessage =>
      'We could not read this subtitle file. Try a different file or pick a smaller export.';

  @override
  String get uploadFailedTitle => 'File import failed';

  @override
  String get uploadIntroSubtitle =>
      'Import an English `.srt` or `.vtt` file, let the backend validate and parse it, then continue into translation setup.';

  @override
  String get uploadIntroTitle => 'Bring your own subtitle file';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount lines';
  }

  @override
  String get uploadMetadataTitle => 'Subtitle details';

  @override
  String get uploadOpeningPicker => 'Opening picker...';

  @override
  String get uploadPickSubtitle => 'Pick subtitle file';

  @override
  String get uploadPickedFile => 'Picked subtitle file';

  @override
  String get uploadReadyTitle => 'Ready to translate';

  @override
  String get uploadSubtitleTitle => 'Upload subtitle';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'English `.srt` and `.vtt` subtitle files';

  @override
  String get uploadSupportedFormatsTitle => 'Supported formats';

  @override
  String get uploadUseDemoFile => 'Use demo file';
}
