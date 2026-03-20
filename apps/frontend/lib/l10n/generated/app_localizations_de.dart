// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
  String get brandSubtitleCompact => 'Untertitel-Intelligenz';

  @override
  String get brandSubtitleFull => 'KI-Untertitelübersetzungsstudio';

  @override
  String get comingSoonMessage => 'Dieser Bildschirm wird noch vorbereitet.';

  @override
  String get comingSoonTitle => 'Demnächst';

  @override
  String exportFailedSnack(Object error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String get exportSubtitleLabel => 'Übersetzten Untertitel exportieren';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName nach $path exportiert';
  }

  @override
  String get exportingLabel => 'Exportiere...';

  @override
  String get heroBadge => 'Premium-Untertitel-Workflow';

  @override
  String get heroBody =>
      'Wähle zwischen einem durchsuchbaren Titelkatalog oder direktem Dateiupload und sieh dir ausgearbeitete Untertitel in wenigen Minuten an oder exportiere sie.';

  @override
  String get heroHeadline =>
      'Übersetze Film- und Serienuntertitel mit einem Workflow auf Studio-Niveau.';

  @override
  String get heroSearchCta => 'Film / Serie suchen';

  @override
  String get heroStatLanguagesTitle => '10 Sprachen';

  @override
  String get heroStatLanguagesValue => 'Bereit zur Vorschau';

  @override
  String get heroStatMockTitle => 'Mock-APIs';

  @override
  String get heroStatMockValue => 'Backend-fähige Schnittstelle';

  @override
  String get heroStatPathsTitle => '2 Wege';

  @override
  String get heroStatPathsValue => 'Suchen oder hochladen';

  @override
  String get heroSubtitle =>
      'Durchsuche Film- und Serienkataloge, wähle Quellen und exportiere in Minuten sauber ausgearbeitete Übersetzungen.';

  @override
  String get heroTitle => 'Untertitel schneller übersetzen';

  @override
  String get heroUploadCta => 'Untertitel hochladen';

  @override
  String historyCountLabel(Object count) {
    return '$count Übersetzungen';
  }

  @override
  String get historyEmptyMessage =>
      'Deine übersetzten Untertitelaufträge erscheinen hier, sobald du einen Such- oder Upload-Ablauf abgeschlossen hast.';

  @override
  String get historyEmptyTitle => 'Der Verlauf ist leer';

  @override
  String get historyFailedItemMessage =>
      'Übersetzung fehlgeschlagen. Tippe, um neu zu starten.';

  @override
  String get historyFailedTitle => 'Verlauf konnte nicht geladen werden';

  @override
  String get historyFilterAiTranslated => 'Mit KI übersetzt';

  @override
  String get historyFilterAll => 'Alle';

  @override
  String get historyFilterCompleted => 'Abgeschlossen';

  @override
  String get historyFilterFailed => 'Fehlgeschlagen';

  @override
  String get historyFilterMovies => 'Filme';

  @override
  String get historyFilterReused => 'Wiederverwendet';

  @override
  String get historyFilterSeries => 'Serien';

  @override
  String get historySubtitle =>
      'Öffne frühere Untertitelaufträge erneut, prüfe die Vorschau noch einmal oder exportiere sie später.';

  @override
  String get historyTitle => 'Übersetzungsverlauf';

  @override
  String get homeFailedRecentTitle =>
      'Letzte Aufträge konnten nicht geladen werden';

  @override
  String get homeFutureSubtitle =>
      'Austauschbare Mock-Repositories schützen den UI-Code vor Änderungen im Backend.';

  @override
  String get homeFutureTitle => 'Zukunftssichere Repositories';

  @override
  String get homeNoRecentMessage =>
      'Starte mit einer Filmsuche oder lade eine Untertiteldatei hoch, dann erscheinen deine letzten Übersetzungen hier.';

  @override
  String get homeNoRecentTitle => 'Noch keine letzten Aufträge';

  @override
  String get homePreviewSubtitle =>
      'Prüfe Ergebnisse vor dem Export in der Original-, übersetzten oder zweisprachigen Ansicht.';

  @override
  String get homePreviewTitle => 'Vorschau-orientierter Übersetzungsablauf';

  @override
  String get homeQuickHistory => 'Verlauf';

  @override
  String get homeQuickSearch => 'Suchen';

  @override
  String get homeQuickUpload => 'Hochladen';

  @override
  String get homeRecentJobsSubtitle =>
      'Öffne deine neuesten Untertitel-Sitzungen erneut, ohne von vorn zu beginnen.';

  @override
  String get homeRecentJobsTitle => 'Letzte Aufträge';

  @override
  String get homeSearchPlaceholder => 'Filme oder Serien suchen...';

  @override
  String get homeStatesSubtitle =>
      'Lade-, Leer-, Retry-, Validierungs- und Mock-Offline-Szenarien gehören von Anfang an zur UX.';

  @override
  String get homeStatesTitle => 'Saubere Zustände inklusive';

  @override
  String get homeTrendingNow => 'Gerade im Trend';

  @override
  String get homeTrustSubtitle =>
      'Heute noch simuliert, aber schon wie ein echtes Produkt strukturiert.';

  @override
  String get homeTrustTitle => 'Warum Teams darauf vertrauen';

  @override
  String get homeViewAll => 'Alle anzeigen';

  @override
  String get homeWelcomeSubtitle => 'Untertitel finden und übersetzen';

  @override
  String get homeWelcomeTitle => 'Willkommen zurück';

  @override
  String jobConfidence(Object level) {
    return 'Sicherheit: $level';
  }

  @override
  String get jobOpenPreview => 'Vorschau öffnen';

  @override
  String get jobReuseSubtitle => 'Untertitel wiederverwenden';

  @override
  String get jobReuseTranslation => 'Übersetzung wiederverwenden';

  @override
  String get legalBodyAbout =>
      'SubFlix ist ein Flutter-Client im Premium-Stil für KI-Untertitelübersetzung. Dieser Build verwendet Mock-Repositories, künstliche Latenz und lokale Speicherung, damit UI und Architektur reifen können, bevor ein echtes Backend angeschlossen wird.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix speichert derzeit nur Demo-Einstellungen und Übersetzungsverlauf lokal auf dem Gerät. Eine spätere Backend-Integration kann das durch authentifizierten Speicher, Audit-Trails und serverseitig verwaltete Aufbewahrungsrichtlinien ersetzen.';

  @override
  String get legalBodySupport =>
      'Der Support ist derzeit nur ein Platzhalter. In einer Produktionsversion kann dieser Bereich E-Mail, Problemberichte und Hilfe für Premium-Konten anbinden, ohne die App-Struktur zu verändern.';

  @override
  String get legalBodyTerms =>
      'Dieser Demo-Build dient dazu, Produktabläufe, UI-Zustände und Architekturgrenzen zu erproben. Wenn später ein produktives NestJS- und Postgres-Backend angebunden wird, kann die rechtliche Basis um echte Nutzungsbedingungen und Formulierungen zur Datenverarbeitung erweitert werden.';

  @override
  String get legalPlaceholderBody =>
      'Diese Seite ist in der Demo-App nur ein Platzhalter. Verbinde sie mit deinen rechtlichen Inhalten für die Produktion.';

  @override
  String get legalTitleAbout => 'Über SubFlix';

  @override
  String get legalTitlePrivacy => 'Datenschutzrichtlinie';

  @override
  String get legalTitleSupport => 'Support';

  @override
  String get legalTitleTerms => 'Nutzungsbedingungen';

  @override
  String get mediaTypeMovie => 'Film';

  @override
  String get mediaTypeSeries => 'Serie';

  @override
  String get metadataEstimatedDuration => 'Geschätzte Dauer';

  @override
  String get metadataFormat => 'Format';

  @override
  String get metadataLanguages => 'Sprachen';

  @override
  String get metadataLines => 'Zeilen';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navHome => 'Start';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get noTitlesMatchedMessage =>
      'Wir konnten diesen Titel im Demo-Katalog nicht finden. Versuche eine allgemeinere Suche oder einen der vorgeschlagenen Titel.';

  @override
  String get noTitlesMatchedTitle => 'Keine Treffer';

  @override
  String get onboardingContinue => 'Fortfahren';

  @override
  String get onboardingEnterApp => 'SubFlix öffnen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingPage1Description =>
      'Suche einen Titel, prüfe die verfügbaren englischen Untertitelquellen und starte einen Übersetzungsablauf, der sich sofort anfühlt.';

  @override
  String get onboardingPage1Eyebrow => 'Suchen und laden';

  @override
  String get onboardingPage1Highlight1 =>
      'Deterministischer Demo-Katalog für verlässliche Entwicklung';

  @override
  String get onboardingPage1Highlight2 =>
      'Qualitätslabels und Format-Badges für Untertitelquellen';

  @override
  String get onboardingPage1Highlight3 =>
      'So gebaut, dass später ein echtes Backend angeschlossen werden kann';

  @override
  String get onboardingPage1Title =>
      'Finde Filme oder Serien und hole sofort übersetzbare Untertitel.';

  @override
  String get onboardingPage2Description =>
      'Importiere deine Untertiteldatei, prüfe das Format und nutze dieselbe ausgereifte Übersetzungspipeline, ohne die App zu verlassen.';

  @override
  String get onboardingPage2Eyebrow => 'Eigene Datei verwenden';

  @override
  String get onboardingPage2Highlight1 =>
      'Lokale Dateiprüfung und saubere Retry-Zustände';

  @override
  String get onboardingPage2Highlight2 =>
      'Konsistente Übersetzungseinrichtung für Upload und Suche';

  @override
  String get onboardingPage2Highlight3 =>
      'Vor dem Export ansehen, damit nichts undurchsichtig wirkt';

  @override
  String get onboardingPage2Title =>
      'Lade `.srt`- oder `.vtt`-Dateien hoch, wenn du das Skript schon hast.';

  @override
  String get onboardingPage3Description =>
      'Wechsle zwischen Original-, Übersetzungs- und zweisprachiger Ansicht, gehe in den Verlauf zurück und exportiere saubere Untertiteldateien, sobald das Ergebnis passt.';

  @override
  String get onboardingPage3Eyebrow => 'Übersetzen und exportieren';

  @override
  String get onboardingPage3Highlight1 =>
      'Schnelle Vorschau-Steuerung mit Metadaten und Suche';

  @override
  String get onboardingPage3Highlight2 =>
      'Der Verlauf hält frühere Aufträge nur einen Tipp entfernt';

  @override
  String get onboardingPage3Highlight3 =>
      'Gestaltet wie ein Premium-Medienwerkzeug, nicht wie eine Demo';

  @override
  String get onboardingPage3Title =>
      'Wähle Zielsprachen, prüfe Untertitel und exportiere sofort.';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingStart => 'Übersetzung starten';

  @override
  String get previewFailedTitle => 'Vorschau konnte nicht geladen werden';

  @override
  String get previewModeBilingual => 'Zweisprachig';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Übersetzt';

  @override
  String get previewNoMatchesMessage =>
      'Versuche einen anderen Suchbegriff oder entferne den Filter, um die komplette Übersetzung zu prüfen.';

  @override
  String get previewNoMatchesTitle => 'Keine Untertitelzeilen gefunden';

  @override
  String get previewNotReadyMessage =>
      'Die Übersetzung ist fertig, aber das Backend hat noch keine Vorschau-Cues zurückgegeben. Lade diesen Bildschirm in einem Moment erneut.';

  @override
  String get previewNotReadyTitle => 'Vorschau-Cues sind noch nicht verfügbar';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get retryTranslation => 'Übersetzung erneut starten';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Es konnte nicht bestimmt werden, welche Staffel geladen werden soll. Starte die Suche erneut.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Staffelfolgen';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Es konnte nicht bestimmt werden, welche Serie geladen werden soll. Starte die Suche erneut.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Serienstaffeln';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Es konnte nicht bestimmt werden, für welchen Titel Untertitelquellen geladen werden sollen. Starte die Suche erneut.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Untertitelquellen';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Es wurde keine Übersetzungsanfrage übergeben. Starte eine neue Übersetzung aus Suche oder Upload.';

  @override
  String get routeMissingTranslationProgressTitle => 'Übersetzungsfortschritt';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Bevor der Bildschirm für die Übersetzungseinrichtung geöffnet werden kann, ist eine Untertitelquelle erforderlich.';

  @override
  String get routeMissingTranslationSetupTitle => 'Übersetzungseinrichtung';

  @override
  String get searchFailedTitle => 'Suche fehlgeschlagen';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count Ergebnisse für \'\'$query\'\' gefunden';
  }

  @override
  String get searchHintText => 'Suche nach Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Suche läuft...';

  @override
  String get searchMockMessage =>
      'Probiere Titel wie Inception, Dune, Breaking Bad, Severance oder The Last of Us aus, um den Ablauf der Untertitelquellen zu erkunden.';

  @override
  String get searchMockTitle => 'Suche im Demo-Katalog nach beliebigen Titeln';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Finde einen Titel, prüfe Untertitelquellen und starte mit wenigen Tippvorgängen einen Übersetzungsauftrag.';

  @override
  String get searchMovieOrSeriesTitle => 'Film oder Serie suchen';

  @override
  String searchNoResultsFor(Object query) {
    return 'Keine Ergebnisse für \'\'$query\'\' gefunden';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Beliebtheit $score';
  }

  @override
  String get searchTitles => 'Titel suchen';

  @override
  String get searchTrendingTitle => 'Beliebte Suchen';

  @override
  String get searchTryDifferentKeywords =>
      'Versuche es mit anderen Suchbegriffen.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Folge $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Ca. $runtime Min.';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount Folgen$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Staffel $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Staffel $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount Folgen$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Wähle eine Staffel von $title, um verfügbare Folgen zu sehen.';
  }

  @override
  String get seriesSeasonsTitle => 'Staffel auswählen';

  @override
  String get settingsAboutTitle => 'Über SubFlix';

  @override
  String get settingsCacheCleared => 'Cache geleert';

  @override
  String get settingsClearCache => 'Cache leeren';

  @override
  String get settingsContactTitle => 'Kontakt';

  @override
  String get settingsFailedTitle =>
      'Einstellungen konnten nicht geladen werden';

  @override
  String get settingsHelpCenterTitle => 'Hilfecenter';

  @override
  String get settingsHistoryClearedSnack =>
      'Übersetzungsverlauf für dieses Gerät gelöscht';

  @override
  String get settingsLanguageLabel => 'Bevorzugte Zielsprache';

  @override
  String get settingsMaintenanceSubtitle =>
      'Lösche backendverwaltete Übersetzungsaufträge für dieses Gerät und starte mit leerem Verlauf.';

  @override
  String get settingsMaintenanceTitle => 'Wartung';

  @override
  String get settingsNotificationsSubtitle =>
      'Benachrichtigungseinstellungen verwalten';

  @override
  String get settingsNotificationsTitle => 'Benachrichtigungen';

  @override
  String get settingsPremiumSubtitle =>
      'Später können wir hier Abos, Abrechnung und Cloud-Projektsynchronisierung anbinden.';

  @override
  String get settingsPremiumTitle => 'Premium-Platzhalter';

  @override
  String get settingsPrivacySubtitle => 'Demo-Inhalt zum Datenschutz';

  @override
  String get settingsPrivacyTitle => 'Datenschutzrichtlinie';

  @override
  String get settingsProfileName => 'SubFlix-Nutzer';

  @override
  String get settingsProfileTier => 'Premium-Mitglied';

  @override
  String get settingsSubtitle => 'Verwalte deine Einstellungen';

  @override
  String get settingsSupportSubtitle => 'Demo-Seite für Hilfe und Kontakt';

  @override
  String get settingsSupportTitle => 'Support-Platzhalter';

  @override
  String get settingsTermsSubtitle => 'Demo-Inhalt zu den Bedingungen';

  @override
  String get settingsTermsTitle => 'Nutzungsbedingungen';

  @override
  String get settingsThemeLabel => 'Darstellung';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Dein Untertitelstudio wird vorbereitet';

  @override
  String get splashSubtitle => 'KI-gestützte Untertitelübersetzung';

  @override
  String get startTranslation => 'Übersetzung starten';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads Downloads';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format-Untertitelquelle';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount Zeilen';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'Bewertung $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Wähle eine Untertitelquelle und fahre mit einer ausgereiften Übersetzungseinrichtung fort, die auf Untertitel-Timing abgestimmt ist.';

  @override
  String get subtitleSourcesBannerTitle => 'KI-Übersetzung verfügbar';

  @override
  String get subtitleSourcesFailedTitle =>
      'Untertitelquellen konnten nicht geladen werden';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Wähle eine Untertitelquelle für $title$target und danach im nächsten Schritt die Zielsprache.';
  }

  @override
  String get subtitleSourcesTitle => 'Englische Untertitelquellen';

  @override
  String get targetLanguage => 'Zielsprache';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get translateSetupAutoDetect => 'Format automatisch erkennen';

  @override
  String get translateSetupAutoDetectBody =>
      'Wählt automatisch die passende Ausgabestruktur für Untertitel.';

  @override
  String get translateSetupLanguageTitle => 'Übersetzen nach';

  @override
  String get translateSetupOptionsTitle => 'Optionen';

  @override
  String get translateSetupPreserveTiming => 'Timing beibehalten';

  @override
  String get translateSetupPreserveTimingBody =>
      'Behält die ursprünglichen Untertitelzeiten in Übereinstimmung mit der Quelldatei bei.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Unser Übersetzungsablauf überträgt diesen Untertitel in $language, mit erhaltenem Timing und sauberer Cue-Struktur.';
  }

  @override
  String get translateSetupReadyTitle => 'KI-Übersetzung bereit';

  @override
  String get translateSetupSelectLanguage => 'Sprache auswählen';

  @override
  String get translateSetupSourceTitle => 'Quelluntertitel';

  @override
  String get translateSetupSubtitle =>
      'Wähle die Zielsprache, prüfe die Untertitelquelle und starte dann den Übersetzungsauftrag im Backend.';

  @override
  String get translateSetupTitle => 'Übersetzung einrichten';

  @override
  String get translationFailedMessage => 'Etwas ist schiefgelaufen.';

  @override
  String get translationFailedTitle =>
      'Übersetzung konnte nicht abgeschlossen werden';

  @override
  String get translationPreviewHeader => 'Übersetzte Untertitel prüfen';

  @override
  String get translationPreviewSearchHint => 'Untertitelzeilen durchsuchen';

  @override
  String get translationPreviewSubtitle =>
      'Suche innerhalb der Cues, wechsle den Vorschaumodus und exportiere erst, wenn die Übersetzung stimmt.';

  @override
  String get translationPreviewTitle => 'Übersetzungsvorschau';

  @override
  String get translationProgressHeadline => 'KI-Untertitelübersetzung läuft';

  @override
  String get translationProgressTitle => 'Übersetzungsfortschritt';

  @override
  String get translationResultCompleteSubtitle =>
      'Dein Untertitel ist zur Vorschau oder zum Download bereit.';

  @override
  String get translationResultCompleteTitle => 'Übersetzung abgeschlossen';

  @override
  String get translationResultConfidenceLabel => 'Übersetzungssicherheit';

  @override
  String get translationResultDetailsTitle => 'Übersetzungsdetails';

  @override
  String get translationResultDownloadCta => 'Untertitel herunterladen';

  @override
  String get translationResultHomeCta => 'Zurück zur Startseite';

  @override
  String get translationResultMediaLabel => 'Medientitel';

  @override
  String get translationResultMethodAi => 'Mit KI übersetzt';

  @override
  String get translationResultMetricsTitle => 'Qualitätsmetriken';

  @override
  String get translationResultPreviewCta => 'Untertitel ansehen';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Verarbeitet in $duration';
  }

  @override
  String get translationResultSourceLabel => 'Ausgangssprache';

  @override
  String get translationResultTargetLabel => 'Zielsprache';

  @override
  String get translationResultTimingLabel => 'Timing-Genauigkeit';

  @override
  String get translationResultTimingPreserved => 'Timing beibehalten';

  @override
  String get translationResultWarning =>
      'Einige Fachbegriffe profitieren womöglich noch von einer kurzen menschlichen Kontextprüfung.';

  @override
  String get translationStageAligning =>
      'Zeitstempel und Szenenkontext werden abgeglichen';

  @override
  String get translationStageGenerating =>
      'Untertitelübersetzung wird erstellt';

  @override
  String get translationStageIdle => 'Warten auf eine Übersetzungsanfrage';

  @override
  String get translationStagePreparing => 'Untertitelpaket wird vorbereitet';

  @override
  String get translationStageQueued => 'Zur Übersetzung eingereiht';

  @override
  String get translationStageReadability =>
      'Lesbarkeitsprüfung wird angewendet';

  @override
  String get translationStageReady => 'Übersetzung bereit';

  @override
  String get tryAgain => 'Noch einmal versuchen';

  @override
  String get uploadChooseFile => 'Untertiteldatei auswählen';

  @override
  String get uploadChooseFileShort => 'Datei wählen';

  @override
  String get uploadContinueSetup => 'Weiter zur Übersetzungseinrichtung';

  @override
  String get uploadEnglishSource => 'Englische Quelle';

  @override
  String get uploadFailedFallback =>
      'Bitte versuche eine andere Untertiteldatei.';

  @override
  String get uploadFailedMessage =>
      'Diese Untertiteldatei konnte nicht gelesen werden. Versuche eine andere Datei oder einen kleineren Export.';

  @override
  String get uploadFailedTitle => 'Dateiimport fehlgeschlagen';

  @override
  String get uploadIntroSubtitle =>
      'Importiere eine englische `.srt`- oder `.vtt`-Datei, lasse sie vom Backend prüfen und parsen und fahre dann mit der Übersetzungseinrichtung fort.';

  @override
  String get uploadIntroTitle => 'Eigene Untertiteldatei verwenden';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount Zeilen';
  }

  @override
  String get uploadMetadataTitle => 'Untertiteldetails';

  @override
  String get uploadOpeningPicker => 'Dateiauswahl wird geöffnet...';

  @override
  String get uploadPickSubtitle => 'Untertiteldatei wählen';

  @override
  String get uploadPickedFile => 'Untertiteldatei ausgewählt';

  @override
  String get uploadReadyTitle => 'Bereit zur Übersetzung';

  @override
  String get uploadSubtitleTitle => 'Untertitel hochladen';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Englische Untertiteldateien im Format `.srt` und `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Unterstützte Formate';

  @override
  String get uploadUseDemoFile => 'Demo-Datei verwenden';
}
