import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SubFlix'**
  String get appTitle;

  /// No description provided for @brandSubtitleCompact.
  ///
  /// In en, this message translates to:
  /// **'Subtitle intelligence'**
  String get brandSubtitleCompact;

  /// No description provided for @brandSubtitleFull.
  ///
  /// In en, this message translates to:
  /// **'AI subtitle translation studio'**
  String get brandSubtitleFull;

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'We are still preparing this screen.'**
  String get comingSoonMessage;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// No description provided for @exportFailedSnack.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportFailedSnack(Object error);

  /// No description provided for @exportSubtitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Export translated subtitle'**
  String get exportSubtitleLabel;

  /// No description provided for @exportedSnack.
  ///
  /// In en, this message translates to:
  /// **'Exported {fileName} to {path}'**
  String exportedSnack(Object fileName, Object path);

  /// No description provided for @exportingLabel.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exportingLabel;

  /// No description provided for @heroBadge.
  ///
  /// In en, this message translates to:
  /// **'Premium subtitle workflow'**
  String get heroBadge;

  /// No description provided for @heroBody.
  ///
  /// In en, this message translates to:
  /// **'Choose between a searchable title catalog or direct file upload, then preview and export polished subtitles in minutes.'**
  String get heroBody;

  /// No description provided for @heroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Translate movie and series subtitles with a studio-grade flow.'**
  String get heroHeadline;

  /// No description provided for @heroSearchCta.
  ///
  /// In en, this message translates to:
  /// **'Search movie / series'**
  String get heroSearchCta;

  /// No description provided for @heroStatLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'10 languages'**
  String get heroStatLanguagesTitle;

  /// No description provided for @heroStatLanguagesValue.
  ///
  /// In en, this message translates to:
  /// **'Ready for preview'**
  String get heroStatLanguagesValue;

  /// No description provided for @heroStatMockTitle.
  ///
  /// In en, this message translates to:
  /// **'Mock APIs'**
  String get heroStatMockTitle;

  /// No description provided for @heroStatMockValue.
  ///
  /// In en, this message translates to:
  /// **'Backend-ready seam'**
  String get heroStatMockValue;

  /// No description provided for @heroStatPathsTitle.
  ///
  /// In en, this message translates to:
  /// **'2 paths'**
  String get heroStatPathsTitle;

  /// No description provided for @heroStatPathsValue.
  ///
  /// In en, this message translates to:
  /// **'Search or upload'**
  String get heroStatPathsValue;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search movie and series catalogs, pick sources, and export polished translations in minutes.'**
  String get heroSubtitle;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate subtitles faster'**
  String get heroTitle;

  /// No description provided for @heroUploadCta.
  ///
  /// In en, this message translates to:
  /// **'Upload subtitle'**
  String get heroUploadCta;

  /// No description provided for @historyCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} translations'**
  String historyCountLabel(Object count);

  /// No description provided for @historyEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your translated subtitle jobs will appear here after you complete a search or upload workflow.'**
  String get historyEmptyMessage;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'History is empty'**
  String get historyEmptyTitle;

  /// No description provided for @historyFailedItemMessage.
  ///
  /// In en, this message translates to:
  /// **'Translation failed. Tap to start again.'**
  String get historyFailedItemMessage;

  /// No description provided for @historyFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load history'**
  String get historyFailedTitle;

  /// No description provided for @historyFilterAiTranslated.
  ///
  /// In en, this message translates to:
  /// **'AI translated'**
  String get historyFilterAiTranslated;

  /// No description provided for @historyFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get historyFilterAll;

  /// No description provided for @historyFilterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get historyFilterCompleted;

  /// No description provided for @historyFilterFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get historyFilterFailed;

  /// No description provided for @historyFilterMovies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get historyFilterMovies;

  /// No description provided for @historyFilterReused.
  ///
  /// In en, this message translates to:
  /// **'Reused'**
  String get historyFilterReused;

  /// No description provided for @historyFilterSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get historyFilterSeries;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reopen previous subtitle jobs, inspect the preview again, or export them later.'**
  String get historySubtitle;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation history'**
  String get historyTitle;

  /// No description provided for @homeFailedRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load recent jobs'**
  String get homeFailedRecentTitle;

  /// No description provided for @homeFutureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swappable mock repositories keep UI code insulated from backend changes.'**
  String get homeFutureSubtitle;

  /// No description provided for @homeFutureTitle.
  ///
  /// In en, this message translates to:
  /// **'Future-ready repositories'**
  String get homeFutureTitle;

  /// No description provided for @homeNoRecentMessage.
  ///
  /// In en, this message translates to:
  /// **'Start with a movie search or upload a subtitle file and your recent translations will appear here.'**
  String get homeNoRecentMessage;

  /// No description provided for @homeNoRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'No recent jobs yet'**
  String get homeNoRecentTitle;

  /// No description provided for @homePreviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Inspect results before export with original, translated, or bilingual views.'**
  String get homePreviewSubtitle;

  /// No description provided for @homePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview-first translation flow'**
  String get homePreviewTitle;

  /// No description provided for @homeQuickHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get homeQuickHistory;

  /// No description provided for @homeQuickSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeQuickSearch;

  /// No description provided for @homeQuickUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get homeQuickUpload;

  /// No description provided for @homeRecentJobsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reopen your latest subtitle sessions without starting over.'**
  String get homeRecentJobsSubtitle;

  /// No description provided for @homeRecentJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent jobs'**
  String get homeRecentJobsTitle;

  /// No description provided for @homeSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search movies or series...'**
  String get homeSearchPlaceholder;

  /// No description provided for @homeStatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Loading, empty, retry, validation, and mock offline scenarios are part of the UX from day one.'**
  String get homeStatesSubtitle;

  /// No description provided for @homeStatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Graceful states included'**
  String get homeStatesTitle;

  /// No description provided for @homeTrendingNow.
  ///
  /// In en, this message translates to:
  /// **'Trending now'**
  String get homeTrendingNow;

  /// No description provided for @homeTrustSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mocked today, but structured like a product that can ship for real.'**
  String get homeTrustSubtitle;

  /// No description provided for @homeTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'Why teams trust it'**
  String get homeTrustTitle;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAll;

  /// No description provided for @homeWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find and translate subtitles'**
  String get homeWelcomeSubtitle;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get homeWelcomeTitle;

  /// No description provided for @jobConfidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence: {level}'**
  String jobConfidence(Object level);

  /// No description provided for @jobOpenPreview.
  ///
  /// In en, this message translates to:
  /// **'Open preview'**
  String get jobOpenPreview;

  /// No description provided for @jobReuseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reuse subtitle'**
  String get jobReuseSubtitle;

  /// No description provided for @jobReuseTranslation.
  ///
  /// In en, this message translates to:
  /// **'Reuse translation'**
  String get jobReuseTranslation;

  /// No description provided for @legalBodyAbout.
  ///
  /// In en, this message translates to:
  /// **'SubFlix is a premium-style Flutter client for AI subtitle translation. This build uses mock repositories, artificial latency, and local persistence so the UI and architecture can evolve before a real backend is attached.'**
  String get legalBodyAbout;

  /// No description provided for @legalBodyPrivacy.
  ///
  /// In en, this message translates to:
  /// **'SubFlix currently stores only mock preferences and translation history on device through local persistence. A future backend integration can replace this with authenticated storage, audit trails, and server-managed retention policies.'**
  String get legalBodyPrivacy;

  /// No description provided for @legalBodySupport.
  ///
  /// In en, this message translates to:
  /// **'Support is a placeholder for now. In a production release this section can connect to email, issue reporting, and premium account help while keeping the app shell unchanged.'**
  String get legalBodySupport;

  /// No description provided for @legalBodyTerms.
  ///
  /// In en, this message translates to:
  /// **'This mock build is intended to exercise product flows, UI states, and architecture boundaries. When a production NestJS and Postgres backend is connected later, the legal surface can be expanded with real service terms and data processing language.'**
  String get legalBodyTerms;

  /// No description provided for @legalPlaceholderBody.
  ///
  /// In en, this message translates to:
  /// **'This page is a placeholder in the demo app. Hook it up to your production legal content.'**
  String get legalPlaceholderBody;

  /// No description provided for @legalTitleAbout.
  ///
  /// In en, this message translates to:
  /// **'About SubFlix'**
  String get legalTitleAbout;

  /// No description provided for @legalTitlePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get legalTitlePrivacy;

  /// No description provided for @legalTitleSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get legalTitleSupport;

  /// No description provided for @legalTitleTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get legalTitleTerms;

  /// No description provided for @mediaTypeMovie.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get mediaTypeMovie;

  /// No description provided for @mediaTypeSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get mediaTypeSeries;

  /// No description provided for @metadataEstimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Estimated duration'**
  String get metadataEstimatedDuration;

  /// No description provided for @metadataFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get metadataFormat;

  /// No description provided for @metadataLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get metadataLanguages;

  /// No description provided for @metadataLines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get metadataLines;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @noTitlesMatchedMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not find that title in the mock catalog. Try a broader search or one of the suggested shows.'**
  String get noTitlesMatchedMessage;

  /// No description provided for @noTitlesMatchedTitle.
  ///
  /// In en, this message translates to:
  /// **'No titles matched'**
  String get noTitlesMatchedTitle;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingEnterApp.
  ///
  /// In en, this message translates to:
  /// **'Enter SubFlix'**
  String get onboardingEnterApp;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingPage1Description.
  ///
  /// In en, this message translates to:
  /// **'Search a title, review the available English subtitle sources, and launch a translation workflow that feels instant.'**
  String get onboardingPage1Description;

  /// No description provided for @onboardingPage1Eyebrow.
  ///
  /// In en, this message translates to:
  /// **'Search and fetch'**
  String get onboardingPage1Eyebrow;

  /// No description provided for @onboardingPage1Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Deterministic mock catalog for reliable development'**
  String get onboardingPage1Highlight1;

  /// No description provided for @onboardingPage1Highlight2.
  ///
  /// In en, this message translates to:
  /// **'Subtitle source quality labels and format badges'**
  String get onboardingPage1Highlight2;

  /// No description provided for @onboardingPage1Highlight3.
  ///
  /// In en, this message translates to:
  /// **'Built to swap into a real backend later'**
  String get onboardingPage1Highlight3;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Find movies or series and pull ready-to-translate subtitles.'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage2Description.
  ///
  /// In en, this message translates to:
  /// **'Import your subtitle file, validate the format, and run the same polished translation pipeline without leaving the app.'**
  String get onboardingPage2Description;

  /// No description provided for @onboardingPage2Eyebrow.
  ///
  /// In en, this message translates to:
  /// **'Bring your own file'**
  String get onboardingPage2Eyebrow;

  /// No description provided for @onboardingPage2Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Local file validation and graceful retry states'**
  String get onboardingPage2Highlight1;

  /// No description provided for @onboardingPage2Highlight2.
  ///
  /// In en, this message translates to:
  /// **'Consistent translation setup for uploads and search'**
  String get onboardingPage2Highlight2;

  /// No description provided for @onboardingPage2Highlight3.
  ///
  /// In en, this message translates to:
  /// **'Preview before export so nothing feels opaque'**
  String get onboardingPage2Highlight3;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Upload `.srt` or `.vtt` files when you already have the script.'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage3Description.
  ///
  /// In en, this message translates to:
  /// **'Switch between original, translated, and bilingual views, revisit history, and export clean subtitle files once the result looks right.'**
  String get onboardingPage3Description;

  /// No description provided for @onboardingPage3Eyebrow.
  ///
  /// In en, this message translates to:
  /// **'Translate and export'**
  String get onboardingPage3Eyebrow;

  /// No description provided for @onboardingPage3Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Fast preview controls with metadata and search'**
  String get onboardingPage3Highlight1;

  /// No description provided for @onboardingPage3Highlight2.
  ///
  /// In en, this message translates to:
  /// **'History keeps previous jobs a tap away'**
  String get onboardingPage3Highlight2;

  /// No description provided for @onboardingPage3Highlight3.
  ///
  /// In en, this message translates to:
  /// **'Designed like a premium media tool, not a demo'**
  String get onboardingPage3Highlight3;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Pick target languages, preview subtitles, and export instantly.'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start translation'**
  String get onboardingStart;

  /// No description provided for @previewFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview failed to load'**
  String get previewFailedTitle;

  /// No description provided for @previewModeBilingual.
  ///
  /// In en, this message translates to:
  /// **'Bilingual'**
  String get previewModeBilingual;

  /// No description provided for @previewModeOriginal.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get previewModeOriginal;

  /// No description provided for @previewModeTranslated.
  ///
  /// In en, this message translates to:
  /// **'Translated'**
  String get previewModeTranslated;

  /// No description provided for @previewNoMatchesMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term or clear the filter to inspect the full translation.'**
  String get previewNoMatchesMessage;

  /// No description provided for @previewNoMatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'No subtitle lines matched'**
  String get previewNoMatchesTitle;

  /// No description provided for @previewNotReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'The translation finished, but the backend did not return preview cues yet. Try reloading this screen in a moment.'**
  String get previewNotReadyMessage;

  /// No description provided for @previewNotReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview cues are not available yet'**
  String get previewNotReadyTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @retryTranslation.
  ///
  /// In en, this message translates to:
  /// **'Retry translation'**
  String get retryTranslation;

  /// No description provided for @routeMissingSeasonEpisodesMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which season to load. Start again from search.'**
  String get routeMissingSeasonEpisodesMessage;

  /// No description provided for @routeMissingSeasonEpisodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Season episodes'**
  String get routeMissingSeasonEpisodesTitle;

  /// No description provided for @routeMissingSeriesSeasonsMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which series to load. Start again from search.'**
  String get routeMissingSeriesSeasonsMessage;

  /// No description provided for @routeMissingSeriesSeasonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Series seasons'**
  String get routeMissingSeriesSeasonsTitle;

  /// No description provided for @routeMissingSubtitleSourcesMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which title to load subtitle sources for. Start again from search.'**
  String get routeMissingSubtitleSourcesMessage;

  /// No description provided for @routeMissingSubtitleSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Subtitle sources'**
  String get routeMissingSubtitleSourcesTitle;

  /// No description provided for @routeMissingTranslationProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'No translation request was provided. Start a new translation from search or upload.'**
  String get routeMissingTranslationProgressMessage;

  /// No description provided for @routeMissingTranslationProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation progress'**
  String get routeMissingTranslationProgressTitle;

  /// No description provided for @routeMissingTranslationSetupMessage.
  ///
  /// In en, this message translates to:
  /// **'A subtitle source is required before the translation setup screen can open.'**
  String get routeMissingTranslationSetupMessage;

  /// No description provided for @routeMissingTranslationSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation setup'**
  String get routeMissingTranslationSetupTitle;

  /// No description provided for @searchFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get searchFailedTitle;

  /// No description provided for @searchFoundResults.
  ///
  /// In en, this message translates to:
  /// **'Found {count} results for \"{query}\"'**
  String searchFoundResults(Object count, Object query);

  /// No description provided for @searchHintText.
  ///
  /// In en, this message translates to:
  /// **'Search for Dune, Breaking Bad, Severance...'**
  String get searchHintText;

  /// No description provided for @searchLoadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searchLoadingLabel;

  /// No description provided for @searchMockMessage.
  ///
  /// In en, this message translates to:
  /// **'Try titles like Inception, Dune, Breaking Bad, Severance, or The Last of Us to explore the subtitle source flow.'**
  String get searchMockMessage;

  /// No description provided for @searchMockTitle.
  ///
  /// In en, this message translates to:
  /// **'Search anything in the mock catalog'**
  String get searchMockTitle;

  /// No description provided for @searchMovieOrSeriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find a title, inspect subtitle sources, and launch a translation job with a few taps.'**
  String get searchMovieOrSeriesSubtitle;

  /// No description provided for @searchMovieOrSeriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Search movie or series'**
  String get searchMovieOrSeriesTitle;

  /// No description provided for @searchNoResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results found for \"{query}\"'**
  String searchNoResultsFor(Object query);

  /// No description provided for @searchResultPopularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity {score}'**
  String searchResultPopularity(Object score);

  /// No description provided for @searchTitles.
  ///
  /// In en, this message translates to:
  /// **'Search titles'**
  String get searchTitles;

  /// No description provided for @searchTrendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Trending searches'**
  String get searchTrendingTitle;

  /// No description provided for @searchTryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords.'**
  String get searchTryDifferentKeywords;

  /// No description provided for @seriesEpisodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Episode {episodeNumber}'**
  String seriesEpisodeLabel(Object episodeNumber);

  /// No description provided for @seriesEpisodeMeta.
  ///
  /// In en, this message translates to:
  /// **'Approx. {runtime} min'**
  String seriesEpisodeMeta(Object runtime);

  /// No description provided for @seriesEpisodesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{episodeCount} episodes{year}'**
  String seriesEpisodesSubtitle(Object episodeCount, Object year);

  /// No description provided for @seriesEpisodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Season {seasonNumber}'**
  String seriesEpisodesTitle(Object seasonNumber);

  /// No description provided for @seriesSeasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Season {seasonNumber}'**
  String seriesSeasonLabel(Object seasonNumber);

  /// No description provided for @seriesSeasonMeta.
  ///
  /// In en, this message translates to:
  /// **'{episodeCount} episodes{year}'**
  String seriesSeasonMeta(Object episodeCount, Object year);

  /// No description provided for @seriesSeasonsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a season of {title} to browse available episodes.'**
  String seriesSeasonsSubtitle(Object title);

  /// No description provided for @seriesSeasonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a season'**
  String get seriesSeasonsTitle;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About SubFlix'**
  String get settingsAboutTitle;

  /// No description provided for @settingsCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared'**
  String get settingsCacheCleared;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settingsClearCache;

  /// No description provided for @settingsContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get settingsContactTitle;

  /// No description provided for @settingsFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings failed to load'**
  String get settingsFailedTitle;

  /// No description provided for @settingsHelpCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get settingsHelpCenterTitle;

  /// No description provided for @settingsHistoryClearedSnack.
  ///
  /// In en, this message translates to:
  /// **'Translation history cleared for this device'**
  String get settingsHistoryClearedSnack;

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred target language'**
  String get settingsLanguageLabel;

  /// No description provided for @settingsMaintenanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear backend-owned translation jobs for this device and start with an empty history state.'**
  String get settingsMaintenanceSubtitle;

  /// No description provided for @settingsMaintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get settingsMaintenanceTitle;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsPremiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Later we can connect subscriptions, billing, and cloud project sync here.'**
  String get settingsPremiumSubtitle;

  /// No description provided for @settingsPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium placeholder'**
  String get settingsPremiumTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mock privacy content'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsProfileName.
  ///
  /// In en, this message translates to:
  /// **'SubFlix User'**
  String get settingsProfileName;

  /// No description provided for @settingsProfileTier.
  ///
  /// In en, this message translates to:
  /// **'Premium member'**
  String get settingsProfileTier;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manager your preferences'**
  String get settingsSubtitle;

  /// No description provided for @settingsSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mock help and contact page'**
  String get settingsSupportSubtitle;

  /// No description provided for @settingsSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support placeholder'**
  String get settingsSupportTitle;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mock terms content'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingsTermsTitle;

  /// No description provided for @settingsThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsThemeLabel;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(Object version);

  /// No description provided for @splashHeadline.
  ///
  /// In en, this message translates to:
  /// **'SubFlix'**
  String get splashHeadline;

  /// No description provided for @splashPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing your subtitle studio'**
  String get splashPreparing;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI-powered subtitle translation'**
  String get splashSubtitle;

  /// No description provided for @startTranslation.
  ///
  /// In en, this message translates to:
  /// **'Start translation'**
  String get startTranslation;

  /// No description provided for @subtitleSourceDownloads.
  ///
  /// In en, this message translates to:
  /// **'{downloads} downloads'**
  String subtitleSourceDownloads(Object downloads);

  /// No description provided for @subtitleSourceFormatLabel.
  ///
  /// In en, this message translates to:
  /// **'{format} subtitle source'**
  String subtitleSourceFormatLabel(Object format);

  /// No description provided for @subtitleSourceHiLabel.
  ///
  /// In en, this message translates to:
  /// **'HI / SDH'**
  String get subtitleSourceHiLabel;

  /// No description provided for @subtitleSourceLines.
  ///
  /// In en, this message translates to:
  /// **'{lineCount} lines'**
  String subtitleSourceLines(Object lineCount);

  /// No description provided for @subtitleSourceRating.
  ///
  /// In en, this message translates to:
  /// **'{rating} rating'**
  String subtitleSourceRating(Object rating);

  /// No description provided for @subtitleSourcesBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Select a subtitle source and continue into a polished translation setup tuned for subtitle timing.'**
  String get subtitleSourcesBannerMessage;

  /// No description provided for @subtitleSourcesBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'AI translation available'**
  String get subtitleSourcesBannerTitle;

  /// No description provided for @subtitleSourcesFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load subtitle sources'**
  String get subtitleSourcesFailedTitle;

  /// No description provided for @subtitleSourcesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a subtitle source for {title}{target}, then choose the target language in the next step.'**
  String subtitleSourcesSubtitle(Object title, Object target);

  /// No description provided for @subtitleSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'English subtitle sources'**
  String get subtitleSourcesTitle;

  /// No description provided for @targetLanguage.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get targetLanguage;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @translateSetupAutoDetect.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect format'**
  String get translateSetupAutoDetect;

  /// No description provided for @translateSetupAutoDetectBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the right subtitle output structure automatically.'**
  String get translateSetupAutoDetectBody;

  /// No description provided for @translateSetupLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate to'**
  String get translateSetupLanguageTitle;

  /// No description provided for @translateSetupOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get translateSetupOptionsTitle;

  /// No description provided for @translateSetupPreserveTiming.
  ///
  /// In en, this message translates to:
  /// **'Preserve timing'**
  String get translateSetupPreserveTiming;

  /// No description provided for @translateSetupPreserveTimingBody.
  ///
  /// In en, this message translates to:
  /// **'Keep original subtitle timings aligned to the source file.'**
  String get translateSetupPreserveTimingBody;

  /// No description provided for @translateSetupReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Our translation flow will adapt this subtitle into {language} with preserved timing and clean cue structure.'**
  String translateSetupReadyBody(Object language);

  /// No description provided for @translateSetupReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'AI translation ready'**
  String get translateSetupReadyTitle;

  /// No description provided for @translateSetupSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get translateSetupSelectLanguage;

  /// No description provided for @translateSetupSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Source subtitle'**
  String get translateSetupSourceTitle;

  /// No description provided for @translateSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the target language, review the subtitle source, and start the backend translation job.'**
  String get translateSetupSubtitle;

  /// No description provided for @translateSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate setup'**
  String get translateSetupTitle;

  /// No description provided for @translationFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get translationFailedMessage;

  /// No description provided for @translationFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation could not finish'**
  String get translationFailedTitle;

  /// No description provided for @translationPreviewHeader.
  ///
  /// In en, this message translates to:
  /// **'Review translated subtitles'**
  String get translationPreviewHeader;

  /// No description provided for @translationPreviewSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search subtitle lines'**
  String get translationPreviewSearchHint;

  /// No description provided for @translationPreviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search inside cues, switch preview modes, then export once the translation looks right.'**
  String get translationPreviewSubtitle;

  /// No description provided for @translationPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation preview'**
  String get translationPreviewTitle;

  /// No description provided for @translationProgressHeadline.
  ///
  /// In en, this message translates to:
  /// **'AI subtitle translation in progress'**
  String get translationProgressHeadline;

  /// No description provided for @translationProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation progress'**
  String get translationProgressTitle;

  /// No description provided for @translationResultCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your subtitle is ready to preview or download.'**
  String get translationResultCompleteSubtitle;

  /// No description provided for @translationResultCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation complete'**
  String get translationResultCompleteTitle;

  /// No description provided for @translationResultConfidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation confidence'**
  String get translationResultConfidenceLabel;

  /// No description provided for @translationResultDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation details'**
  String get translationResultDetailsTitle;

  /// No description provided for @translationResultDownloadCta.
  ///
  /// In en, this message translates to:
  /// **'Download subtitle'**
  String get translationResultDownloadCta;

  /// No description provided for @translationResultHomeCta.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get translationResultHomeCta;

  /// No description provided for @translationResultMediaLabel.
  ///
  /// In en, this message translates to:
  /// **'Media title'**
  String get translationResultMediaLabel;

  /// No description provided for @translationResultMethodAi.
  ///
  /// In en, this message translates to:
  /// **'AI translated'**
  String get translationResultMethodAi;

  /// No description provided for @translationResultMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality metrics'**
  String get translationResultMetricsTitle;

  /// No description provided for @translationResultPreviewCta.
  ///
  /// In en, this message translates to:
  /// **'Preview subtitle'**
  String get translationResultPreviewCta;

  /// No description provided for @translationResultProcessedIn.
  ///
  /// In en, this message translates to:
  /// **'Processed in {duration}'**
  String translationResultProcessedIn(Object duration);

  /// No description provided for @translationResultSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get translationResultSourceLabel;

  /// No description provided for @translationResultTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get translationResultTargetLabel;

  /// No description provided for @translationResultTimingLabel.
  ///
  /// In en, this message translates to:
  /// **'Timing accuracy'**
  String get translationResultTimingLabel;

  /// No description provided for @translationResultTimingPreserved.
  ///
  /// In en, this message translates to:
  /// **'Timing preserved'**
  String get translationResultTimingPreserved;

  /// No description provided for @translationResultWarning.
  ///
  /// In en, this message translates to:
  /// **'Some technical terms may still benefit from a quick human review for context.'**
  String get translationResultWarning;

  /// No description provided for @translationStageAligning.
  ///
  /// In en, this message translates to:
  /// **'Aligning timestamps and scene context'**
  String get translationStageAligning;

  /// No description provided for @translationStageGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating subtitle translation'**
  String get translationStageGenerating;

  /// No description provided for @translationStageIdle.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a translation request'**
  String get translationStageIdle;

  /// No description provided for @translationStagePreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing subtitle package'**
  String get translationStagePreparing;

  /// No description provided for @translationStageQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued for translation'**
  String get translationStageQueued;

  /// No description provided for @translationStageReadability.
  ///
  /// In en, this message translates to:
  /// **'Applying readability pass'**
  String get translationStageReadability;

  /// No description provided for @translationStageReady.
  ///
  /// In en, this message translates to:
  /// **'Translation ready'**
  String get translationStageReady;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @uploadChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose subtitle file'**
  String get uploadChooseFile;

  /// No description provided for @uploadChooseFileShort.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get uploadChooseFileShort;

  /// No description provided for @uploadContinueSetup.
  ///
  /// In en, this message translates to:
  /// **'Continue to translation setup'**
  String get uploadContinueSetup;

  /// No description provided for @uploadEnglishSource.
  ///
  /// In en, this message translates to:
  /// **'English source'**
  String get uploadEnglishSource;

  /// No description provided for @uploadFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Please try another subtitle file.'**
  String get uploadFailedFallback;

  /// No description provided for @uploadFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not read this subtitle file. Try a different file or pick a smaller export.'**
  String get uploadFailedMessage;

  /// No description provided for @uploadFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'File import failed'**
  String get uploadFailedTitle;

  /// No description provided for @uploadIntroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import an English `.srt` or `.vtt` file, let the backend validate and parse it, then continue into translation setup.'**
  String get uploadIntroSubtitle;

  /// No description provided for @uploadIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Bring your own subtitle file'**
  String get uploadIntroTitle;

  /// No description provided for @uploadLineCount.
  ///
  /// In en, this message translates to:
  /// **'{lineCount} lines'**
  String uploadLineCount(Object lineCount);

  /// No description provided for @uploadMetadataTitle.
  ///
  /// In en, this message translates to:
  /// **'Subtitle details'**
  String get uploadMetadataTitle;

  /// No description provided for @uploadOpeningPicker.
  ///
  /// In en, this message translates to:
  /// **'Opening picker...'**
  String get uploadOpeningPicker;

  /// No description provided for @uploadPickSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick subtitle file'**
  String get uploadPickSubtitle;

  /// No description provided for @uploadPickedFile.
  ///
  /// In en, this message translates to:
  /// **'Picked subtitle file'**
  String get uploadPickedFile;

  /// No description provided for @uploadReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to translate'**
  String get uploadReadyTitle;

  /// No description provided for @uploadSubtitleTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload subtitle'**
  String get uploadSubtitleTitle;

  /// No description provided for @uploadSupportedFormatsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English `.srt` and `.vtt` subtitle files'**
  String get uploadSupportedFormatsSubtitle;

  /// No description provided for @uploadSupportedFormatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Supported formats'**
  String get uploadSupportedFormatsTitle;

  /// No description provided for @uploadUseDemoFile.
  ///
  /// In en, this message translates to:
  /// **'Use demo file'**
  String get uploadUseDemoFile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
