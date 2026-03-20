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
/// import 'generated/app_localizations.dart';
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

  /// Localized text for app title in the application UI.
  ///
  /// In en, this message translates to:
  /// **'SubFlix'**
  String get appTitle;

  /// Localized text for brand subtitle compact in the branding UI.
  ///
  /// In en, this message translates to:
  /// **'Subtitle intelligence'**
  String get brandSubtitleCompact;

  /// Localized text for brand subtitle full in the branding UI.
  ///
  /// In en, this message translates to:
  /// **'AI subtitle translation studio'**
  String get brandSubtitleFull;

  /// Localized text for coming soon message in the coming soon UI.
  ///
  /// In en, this message translates to:
  /// **'We are still preparing this screen.'**
  String get comingSoonMessage;

  /// Localized text for coming soon title in the coming soon UI.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// Localized text for export failed snack in the application UI. Uses placeholder: error.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportFailedSnack(Object error);

  /// Localized text for export subtitle label in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Export translated subtitle'**
  String get exportSubtitleLabel;

  /// Localized text for exported snack in the application UI. Uses placeholders: fileName, path.
  ///
  /// In en, this message translates to:
  /// **'Exported {fileName} to {path}'**
  String exportedSnack(Object fileName, Object path);

  /// Localized text for exporting label in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exportingLabel;

  /// Localized text for hero badge in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Premium subtitle workflow'**
  String get heroBadge;

  /// Localized text for hero body in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Choose between a searchable title catalog or direct file upload, then preview and export polished subtitles in minutes.'**
  String get heroBody;

  /// Localized text for hero headline in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Translate movie and series subtitles with a studio-grade flow.'**
  String get heroHeadline;

  /// Localized text for hero search cta in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Search movie / series'**
  String get heroSearchCta;

  /// Localized text for hero stat languages title in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'10 languages'**
  String get heroStatLanguagesTitle;

  /// Localized text for hero stat languages value in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Ready for preview'**
  String get heroStatLanguagesValue;

  /// Localized text for hero stat mock title in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Mock APIs'**
  String get heroStatMockTitle;

  /// Localized text for hero stat mock value in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Backend-ready seam'**
  String get heroStatMockValue;

  /// Localized text for hero stat paths title in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'2 paths'**
  String get heroStatPathsTitle;

  /// Localized text for hero stat paths value in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Search or upload'**
  String get heroStatPathsValue;

  /// Localized text for hero subtitle in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Search movie and series catalogs, pick sources, and export polished translations in minutes.'**
  String get heroSubtitle;

  /// Localized text for hero title in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Translate subtitles faster'**
  String get heroTitle;

  /// Localized text for hero upload cta in the hero section UI.
  ///
  /// In en, this message translates to:
  /// **'Upload subtitle'**
  String get heroUploadCta;

  /// Localized text for history count label in the history UI. Uses placeholder: count.
  ///
  /// In en, this message translates to:
  /// **'{count} translations'**
  String historyCountLabel(Object count);

  /// Localized text for history empty message in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Your translated subtitle jobs will appear here after you complete a search or upload workflow.'**
  String get historyEmptyMessage;

  /// Localized text for history empty title in the history UI.
  ///
  /// In en, this message translates to:
  /// **'History is empty'**
  String get historyEmptyTitle;

  /// Localized text for history failed item message in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Translation failed. Tap to start again.'**
  String get historyFailedItemMessage;

  /// Localized text for history failed title in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Could not load history'**
  String get historyFailedTitle;

  /// Localized text for history filter ai translated in the history UI.
  ///
  /// In en, this message translates to:
  /// **'AI translated'**
  String get historyFilterAiTranslated;

  /// Localized text for history filter all in the history UI.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get historyFilterAll;

  /// Localized text for history filter completed in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get historyFilterCompleted;

  /// Localized text for history filter failed in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get historyFilterFailed;

  /// Localized text for history filter movies in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get historyFilterMovies;

  /// Localized text for history filter reused in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Reused'**
  String get historyFilterReused;

  /// Localized text for history filter series in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get historyFilterSeries;

  /// Localized text for history subtitle in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Reopen previous subtitle jobs, inspect the preview again, or export them later.'**
  String get historySubtitle;

  /// Localized text for history title in the history UI.
  ///
  /// In en, this message translates to:
  /// **'Translation history'**
  String get historyTitle;

  /// Localized text for home failed recent title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Could not load recent jobs'**
  String get homeFailedRecentTitle;

  /// Localized text for home future subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Swappable mock repositories keep UI code insulated from backend changes.'**
  String get homeFutureSubtitle;

  /// Localized text for home future title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Future-ready repositories'**
  String get homeFutureTitle;

  /// Localized text for home no recent message in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Start with a movie search or upload a subtitle file and your recent translations will appear here.'**
  String get homeNoRecentMessage;

  /// Localized text for home no recent title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'No recent jobs yet'**
  String get homeNoRecentTitle;

  /// Localized text for home preview subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Inspect results before export with original, translated, or bilingual views.'**
  String get homePreviewSubtitle;

  /// Localized text for home preview title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Preview-first translation flow'**
  String get homePreviewTitle;

  /// Localized text for home quick history in the home UI.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get homeQuickHistory;

  /// Localized text for home quick search in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeQuickSearch;

  /// Localized text for home quick upload in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get homeQuickUpload;

  /// Localized text for home recent jobs subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Reopen your latest subtitle sessions without starting over.'**
  String get homeRecentJobsSubtitle;

  /// Localized text for home recent jobs title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Recent jobs'**
  String get homeRecentJobsTitle;

  /// Localized text for home search placeholder in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Search movies or series...'**
  String get homeSearchPlaceholder;

  /// Localized text for home states subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Loading, empty, retry, validation, and mock offline scenarios are part of the UX from day one.'**
  String get homeStatesSubtitle;

  /// Localized text for home states title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Graceful states included'**
  String get homeStatesTitle;

  /// Localized text for home trending now in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Trending now'**
  String get homeTrendingNow;

  /// Localized text for home trust subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Mocked today, but structured like a product that can ship for real.'**
  String get homeTrustSubtitle;

  /// Localized text for home trust title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Why teams trust it'**
  String get homeTrustTitle;

  /// Localized text for home view all in the home UI.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAll;

  /// Localized text for home welcome subtitle in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Find and translate subtitles'**
  String get homeWelcomeSubtitle;

  /// Localized text for home welcome title in the home UI.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get homeWelcomeTitle;

  /// Localized text for job confidence in the job summary UI. Uses placeholder: level.
  ///
  /// In en, this message translates to:
  /// **'Confidence: {level}'**
  String jobConfidence(Object level);

  /// Localized text for job open preview in the job summary UI.
  ///
  /// In en, this message translates to:
  /// **'Open preview'**
  String get jobOpenPreview;

  /// Localized text for job reuse subtitle in the job summary UI.
  ///
  /// In en, this message translates to:
  /// **'Reuse subtitle'**
  String get jobReuseSubtitle;

  /// Localized text for job reuse translation in the job summary UI.
  ///
  /// In en, this message translates to:
  /// **'Reuse translation'**
  String get jobReuseTranslation;

  /// Localized text for legal body about in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'SubFlix is a premium-style Flutter client for AI subtitle translation. This build uses mock repositories, artificial latency, and local persistence so the UI and architecture can evolve before a real backend is attached.'**
  String get legalBodyAbout;

  /// Localized text for legal body privacy in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'SubFlix currently stores only mock preferences and translation history on device through local persistence. A future backend integration can replace this with authenticated storage, audit trails, and server-managed retention policies.'**
  String get legalBodyPrivacy;

  /// Localized text for legal body support in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'Support is a placeholder for now. In a production release this section can connect to email, issue reporting, and premium account help while keeping the app shell unchanged.'**
  String get legalBodySupport;

  /// Localized text for legal body terms in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'This mock build is intended to exercise product flows, UI states, and architecture boundaries. When a production NestJS and Postgres backend is connected later, the legal surface can be expanded with real service terms and data processing language.'**
  String get legalBodyTerms;

  /// Localized text for legal placeholder body in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'This page is a placeholder in the demo app. Hook it up to your production legal content.'**
  String get legalPlaceholderBody;

  /// Localized text for legal title about in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'About SubFlix'**
  String get legalTitleAbout;

  /// Localized text for legal title privacy in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get legalTitlePrivacy;

  /// Localized text for legal title support in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get legalTitleSupport;

  /// Localized text for legal title terms in the legal UI.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get legalTitleTerms;

  /// Localized text for media type movie in the media type UI.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get mediaTypeMovie;

  /// Localized text for media type series in the media type UI.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get mediaTypeSeries;

  /// Localized text for metadata estimated duration in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Estimated duration'**
  String get metadataEstimatedDuration;

  /// Localized text for metadata format in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get metadataFormat;

  /// Localized text for metadata languages in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get metadataLanguages;

  /// Localized text for metadata lines in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get metadataLines;

  /// Localized text for nav history in the navigation UI.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// Localized text for nav home in the navigation UI.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Localized text for nav settings in the navigation UI.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Localized text for no titles matched message in the application UI.
  ///
  /// In en, this message translates to:
  /// **'We could not find that title in the mock catalog. Try a broader search or one of the suggested shows.'**
  String get noTitlesMatchedMessage;

  /// Localized text for no titles matched title in the application UI.
  ///
  /// In en, this message translates to:
  /// **'No titles matched'**
  String get noTitlesMatchedTitle;

  /// Localized text for onboarding continue in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// Localized text for onboarding enter app in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Enter SubFlix'**
  String get onboardingEnterApp;

  /// Localized text for onboarding next in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// Localized text for onboarding page1 description in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Search a title, review the available English subtitle sources, and launch a translation workflow that feels instant.'**
  String get onboardingPage1Description;

  /// Localized text for onboarding page1 eyebrow in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Search and fetch'**
  String get onboardingPage1Eyebrow;

  /// Localized text for onboarding page1 highlight1 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Deterministic mock catalog for reliable development'**
  String get onboardingPage1Highlight1;

  /// Localized text for onboarding page1 highlight2 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Subtitle source quality labels and format badges'**
  String get onboardingPage1Highlight2;

  /// Localized text for onboarding page1 highlight3 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Built to swap into a real backend later'**
  String get onboardingPage1Highlight3;

  /// Localized text for onboarding page1 title in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Find movies or series and pull ready-to-translate subtitles.'**
  String get onboardingPage1Title;

  /// Localized text for onboarding page2 description in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Import your subtitle file, validate the format, and run the same polished translation pipeline without leaving the app.'**
  String get onboardingPage2Description;

  /// Localized text for onboarding page2 eyebrow in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Bring your own file'**
  String get onboardingPage2Eyebrow;

  /// Localized text for onboarding page2 highlight1 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Local file validation and graceful retry states'**
  String get onboardingPage2Highlight1;

  /// Localized text for onboarding page2 highlight2 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Consistent translation setup for uploads and search'**
  String get onboardingPage2Highlight2;

  /// Localized text for onboarding page2 highlight3 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Preview before export so nothing feels opaque'**
  String get onboardingPage2Highlight3;

  /// Localized text for onboarding page2 title in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Upload `.srt` or `.vtt` files when you already have the script.'**
  String get onboardingPage2Title;

  /// Localized text for onboarding page3 description in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Switch between original, translated, and bilingual views, revisit history, and export clean subtitle files once the result looks right.'**
  String get onboardingPage3Description;

  /// Localized text for onboarding page3 eyebrow in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Translate and export'**
  String get onboardingPage3Eyebrow;

  /// Localized text for onboarding page3 highlight1 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Fast preview controls with metadata and search'**
  String get onboardingPage3Highlight1;

  /// Localized text for onboarding page3 highlight2 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'History keeps previous jobs a tap away'**
  String get onboardingPage3Highlight2;

  /// Localized text for onboarding page3 highlight3 in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Designed like a premium media tool, not a demo'**
  String get onboardingPage3Highlight3;

  /// Localized text for onboarding page3 title in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Pick target languages, preview subtitles, and export instantly.'**
  String get onboardingPage3Title;

  /// Localized text for onboarding skip in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// Localized text for onboarding start in the onboarding UI.
  ///
  /// In en, this message translates to:
  /// **'Start translation'**
  String get onboardingStart;

  /// Localized text for preview failed title in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Preview failed to load'**
  String get previewFailedTitle;

  /// Localized text for preview mode bilingual in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Bilingual'**
  String get previewModeBilingual;

  /// Localized text for preview mode original in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get previewModeOriginal;

  /// Localized text for preview mode translated in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Translated'**
  String get previewModeTranslated;

  /// Localized text for preview no matches message in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term or clear the filter to inspect the full translation.'**
  String get previewNoMatchesMessage;

  /// Localized text for preview no matches title in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'No subtitle lines matched'**
  String get previewNoMatchesTitle;

  /// Localized text for preview not ready message in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'The translation finished, but the backend did not return preview cues yet. Try reloading this screen in a moment.'**
  String get previewNotReadyMessage;

  /// Localized text for preview not ready title in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Preview cues are not available yet'**
  String get previewNotReadyTitle;

  /// Localized text for retry in the shared action UI.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Localized text for retry translation in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Retry translation'**
  String get retryTranslation;

  /// Localized text for route missing season episodes message in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which season to load. Start again from search.'**
  String get routeMissingSeasonEpisodesMessage;

  /// Localized text for route missing season episodes title in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'Season episodes'**
  String get routeMissingSeasonEpisodesTitle;

  /// Localized text for route missing series seasons message in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which series to load. Start again from search.'**
  String get routeMissingSeriesSeasonsMessage;

  /// Localized text for route missing series seasons title in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'Series seasons'**
  String get routeMissingSeriesSeasonsTitle;

  /// Localized text for route missing subtitle sources message in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'We could not determine which title to load subtitle sources for. Start again from search.'**
  String get routeMissingSubtitleSourcesMessage;

  /// Localized text for route missing subtitle sources title in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'Subtitle sources'**
  String get routeMissingSubtitleSourcesTitle;

  /// Localized text for route missing translation progress message in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'No translation request was provided. Start a new translation from search or upload.'**
  String get routeMissingTranslationProgressMessage;

  /// Localized text for route missing translation progress title in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'Translation progress'**
  String get routeMissingTranslationProgressTitle;

  /// Localized text for route missing translation setup message in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'A subtitle source is required before the translation setup screen can open.'**
  String get routeMissingTranslationSetupMessage;

  /// Localized text for route missing translation setup title in the route fallback UI.
  ///
  /// In en, this message translates to:
  /// **'Translation setup'**
  String get routeMissingTranslationSetupTitle;

  /// Localized text for search failed title in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get searchFailedTitle;

  /// Localized text for search found results in the search UI. Uses placeholders: count, query.
  ///
  /// In en, this message translates to:
  /// **'Found {count} results for \"{query}\"'**
  String searchFoundResults(Object count, Object query);

  /// Localized text for search hint text in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Search for Dune, Breaking Bad, Severance...'**
  String get searchHintText;

  /// Localized text for search loading label in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searchLoadingLabel;

  /// Localized text for search mock message in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Try titles like Inception, Dune, Breaking Bad, Severance, or The Last of Us to explore the subtitle source flow.'**
  String get searchMockMessage;

  /// Localized text for search mock title in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Search anything in the mock catalog'**
  String get searchMockTitle;

  /// Localized text for search movie or series subtitle in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Find a title, inspect subtitle sources, and launch a translation job with a few taps.'**
  String get searchMovieOrSeriesSubtitle;

  /// Localized text for search movie or series title in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Search movie or series'**
  String get searchMovieOrSeriesTitle;

  /// Localized text for search no results for in the search UI. Uses placeholder: query.
  ///
  /// In en, this message translates to:
  /// **'No results found for \"{query}\"'**
  String searchNoResultsFor(Object query);

  /// Localized text for search result popularity in the search UI. Uses placeholder: score.
  ///
  /// In en, this message translates to:
  /// **'Popularity {score}'**
  String searchResultPopularity(Object score);

  /// Localized text for search titles in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Search titles'**
  String get searchTitles;

  /// Localized text for search trending title in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Trending searches'**
  String get searchTrendingTitle;

  /// Localized text for search try different keywords in the search UI.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords.'**
  String get searchTryDifferentKeywords;

  /// Localized text for series episode label in the series browsing UI. Uses placeholder: episodeNumber.
  ///
  /// In en, this message translates to:
  /// **'Episode {episodeNumber}'**
  String seriesEpisodeLabel(Object episodeNumber);

  /// Localized text for series episode meta in the series browsing UI. Uses placeholder: runtime.
  ///
  /// In en, this message translates to:
  /// **'Approx. {runtime} min'**
  String seriesEpisodeMeta(Object runtime);

  /// Localized text for series episodes subtitle in the series browsing UI. Uses placeholders: episodeCount, year.
  ///
  /// In en, this message translates to:
  /// **'{episodeCount} episodes{year}'**
  String seriesEpisodesSubtitle(Object episodeCount, Object year);

  /// Localized text for series episodes title in the series browsing UI. Uses placeholder: seasonNumber.
  ///
  /// In en, this message translates to:
  /// **'Season {seasonNumber}'**
  String seriesEpisodesTitle(Object seasonNumber);

  /// Localized text for series season label in the series browsing UI. Uses placeholder: seasonNumber.
  ///
  /// In en, this message translates to:
  /// **'Season {seasonNumber}'**
  String seriesSeasonLabel(Object seasonNumber);

  /// Localized text for series season meta in the series browsing UI. Uses placeholders: episodeCount, year.
  ///
  /// In en, this message translates to:
  /// **'{episodeCount} episodes{year}'**
  String seriesSeasonMeta(Object episodeCount, Object year);

  /// Localized text for series seasons subtitle in the series browsing UI. Uses placeholder: title.
  ///
  /// In en, this message translates to:
  /// **'Pick a season of {title} to browse available episodes.'**
  String seriesSeasonsSubtitle(Object title);

  /// Localized text for series seasons title in the series browsing UI.
  ///
  /// In en, this message translates to:
  /// **'Choose a season'**
  String get seriesSeasonsTitle;

  /// Localized text for settings about title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'About SubFlix'**
  String get settingsAboutTitle;

  /// Localized text for settings cache cleared in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared'**
  String get settingsCacheCleared;

  /// Localized text for settings clear cache in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settingsClearCache;

  /// Localized text for settings contact title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get settingsContactTitle;

  /// Localized text for settings failed title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Settings failed to load'**
  String get settingsFailedTitle;

  /// Localized text for settings help center title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get settingsHelpCenterTitle;

  /// Localized text for settings history cleared snack in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Translation history cleared for this device'**
  String get settingsHistoryClearedSnack;

  /// Localized text for settings language label in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Preferred target language'**
  String get settingsLanguageLabel;

  /// Localized text for settings maintenance subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Clear backend-owned translation jobs for this device and start with an empty history state.'**
  String get settingsMaintenanceSubtitle;

  /// Localized text for settings maintenance title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get settingsMaintenanceTitle;

  /// Localized text for settings notifications subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get settingsNotificationsSubtitle;

  /// Localized text for settings notifications title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// Localized text for settings premium subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Later we can connect subscriptions, billing, and cloud project sync here.'**
  String get settingsPremiumSubtitle;

  /// Localized text for settings premium title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Premium placeholder'**
  String get settingsPremiumTitle;

  /// Localized text for settings privacy subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Mock privacy content'**
  String get settingsPrivacySubtitle;

  /// Localized text for settings privacy title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyTitle;

  /// Localized text for settings profile name in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'SubFlix User'**
  String get settingsProfileName;

  /// Localized text for settings profile tier in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Premium member'**
  String get settingsProfileTier;

  /// Localized text for settings subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Manager your preferences'**
  String get settingsSubtitle;

  /// Localized text for settings support subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Mock help and contact page'**
  String get settingsSupportSubtitle;

  /// Localized text for settings support title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Support placeholder'**
  String get settingsSupportTitle;

  /// Localized text for settings terms subtitle in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Mock terms content'**
  String get settingsTermsSubtitle;

  /// Localized text for settings terms title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingsTermsTitle;

  /// Localized text for settings theme label in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsThemeLabel;

  /// Localized text for settings title in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Localized text for settings version in the settings UI. Uses placeholder: version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(Object version);

  /// Localized text for splash headline in the splash UI.
  ///
  /// In en, this message translates to:
  /// **'SubFlix'**
  String get splashHeadline;

  /// Localized text for splash preparing in the splash UI.
  ///
  /// In en, this message translates to:
  /// **'Preparing your subtitle studio'**
  String get splashPreparing;

  /// Localized text for splash subtitle in the splash UI.
  ///
  /// In en, this message translates to:
  /// **'AI-powered subtitle translation'**
  String get splashSubtitle;

  /// Localized text for start translation in the shared action UI.
  ///
  /// In en, this message translates to:
  /// **'Start translation'**
  String get startTranslation;

  /// Localized text for subtitle source downloads in the subtitle sources UI. Uses placeholder: downloads.
  ///
  /// In en, this message translates to:
  /// **'{downloads} downloads'**
  String subtitleSourceDownloads(Object downloads);

  /// Localized text for subtitle source format label in the subtitle sources UI. Uses placeholder: format.
  ///
  /// In en, this message translates to:
  /// **'{format} subtitle source'**
  String subtitleSourceFormatLabel(Object format);

  /// Localized text for subtitle source hi label in the subtitle sources UI.
  ///
  /// In en, this message translates to:
  /// **'HI / SDH'**
  String get subtitleSourceHiLabel;

  /// Localized text for subtitle source lines in the subtitle sources UI. Uses placeholder: lineCount.
  ///
  /// In en, this message translates to:
  /// **'{lineCount} lines'**
  String subtitleSourceLines(Object lineCount);

  /// Localized text for subtitle source rating in the subtitle sources UI. Uses placeholder: rating.
  ///
  /// In en, this message translates to:
  /// **'{rating} rating'**
  String subtitleSourceRating(Object rating);

  /// Localized text for subtitle sources banner message in the subtitle sources UI.
  ///
  /// In en, this message translates to:
  /// **'Select a subtitle source and continue into a polished translation setup tuned for subtitle timing.'**
  String get subtitleSourcesBannerMessage;

  /// Localized text for subtitle sources banner title in the subtitle sources UI.
  ///
  /// In en, this message translates to:
  /// **'AI translation available'**
  String get subtitleSourcesBannerTitle;

  /// Localized text for subtitle sources failed title in the subtitle sources UI.
  ///
  /// In en, this message translates to:
  /// **'Could not load subtitle sources'**
  String get subtitleSourcesFailedTitle;

  /// Localized text for subtitle sources subtitle in the subtitle sources UI. Uses placeholders: title, target.
  ///
  /// In en, this message translates to:
  /// **'Pick a subtitle source for {title}{target}, then choose the target language in the next step.'**
  String subtitleSourcesSubtitle(Object title, Object target);

  /// Localized text for subtitle sources title in the subtitle sources UI.
  ///
  /// In en, this message translates to:
  /// **'English subtitle sources'**
  String get subtitleSourcesTitle;

  /// Localized text for target language in the shared action UI.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get targetLanguage;

  /// Localized text for theme dark in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Localized text for theme light in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Localized text for theme system in the settings UI.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Localized text for translate setup auto detect in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect format'**
  String get translateSetupAutoDetect;

  /// Localized text for translate setup auto detect body in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Choose the right subtitle output structure automatically.'**
  String get translateSetupAutoDetectBody;

  /// Localized text for translate setup language title in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Translate to'**
  String get translateSetupLanguageTitle;

  /// Localized text for translate setup options title in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get translateSetupOptionsTitle;

  /// Localized text for translate setup preserve timing in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Preserve timing'**
  String get translateSetupPreserveTiming;

  /// Localized text for translate setup preserve timing body in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Keep original subtitle timings aligned to the source file.'**
  String get translateSetupPreserveTimingBody;

  /// Localized text for translate setup ready body in the translation setup UI. Uses placeholder: language.
  ///
  /// In en, this message translates to:
  /// **'Our translation flow will adapt this subtitle into {language} with preserved timing and clean cue structure.'**
  String translateSetupReadyBody(Object language);

  /// Localized text for translate setup ready title in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'AI translation ready'**
  String get translateSetupReadyTitle;

  /// Localized text for translate setup select language in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get translateSetupSelectLanguage;

  /// Localized text for translate setup source title in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Source subtitle'**
  String get translateSetupSourceTitle;

  /// Localized text for translate setup subtitle in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Choose the target language, review the subtitle source, and start the backend translation job.'**
  String get translateSetupSubtitle;

  /// Localized text for translate setup title in the translation setup UI.
  ///
  /// In en, this message translates to:
  /// **'Translate setup'**
  String get translateSetupTitle;

  /// Localized text for translation failed message in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get translationFailedMessage;

  /// Localized text for translation failed title in the application UI.
  ///
  /// In en, this message translates to:
  /// **'Translation could not finish'**
  String get translationFailedTitle;

  /// Localized text for translation preview header in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Review translated subtitles'**
  String get translationPreviewHeader;

  /// Localized text for translation preview search hint in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Search subtitle lines'**
  String get translationPreviewSearchHint;

  /// Localized text for translation preview subtitle in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Search inside cues, switch preview modes, then export once the translation looks right.'**
  String get translationPreviewSubtitle;

  /// Localized text for translation preview title in the translation preview UI.
  ///
  /// In en, this message translates to:
  /// **'Translation preview'**
  String get translationPreviewTitle;

  /// Localized text for translation progress headline in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'AI subtitle translation in progress'**
  String get translationProgressHeadline;

  /// Localized text for translation progress title in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Translation progress'**
  String get translationProgressTitle;

  /// Localized text for translation result complete subtitle in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Your subtitle is ready to preview or download.'**
  String get translationResultCompleteSubtitle;

  /// Localized text for translation result complete title in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Translation complete'**
  String get translationResultCompleteTitle;

  /// Localized text for translation result confidence label in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Translation confidence'**
  String get translationResultConfidenceLabel;

  /// Localized text for translation result details title in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Translation details'**
  String get translationResultDetailsTitle;

  /// Localized text for translation result download cta in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Download subtitle'**
  String get translationResultDownloadCta;

  /// Localized text for translation result home cta in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get translationResultHomeCta;

  /// Localized text for translation result media label in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Media title'**
  String get translationResultMediaLabel;

  /// Localized text for translation result method ai in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'AI translated'**
  String get translationResultMethodAi;

  /// Localized text for translation result metrics title in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Quality metrics'**
  String get translationResultMetricsTitle;

  /// Localized text for translation result preview cta in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Preview subtitle'**
  String get translationResultPreviewCta;

  /// Localized text for translation result processed in in the translation result UI. Uses placeholder: duration.
  ///
  /// In en, this message translates to:
  /// **'Processed in {duration}'**
  String translationResultProcessedIn(Object duration);

  /// Localized text for translation result source label in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get translationResultSourceLabel;

  /// Localized text for translation result target label in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get translationResultTargetLabel;

  /// Localized text for translation result timing label in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Timing accuracy'**
  String get translationResultTimingLabel;

  /// Localized text for translation result timing preserved in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Timing preserved'**
  String get translationResultTimingPreserved;

  /// Localized text for translation result warning in the translation result UI.
  ///
  /// In en, this message translates to:
  /// **'Some technical terms may still benefit from a quick human review for context.'**
  String get translationResultWarning;

  /// Localized text for translation stage aligning in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Aligning timestamps and scene context'**
  String get translationStageAligning;

  /// Localized text for translation stage generating in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Generating subtitle translation'**
  String get translationStageGenerating;

  /// Localized text for translation stage idle in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a translation request'**
  String get translationStageIdle;

  /// Localized text for translation stage preparing in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Preparing subtitle package'**
  String get translationStagePreparing;

  /// Localized text for translation stage queued in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Queued for translation'**
  String get translationStageQueued;

  /// Localized text for translation stage readability in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Applying readability pass'**
  String get translationStageReadability;

  /// Localized text for translation stage ready in the translation progress UI.
  ///
  /// In en, this message translates to:
  /// **'Translation ready'**
  String get translationStageReady;

  /// Localized text for try again in the shared action UI.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Localized text for upload choose file in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Choose subtitle file'**
  String get uploadChooseFile;

  /// Localized text for upload choose file short in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get uploadChooseFileShort;

  /// Localized text for upload continue setup in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Continue to translation setup'**
  String get uploadContinueSetup;

  /// Localized text for upload english source in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'English source'**
  String get uploadEnglishSource;

  /// Localized text for upload failed fallback in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Please try another subtitle file.'**
  String get uploadFailedFallback;

  /// Localized text for upload failed message in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'We could not read this subtitle file. Try a different file or pick a smaller export.'**
  String get uploadFailedMessage;

  /// Localized text for upload failed title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'File import failed'**
  String get uploadFailedTitle;

  /// Localized text for upload intro subtitle in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Import an English `.srt` or `.vtt` file, let the backend validate and parse it, then continue into translation setup.'**
  String get uploadIntroSubtitle;

  /// Localized text for upload intro title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Bring your own subtitle file'**
  String get uploadIntroTitle;

  /// Localized text for upload line count in the upload UI. Uses placeholder: lineCount.
  ///
  /// In en, this message translates to:
  /// **'{lineCount} lines'**
  String uploadLineCount(Object lineCount);

  /// Localized text for upload metadata title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Subtitle details'**
  String get uploadMetadataTitle;

  /// Localized text for upload opening picker in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Opening picker...'**
  String get uploadOpeningPicker;

  /// Localized text for upload pick subtitle in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Pick subtitle file'**
  String get uploadPickSubtitle;

  /// Localized text for upload picked file in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Picked subtitle file'**
  String get uploadPickedFile;

  /// Localized text for upload ready title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Ready to translate'**
  String get uploadReadyTitle;

  /// Localized text for upload subtitle title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Upload subtitle'**
  String get uploadSubtitleTitle;

  /// Localized text for upload supported formats subtitle in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'English `.srt` and `.vtt` subtitle files'**
  String get uploadSupportedFormatsSubtitle;

  /// Localized text for upload supported formats title in the upload UI.
  ///
  /// In en, this message translates to:
  /// **'Supported formats'**
  String get uploadSupportedFormatsTitle;

  /// Localized text for upload use demo file in the upload UI.
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
