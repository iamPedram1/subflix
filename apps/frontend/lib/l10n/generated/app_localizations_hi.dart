// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'Account';

  @override
  String get authAlreadySignedInTitle => 'You are already signed in';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'This device is already connected as $email.';
  }

  @override
  String get authBackToAccount => 'Back to account';

  @override
  String get authBackToSignIn => 'Back to sign in';

  @override
  String get authCheckInboxTitle => 'Check your inbox';

  @override
  String get authConfirmEmailAction => 'Confirm email';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Use the verification token sent to $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Paste the verification token from your email to finish activating this account.';

  @override
  String get authConfirmEmailSuccess => 'Email confirmed. You can sign in now.';

  @override
  String get authConfirmEmailTitle => 'Verify your email';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authContinueToReset => 'Continue to reset';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authCreateAccountAction => 'Create account';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Debug token: $token';
  }

  @override
  String get authDisplayNameLabel => 'Display name';

  @override
  String get authEmailLabel => 'Email address';

  @override
  String get authEyebrow => 'Secure workspace';

  @override
  String get authFieldRequired => 'This field is required.';

  @override
  String get authForgotPasswordAction => 'Send reset link';

  @override
  String get authForgotPasswordDebugMessage =>
      'A reset token was returned for this debug environment. You can continue directly into the reset form.';

  @override
  String get authForgotPasswordLink => 'Forgot password?';

  @override
  String get authForgotPasswordSubtitle =>
      'Enter your email and we will request a password reset from the backend for this account.';

  @override
  String get authForgotPasswordSuccess =>
      'If the account exists, a password reset message has been sent.';

  @override
  String get authForgotPasswordTitle => 'Reset your password';

  @override
  String get authGoogleHelper =>
      'Google sign-in uses Firebase OAuth and will work once this app is connected to a Firebase project.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'Already have an account? Sign in';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authNewPasswordLabel => 'New password';

  @override
  String get authNoAccountLink => 'Need an account? Create one';

  @override
  String get authOrDivider => 'or';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authPasswordTooShort => 'Use at least 8 characters.';

  @override
  String get authProfileRefreshed => 'Account details refreshed.';

  @override
  String get authRefreshProfileAction => 'Refresh profile';

  @override
  String get authRefreshProfileSubtitle =>
      'Load the latest profile data from the backend.';

  @override
  String get authResetPasswordAction => 'Save new password';

  @override
  String authResetPasswordHint(Object email) {
    return 'Reset the password for $email using the token from your email.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Enter the reset token and choose a new password for this account.';

  @override
  String get authResetPasswordSuccess =>
      'Password updated. Please sign in again.';

  @override
  String get authResetPasswordTitle => 'Choose a new password';

  @override
  String get authSignInAction => 'Sign in';

  @override
  String get authSignInSubtitle =>
      'Connect this app to your SubFlix account to sync profile data and unlock authenticated backend flows.';

  @override
  String get authSignInSuccess => 'Signed in successfully.';

  @override
  String get authSignInTitle => 'Welcome back';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Connected as $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Sign in to manage your account, use Firebase OAuth, and keep authenticated features ready for future sync.';

  @override
  String get authSignedOutCardTitle => 'Sign in to SubFlix';

  @override
  String get authSignOutAction => 'Sign out';

  @override
  String get authSignOutSubtitle =>
      'Revoke the current session for this device and clear local tokens.';

  @override
  String get authSignOutSuccess => 'Signed out on this device.';

  @override
  String get authSignUpAction => 'Create my account';

  @override
  String get authSignUpSubtitle =>
      'Create an account so this app can use the backend\'s authenticated profile and session flows.';

  @override
  String get authSignUpSuccess =>
      'Account created. Continue with email verification.';

  @override
  String get authSignUpTitle => 'Create your account';

  @override
  String get authVerificationStatusTitle => 'Email verification';

  @override
  String get authVerificationTokenLabel => 'Verification token';

  @override
  String get authVerifiedStatus => 'Verified';

  @override
  String get authUnverifiedStatus => 'Verification pending';

  @override
  String get brandSubtitleCompact => 'सबटाइटल इंटेलिजेंस';

  @override
  String get brandSubtitleFull => 'AI सबटाइटल अनुवाद स्टूडियो';

  @override
  String get comingSoonMessage => 'हम अभी यह स्क्रीन तैयार कर रहे हैं।';

  @override
  String get comingSoonTitle => 'जल्द आ रहा है';

  @override
  String exportFailedSnack(Object error) {
    return 'एक्सपोर्ट असफल रहा: $error';
  }

  @override
  String get exportSubtitleLabel => 'अनुवादित सबटाइटल एक्सपोर्ट करें';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName को $path पर एक्सपोर्ट किया गया';
  }

  @override
  String get exportingLabel => 'एक्सपोर्ट किया जा रहा है...';

  @override
  String get heroBadge => 'प्रीमियम सबटाइटल वर्कफ़्लो';

  @override
  String get heroBody =>
      'खोजने योग्य शीर्षक कैटलॉग या सीधी फ़ाइल अपलोड में से चुनें, फिर कुछ मिनटों में प्रीव्यू देखें और polished सबटाइटल एक्सपोर्ट करें।';

  @override
  String get heroHeadline =>
      'स्टूडियो-ग्रेड फ़्लो के साथ फ़िल्म और सीरीज़ सबटाइटल का अनुवाद करें।';

  @override
  String get heroSearchCta => 'फ़िल्म / सीरीज़ खोजें';

  @override
  String get heroStatLanguagesTitle => '10 भाषाएँ';

  @override
  String get heroStatLanguagesValue => 'प्रीव्यू के लिए तैयार';

  @override
  String get heroStatMockTitle => 'Mock APIs';

  @override
  String get heroStatMockValue => 'बैकएंड-रेडी लेयर';

  @override
  String get heroStatPathsTitle => '2 रास्ते';

  @override
  String get heroStatPathsValue => 'खोज या अपलोड';

  @override
  String get heroSubtitle =>
      'फ़िल्म और सीरीज़ कैटलॉग खोजें, स्रोत चुनें और कुछ ही मिनटों में polished अनुवाद एक्सपोर्ट करें।';

  @override
  String get heroTitle => 'सबटाइटल तेजी से अनुवाद करें';

  @override
  String get heroUploadCta => 'सबटाइटल अपलोड करें';

  @override
  String historyCountLabel(Object count) {
    return '$count अनुवाद';
  }

  @override
  String get historyEmptyMessage =>
      'जैसे ही आप खोज या अपलोड फ़्लो पूरा करेंगे, आपके अनुवादित सबटाइटल जॉब यहाँ दिखेंगे।';

  @override
  String get historyEmptyTitle => 'इतिहास खाली है';

  @override
  String get historyFailedItemMessage =>
      'अनुवाद असफल रहा। फिर से शुरू करने के लिए टैप करें।';

  @override
  String get historyFailedTitle => 'इतिहास लोड नहीं हो सका';

  @override
  String get historyFilterAiTranslated => 'AI से अनुवादित';

  @override
  String get historyFilterAll => 'सभी';

  @override
  String get historyFilterCompleted => 'पूर्ण';

  @override
  String get historyFilterFailed => 'असफल';

  @override
  String get historyFilterMovies => 'फ़िल्में';

  @override
  String get historyFilterReused => 'दोबारा इस्तेमाल';

  @override
  String get historyFilterSeries => 'सीरीज़';

  @override
  String get historySubtitle =>
      'पुराने सबटाइटल जॉब फिर से खोलें, प्रीव्यू दोबारा देखें या बाद में एक्सपोर्ट करें।';

  @override
  String get historyTitle => 'अनुवाद इतिहास';

  @override
  String get homeFailedRecentTitle => 'हाल के जॉब लोड नहीं हो सके';

  @override
  String get homeFutureSubtitle =>
      'बदले जा सकने वाले mock repositories UI कोड को बैकएंड बदलावों से सुरक्षित रखते हैं।';

  @override
  String get homeFutureTitle => 'भविष्य के लिए तैयार repositories';

  @override
  String get homeNoRecentMessage =>
      'किसी फ़िल्म की खोज से शुरू करें या सबटाइटल फ़ाइल अपलोड करें, आपके हाल के अनुवाद यहाँ दिखेंगे।';

  @override
  String get homeNoRecentTitle => 'अभी कोई हालिया जॉब नहीं';

  @override
  String get homePreviewSubtitle =>
      'एक्सपोर्ट से पहले परिणामों को मूल, अनुवादित या द्विभाषी रूप में देखें।';

  @override
  String get homePreviewTitle => 'प्रीव्यू-केंद्रित अनुवाद फ़्लो';

  @override
  String get homeQuickHistory => 'इतिहास';

  @override
  String get homeQuickSearch => 'खोज';

  @override
  String get homeQuickUpload => 'अपलोड';

  @override
  String get homeRecentJobsSubtitle =>
      'शुरू से शुरू किए बिना अपनी ताज़ा सबटाइटल सेशन फिर खोलें।';

  @override
  String get homeRecentJobsTitle => 'हाल के जॉब';

  @override
  String get homeSearchPlaceholder => 'फ़िल्में या सीरीज़ खोजें...';

  @override
  String get homeStatesSubtitle =>
      'लोडिंग, खाली स्थिति, retry, validation और mock offline scenarios शुरू से ही UX का हिस्सा हैं।';

  @override
  String get homeStatesTitle => 'सभी ज़रूरी states शामिल';

  @override
  String get homeTrendingNow => 'अभी ट्रेंड में';

  @override
  String get homeTrustSubtitle =>
      'आज भले मॉक हो, लेकिन इसे असली प्रोडक्ट की तरह संरचित किया गया है।';

  @override
  String get homeTrustTitle => 'टीमें इस पर भरोसा क्यों करती हैं';

  @override
  String get homeViewAll => 'सब देखें';

  @override
  String get homeWelcomeSubtitle => 'सबटाइटल खोजें और अनुवाद करें';

  @override
  String get homeWelcomeTitle => 'फिर से स्वागत है';

  @override
  String jobConfidence(Object level) {
    return 'विश्वास स्तर: $level';
  }

  @override
  String get jobOpenPreview => 'प्रीव्यू खोलें';

  @override
  String get jobReuseSubtitle => 'सबटाइटल दोबारा इस्तेमाल करें';

  @override
  String get jobReuseTranslation => 'अनुवाद दोबारा इस्तेमाल करें';

  @override
  String get legalBodyAbout =>
      'SubFlix AI सबटाइटल अनुवाद के लिए एक premium-style Flutter client है। यह build mock repositories, artificial latency और local persistence का इस्तेमाल करती है ताकि असली backend जुड़ने से पहले UI और architecture विकसित हो सकें।';

  @override
  String get legalBodyPrivacy =>
      'SubFlix फिलहाल केवल mock preferences और translation history को local persistence के जरिए डिवाइस पर रखता है। भविष्य में backend integration इसे authenticated storage, audit trails और server-managed retention policies से बदल सकती है।';

  @override
  String get legalBodySupport =>
      'अभी के लिए support केवल एक placeholder है। प्रोडक्शन रिलीज़ में यह सेक्शन ईमेल, issue reporting और premium account help से जुड़ सकता है, बिना app shell बदले।';

  @override
  String get legalBodyTerms =>
      'यह mock build प्रोडक्ट फ्लो, UI states और architecture boundaries को परखने के लिए बनाई गई है। जब बाद में production NestJS और Postgres backend जुड़ जाएगा, तब कानूनी हिस्से को वास्तविक सेवा शर्तों और data processing language के साथ बढ़ाया जा सकता है।';

  @override
  String get legalPlaceholderBody =>
      'यह पेज डेमो ऐप में एक प्लेसहोल्डर है। इसे अपने प्रोडक्शन कानूनी कंटेंट से जोड़ें।';

  @override
  String get legalTitleAbout => 'SubFlix के बारे में';

  @override
  String get legalTitlePrivacy => 'गोपनीयता नीति';

  @override
  String get legalTitleSupport => 'सपोर्ट';

  @override
  String get legalTitleTerms => 'सेवा की शर्तें';

  @override
  String get mediaTypeMovie => 'फ़िल्म';

  @override
  String get mediaTypeSeries => 'सीरीज़';

  @override
  String get metadataEstimatedDuration => 'अनुमानित अवधि';

  @override
  String get metadataFormat => 'फ़ॉर्मैट';

  @override
  String get metadataLanguages => 'भाषाएँ';

  @override
  String get metadataLines => 'पंक्तियाँ';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navHome => 'होम';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get noTitlesMatchedMessage =>
      'हमें यह शीर्षक मॉक कैटलॉग में नहीं मिला। थोड़ा व्यापक खोजें या सुझाए गए शीर्षकों में से कोई चुनें।';

  @override
  String get noTitlesMatchedTitle => 'कोई मिलान नहीं मिला';

  @override
  String get onboardingContinue => 'जारी रखें';

  @override
  String get onboardingEnterApp => 'SubFlix में प्रवेश करें';

  @override
  String get onboardingNext => 'अगला';

  @override
  String get onboardingPage1Description =>
      'कोई शीर्षक खोजें, उपलब्ध अंग्रेज़ी सबटाइटल स्रोत देखें और ऐसा अनुवाद फ़्लो शुरू करें जो तुरंत महसूस हो।';

  @override
  String get onboardingPage1Eyebrow => 'खोजें और लाएँ';

  @override
  String get onboardingPage1Highlight1 =>
      'विश्वसनीय विकास के लिए deterministic mock catalog';

  @override
  String get onboardingPage1Highlight2 =>
      'सबटाइटल स्रोत quality labels और format badges';

  @override
  String get onboardingPage1Highlight3 =>
      'बाद में असली backend से जोड़ने के लिए तैयार';

  @override
  String get onboardingPage1Title =>
      'फ़िल्में या सीरीज़ ढूँढें और अनुवाद के लिए तैयार सबटाइटल पाएँ।';

  @override
  String get onboardingPage2Description =>
      'अपनी सबटाइटल फ़ाइल इम्पोर्ट करें, फ़ॉर्मैट वैलिडेट करें और ऐप छोड़े बिना वही polished translation pipeline चलाएँ।';

  @override
  String get onboardingPage2Eyebrow => 'अपनी फ़ाइल लाएँ';

  @override
  String get onboardingPage2Highlight1 =>
      'लोकल फ़ाइल वैलिडेशन और सहज retry states';

  @override
  String get onboardingPage2Highlight2 =>
      'अपलोड और खोज के लिए एकसमान translation setup';

  @override
  String get onboardingPage2Highlight3 =>
      'एक्सपोर्ट से पहले प्रीव्यू, ताकि कुछ भी धुंधला न लगे';

  @override
  String get onboardingPage2Title =>
      'जब स्क्रिप्ट आपके पास हो, तब `.srt` या `.vtt` फ़ाइलें अपलोड करें।';

  @override
  String get onboardingPage3Description =>
      'मूल, अनुवादित और द्विभाषी दृश्य में बदलें, इतिहास फिर देखें और जब परिणाम सही लगे तब साफ़-सुथरी सबटाइटल फ़ाइलें एक्सपोर्ट करें।';

  @override
  String get onboardingPage3Eyebrow => 'अनुवाद और एक्सपोर्ट';

  @override
  String get onboardingPage3Highlight1 =>
      'मेटाडेटा और खोज के साथ तेज़ प्रीव्यू नियंत्रण';

  @override
  String get onboardingPage3Highlight2 =>
      'इतिहास पुराने जॉब को बस एक टैप दूर रखता है';

  @override
  String get onboardingPage3Highlight3 =>
      'डेमो नहीं, एक प्रीमियम मीडिया टूल जैसा डिज़ाइन';

  @override
  String get onboardingPage3Title =>
      'लक्षित भाषाएँ चुनें, सबटाइटल प्रीव्यू देखें और तुरंत एक्सपोर्ट करें।';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingStart => 'अनुवाद शुरू करें';

  @override
  String get previewFailedTitle => 'प्रीव्यू लोड नहीं हो सका';

  @override
  String get previewModeBilingual => 'द्विभाषी';

  @override
  String get previewModeOriginal => 'मूल';

  @override
  String get previewModeTranslated => 'अनुवादित';

  @override
  String get previewNoMatchesMessage =>
      'कोई दूसरा खोज शब्द आज़माएँ या पूरा अनुवाद देखने के लिए फ़िल्टर हटाएँ।';

  @override
  String get previewNoMatchesTitle => 'कोई सबटाइटल पंक्ति मेल नहीं खाई';

  @override
  String get previewNotReadyMessage =>
      'अनुवाद पूरा हो गया, लेकिन बैकएंड ने अभी तक प्रीव्यू cues नहीं भेजे। एक क्षण बाद यह स्क्रीन फिर से लोड करें।';

  @override
  String get previewNotReadyTitle => 'प्रीव्यू cues अभी उपलब्ध नहीं हैं';

  @override
  String get retry => 'फिर से प्रयास करें';

  @override
  String get retryTranslation => 'अनुवाद फिर से करें';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'हम तय नहीं कर सके कि कौन-सा सीज़न लोड करना है। खोज से फिर शुरू करें।';

  @override
  String get routeMissingSeasonEpisodesTitle => 'सीज़न एपिसोड';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'हम तय नहीं कर सके कि कौन-सी सीरीज़ लोड करनी है। खोज से फिर शुरू करें।';

  @override
  String get routeMissingSeriesSeasonsTitle => 'सीरीज़ सीज़न';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'हम तय नहीं कर सके कि किस शीर्षक के लिए सबटाइटल स्रोत लोड करने हैं। खोज से फिर शुरू करें।';

  @override
  String get routeMissingSubtitleSourcesTitle => 'सबटाइटल स्रोत';

  @override
  String get routeMissingTranslationProgressMessage =>
      'कोई अनुवाद अनुरोध नहीं दिया गया। खोज या अपलोड से नया अनुवाद शुरू करें।';

  @override
  String get routeMissingTranslationProgressTitle => 'अनुवाद प्रगति';

  @override
  String get routeMissingTranslationSetupMessage =>
      'अनुवाद सेटअप स्क्रीन खोलने से पहले एक सबटाइटल स्रोत ज़रूरी है।';

  @override
  String get routeMissingTranslationSetupTitle => 'अनुवाद सेटअप';

  @override
  String get searchFailedTitle => 'खोज असफल रही';

  @override
  String searchFoundResults(Object count, Object query) {
    return '\"$query\" के लिए $count परिणाम मिले';
  }

  @override
  String get searchHintText => 'Dune, Breaking Bad, Severance खोजें...';

  @override
  String get searchLoadingLabel => 'खोज जारी है...';

  @override
  String get searchMockMessage =>
      'सबटाइटल स्रोतों का फ़्लो देखने के लिए Inception, Dune, Breaking Bad, Severance या The Last of Us जैसे शीर्षक आज़माएँ।';

  @override
  String get searchMockTitle => 'मॉक कैटलॉग में कुछ भी खोजें';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'कोई शीर्षक ढूँढें, सबटाइटल स्रोत देखें और कुछ टैप में अनुवाद शुरू करें।';

  @override
  String get searchMovieOrSeriesTitle => 'फ़िल्म या सीरीज़ खोजें';

  @override
  String searchNoResultsFor(Object query) {
    return '\"$query\" के लिए कोई परिणाम नहीं मिला';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'लोकप्रियता $score';
  }

  @override
  String get searchTitles => 'शीर्षक खोजें';

  @override
  String get searchTrendingTitle => 'ट्रेंडिंग खोजें';

  @override
  String get searchTryDifferentKeywords => 'कुछ अलग कीवर्ड्स आज़माएँ।';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'एपिसोड $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'लगभग $runtime मिनट';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount एपिसोड$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'सीज़न $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'सीज़न $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount एपिसोड$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'उपलब्ध एपिसोड देखने के लिए $title का एक सीज़न चुनें।';
  }

  @override
  String get seriesSeasonsTitle => 'एक सीज़न चुनें';

  @override
  String get settingsAboutTitle => 'SubFlix के बारे में';

  @override
  String get settingsCacheCleared => 'कैश साफ़ हो गया';

  @override
  String get settingsClearCache => 'कैश साफ़ करें';

  @override
  String get settingsContactTitle => 'हमसे संपर्क करें';

  @override
  String get settingsFailedTitle => 'सेटिंग्स लोड नहीं हो सकीं';

  @override
  String get settingsHelpCenterTitle => 'सहायता केंद्र';

  @override
  String get settingsHistoryClearedSnack =>
      'इस डिवाइस का अनुवाद इतिहास साफ़ कर दिया गया';

  @override
  String get settingsLanguageLabel => 'पसंदीदा लक्षित भाषा';

  @override
  String get settingsMaintenanceSubtitle =>
      'इस डिवाइस के लिए बैकएंड-स्वामित्व वाले अनुवाद जॉब साफ़ करें और खाली इतिहास से शुरू करें।';

  @override
  String get settingsMaintenanceTitle => 'रखरखाव';

  @override
  String get settingsNotificationsSubtitle =>
      'सूचना प्राथमिकताएँ प्रबंधित करें';

  @override
  String get settingsNotificationsTitle => 'सूचनाएँ';

  @override
  String get settingsPremiumSubtitle =>
      'आगे चलकर हम यहाँ सब्सक्रिप्शन, बिलिंग और क्लाउड प्रोजेक्ट सिंक जोड़ सकते हैं।';

  @override
  String get settingsPremiumTitle => 'प्रीमियम प्लेसहोल्डर';

  @override
  String get settingsPrivacySubtitle => 'मॉक गोपनीयता सामग्री';

  @override
  String get settingsPrivacyTitle => 'गोपनीयता नीति';

  @override
  String get settingsProfileName => 'SubFlix उपयोगकर्ता';

  @override
  String get settingsProfileTier => 'प्रीमियम सदस्य';

  @override
  String get settingsSubtitle => 'अपनी पसंद प्रबंधित करें';

  @override
  String get settingsSupportSubtitle => 'मॉक सहायता और संपर्क पेज';

  @override
  String get settingsSupportTitle => 'सपोर्ट प्लेसहोल्डर';

  @override
  String get settingsTermsSubtitle => 'मॉक शर्तें सामग्री';

  @override
  String get settingsTermsTitle => 'सेवा की शर्तें';

  @override
  String get settingsThemeLabel => 'दिखावट';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String settingsVersion(Object version) {
    return 'संस्करण $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'आपका सबटाइटल स्टूडियो तैयार किया जा रहा है';

  @override
  String get splashSubtitle => 'AI-संचालित सबटाइटल अनुवाद';

  @override
  String get startTranslation => 'अनुवाद शुरू करें';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads डाउनलोड';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format सबटाइटल स्रोत';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount पंक्तियाँ';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'रेटिंग $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'एक सबटाइटल स्रोत चुनें और सबटाइटल टाइमिंग के लिए अनुकूलित, polished अनुवाद सेटअप पर आगे बढ़ें।';

  @override
  String get subtitleSourcesBannerTitle => 'AI अनुवाद उपलब्ध है';

  @override
  String get subtitleSourcesFailedTitle => 'सबटाइटल स्रोत लोड नहीं हो सके';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return '$title$target के लिए एक सबटाइटल स्रोत चुनें, फिर अगले चरण में लक्षित भाषा चुनें।';
  }

  @override
  String get subtitleSourcesTitle => 'अंग्रेज़ी सबटाइटल स्रोत';

  @override
  String get targetLanguage => 'लक्षित भाषा';

  @override
  String get themeDark => 'डार्क';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get translateSetupAutoDetect => 'फ़ॉर्मैट स्वतः पहचानें';

  @override
  String get translateSetupAutoDetectBody =>
      'सही सबटाइटल आउटपुट संरचना अपने आप चुनें।';

  @override
  String get translateSetupLanguageTitle => 'किस भाषा में';

  @override
  String get translateSetupOptionsTitle => 'विकल्प';

  @override
  String get translateSetupPreserveTiming => 'टाइमिंग सुरक्षित रखें';

  @override
  String get translateSetupPreserveTimingBody =>
      'मूल सबटाइटल टाइमिंग को स्रोत फ़ाइल के साथ मिलाकर रखें।';

  @override
  String translateSetupReadyBody(Object language) {
    return 'हमारा अनुवाद फ़्लो इस सबटाइटल को $language में बदलेगा, साथ ही टाइमिंग और cue संरचना को साफ़-सुथरा बनाए रखेगा।';
  }

  @override
  String get translateSetupReadyTitle => 'AI अनुवाद तैयार है';

  @override
  String get translateSetupSelectLanguage => 'भाषा चुनें';

  @override
  String get translateSetupSourceTitle => 'स्रोत सबटाइटल';

  @override
  String get translateSetupSubtitle =>
      'लक्षित भाषा चुनें, सबटाइटल स्रोत देखें और बैकएंड अनुवाद जॉब शुरू करें।';

  @override
  String get translateSetupTitle => 'अनुवाद सेटअप';

  @override
  String get translationFailedMessage => 'कुछ गड़बड़ हो गई।';

  @override
  String get translationFailedTitle => 'अनुवाद पूरा नहीं हो सका';

  @override
  String get translationPreviewHeader => 'अनुवादित सबटाइटल देखें';

  @override
  String get translationPreviewSearchHint => 'सबटाइटल पंक्तियाँ खोजें';

  @override
  String get translationPreviewSubtitle =>
      'cues के अंदर खोजें, प्रीव्यू मोड बदलें और जब परिणाम सही लगे तब एक्सपोर्ट करें।';

  @override
  String get translationPreviewTitle => 'अनुवाद प्रीव्यू';

  @override
  String get translationProgressHeadline => 'AI सबटाइटल अनुवाद जारी है';

  @override
  String get translationProgressTitle => 'अनुवाद प्रगति';

  @override
  String get translationResultCompleteSubtitle =>
      'आपका सबटाइटल अब प्रीव्यू या डाउनलोड के लिए तैयार है।';

  @override
  String get translationResultCompleteTitle => 'अनुवाद पूरा हुआ';

  @override
  String get translationResultConfidenceLabel => 'अनुवाद विश्वसनीयता';

  @override
  String get translationResultDetailsTitle => 'अनुवाद विवरण';

  @override
  String get translationResultDownloadCta => 'सबटाइटल डाउनलोड करें';

  @override
  String get translationResultHomeCta => 'होम पर वापस जाएँ';

  @override
  String get translationResultMediaLabel => 'मीडिया शीर्षक';

  @override
  String get translationResultMethodAi => 'AI से अनुवादित';

  @override
  String get translationResultMetricsTitle => 'गुणवत्ता मेट्रिक्स';

  @override
  String get translationResultPreviewCta => 'सबटाइटल प्रीव्यू';

  @override
  String translationResultProcessedIn(Object duration) {
    return '$duration में प्रोसेस हुआ';
  }

  @override
  String get translationResultSourceLabel => 'स्रोत भाषा';

  @override
  String get translationResultTargetLabel => 'लक्षित भाषा';

  @override
  String get translationResultTimingLabel => 'टाइमिंग सटीकता';

  @override
  String get translationResultTimingPreserved => 'टाइमिंग सुरक्षित रखी गई';

  @override
  String get translationResultWarning =>
      'कुछ तकनीकी शब्दों के लिए संदर्भ के हिसाब से तेज़ मानवीय समीक्षा अभी भी काम आ सकती है।';

  @override
  String get translationStageAligning =>
      'टाइमस्टैम्प और सीन संदर्भ मिलाए जा रहे हैं';

  @override
  String get translationStageGenerating => 'सबटाइटल अनुवाद बनाया जा रहा है';

  @override
  String get translationStageIdle => 'अनुवाद अनुरोध की प्रतीक्षा में';

  @override
  String get translationStagePreparing => 'सबटाइटल पैकेज तैयार किया जा रहा है';

  @override
  String get translationStageQueued => 'अनुवाद कतार में है';

  @override
  String get translationStageReadability =>
      'पढ़ने-लायक बनाने की जाँच लागू की जा रही है';

  @override
  String get translationStageReady => 'अनुवाद तैयार है';

  @override
  String get tryAgain => 'फिर से कोशिश करें';

  @override
  String get uploadChooseFile => 'सबटाइटल फ़ाइल चुनें';

  @override
  String get uploadChooseFileShort => 'फ़ाइल चुनें';

  @override
  String get uploadContinueSetup => 'अनुवाद सेटअप पर आगे बढ़ें';

  @override
  String get uploadEnglishSource => 'अंग्रेज़ी स्रोत';

  @override
  String get uploadFailedFallback => 'कृपया कोई दूसरी सबटाइटल फ़ाइल आज़माएँ।';

  @override
  String get uploadFailedMessage =>
      'हम इस सबटाइटल फ़ाइल को पढ़ नहीं सके। कोई दूसरी फ़ाइल या छोटा एक्सपोर्ट आज़माएँ।';

  @override
  String get uploadFailedTitle => 'फ़ाइल इम्पोर्ट असफल रहा';

  @override
  String get uploadIntroSubtitle =>
      'एक अंग्रेज़ी `.srt` या `.vtt` फ़ाइल इम्पोर्ट करें, बैकएंड से उसे वैलिडेट और पार्स करवाएँ, फिर अनुवाद सेटअप पर आगे बढ़ें।';

  @override
  String get uploadIntroTitle => 'अपनी सबटाइटल फ़ाइल इस्तेमाल करें';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount पंक्तियाँ';
  }

  @override
  String get uploadMetadataTitle => 'सबटाइटल विवरण';

  @override
  String get uploadOpeningPicker => 'फ़ाइल पिकर खुल रहा है...';

  @override
  String get uploadPickSubtitle => 'सबटाइटल फ़ाइल चुनें';

  @override
  String get uploadPickedFile => 'सबटाइटल फ़ाइल चुनी गई';

  @override
  String get uploadReadyTitle => 'अनुवाद के लिए तैयार';

  @override
  String get uploadSubtitleTitle => 'सबटाइटल अपलोड करें';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'अंग्रेज़ी `.srt` और `.vtt` सबटाइटल फ़ाइलें';

  @override
  String get uploadSupportedFormatsTitle => 'समर्थित फ़ॉर्मैट';

  @override
  String get uploadUseDemoFile => 'डेमो फ़ाइल इस्तेमाल करें';
}
