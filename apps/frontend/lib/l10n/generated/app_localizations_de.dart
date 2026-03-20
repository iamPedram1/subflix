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
  String get authAccountSectionTitle => 'Konto';

  @override
  String get authAlreadySignedInTitle => 'Du bist bereits angemeldet';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'Dieses Gerät ist bereits als $email verbunden.';
  }

  @override
  String get authBackToAccount => 'Zurück zum Konto';

  @override
  String get authBackToSignIn => 'Zurück zur Anmeldung';

  @override
  String get authCheckInboxTitle => 'Posteingang prüfen';

  @override
  String get authConfirmEmailAction => 'E-Mail bestätigen';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Verwende den Bestätigungscode, der an $email gesendet wurde.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Füge den Bestätigungscode aus deiner E-Mail ein, um dieses Konto vollständig zu aktivieren.';

  @override
  String get authConfirmEmailSuccess =>
      'E-Mail bestätigt. Du kannst dich jetzt anmelden.';

  @override
  String get authConfirmEmailTitle => 'Bestätige deine E-Mail';

  @override
  String get authConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get authContinueToReset => 'Zum Zurücksetzen fortfahren';

  @override
  String get authContinueWithGoogle => 'Mit Google fortfahren';

  @override
  String get authCreateAccountAction => 'Konto erstellen';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Debug-Token: $token';
  }

  @override
  String get authDisplayNameLabel => 'Anzeigename';

  @override
  String get authEmailLabel => 'E-Mail-Adresse';

  @override
  String get authEyebrow => 'Sicherer Bereich';

  @override
  String get authFieldRequired => 'Dieses Feld ist erforderlich.';

  @override
  String get authForgotPasswordAction => 'Link zum Zurücksetzen senden';

  @override
  String get authForgotPasswordDebugMessage =>
      'Für diese Debug-Umgebung wurde ein Zurücksetzungs-Token zurückgegeben. Du kannst direkt zum Formular zum Zurücksetzen gehen.';

  @override
  String get authForgotPasswordLink => 'Passwort vergessen?';

  @override
  String get authForgotPasswordSubtitle =>
      'Gib deine E-Mail-Adresse ein und wir fordern für dieses Konto ein Passwort-Reset beim Backend an.';

  @override
  String get authForgotPasswordSuccess =>
      'Falls das Konto existiert, wurde eine Nachricht zum Zurücksetzen des Passworts gesendet.';

  @override
  String get authForgotPasswordTitle => 'Passwort zurücksetzen';

  @override
  String get authGoogleHelper =>
      'Die Google-Anmeldung verwendet Firebase OAuth und funktioniert, sobald diese App mit einem Firebase-Projekt verbunden ist.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'Du hast bereits ein Konto? Anmelden';

  @override
  String get authInvalidEmail => 'Gib eine gültige E-Mail-Adresse ein.';

  @override
  String get authNewPasswordLabel => 'Neues Passwort';

  @override
  String get authNoAccountLink => 'Du brauchst ein Konto? Erstelle eins';

  @override
  String get authOrDivider => 'oder';

  @override
  String get authPasswordLabel => 'Passwort';

  @override
  String get authPasswordMismatch => 'Die Passwörter stimmen nicht überein.';

  @override
  String get authPasswordTooShort => 'Verwende mindestens 8 Zeichen.';

  @override
  String get authProfileRefreshed => 'Kontodaten aktualisiert.';

  @override
  String get authRefreshProfileAction => 'Profil aktualisieren';

  @override
  String get authRefreshProfileSubtitle =>
      'Die neuesten Profildaten aus dem Backend laden.';

  @override
  String get authResetPasswordAction => 'Neues Passwort speichern';

  @override
  String authResetPasswordHint(Object email) {
    return 'Setze das Passwort für $email mit dem Code aus deiner E-Mail zurück.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Gib den Zurücksetzungs-Code ein und wähle ein neues Passwort für dieses Konto.';

  @override
  String get authResetPasswordSuccess =>
      'Passwort aktualisiert. Bitte melde dich erneut an.';

  @override
  String get authResetPasswordTitle => 'Wähle ein neues Passwort';

  @override
  String get authSignInAction => 'Anmelden';

  @override
  String get authSignInSubtitle =>
      'Verbinde diese App mit deinem SubFlix-Konto, um Profildaten zu synchronisieren und authentifizierte Backend-Abläufe freizuschalten.';

  @override
  String get authSignInSuccess => 'Erfolgreich angemeldet.';

  @override
  String get authSignInTitle => 'Willkommen zurück';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Verbunden als $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Melde dich an, um dein Konto zu verwalten, Firebase OAuth zu nutzen und authentifizierte Funktionen für spätere Synchronisierung vorzubereiten.';

  @override
  String get authSignedOutCardTitle => 'Bei SubFlix anmelden';

  @override
  String get authSignOutAction => 'Abmelden';

  @override
  String get authSignOutSubtitle =>
      'Die aktuelle Sitzung auf diesem Gerät widerrufen und lokale Tokens löschen.';

  @override
  String get authSignOutSuccess => 'Auf diesem Gerät abgemeldet.';

  @override
  String get authSignUpAction => 'Mein Konto erstellen';

  @override
  String get authSignUpSubtitle =>
      'Erstelle ein Konto, damit diese App das authentifizierte Profil und die Sitzungsabläufe des Backends nutzen kann.';

  @override
  String get authSignUpSuccess =>
      'Konto erstellt. Fahre mit der E-Mail-Bestätigung fort.';

  @override
  String get authSignUpTitle => 'Erstelle dein Konto';

  @override
  String get authVerificationStatusTitle => 'E-Mail-Bestätigung';

  @override
  String get authVerificationTokenLabel => 'Bestätigungscode';

  @override
  String get authVerifiedStatus => 'Bestätigt';

  @override
  String get authUnverifiedStatus => 'Bestätigung ausstehend';

  @override
  String get brandSubtitleCompact => 'Untertitel-Intelligenz';

  @override
  String get brandSubtitleFull => 'KI-UntertitelР“Сbersetzungsstudio';

  @override
  String get comingSoonMessage => 'Dieser Bildschirm wird noch vorbereitet.';

  @override
  String get comingSoonTitle => 'DemnР“В¤chst';

  @override
  String exportFailedSnack(Object error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String get exportSubtitleLabel => 'Р“Сљbersetzten Untertitel exportieren';

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
      'WР“В¤hle zwischen einem durchsuchbaren Titelkatalog oder direktem Dateiupload und sieh dir ausgearbeitete Untertitel in wenigen Minuten an oder exportiere sie.';

  @override
  String get heroHeadline =>
      'Р“Сљbersetze Film- und Serienuntertitel mit einem Workflow auf Studio-Niveau.';

  @override
  String get heroSearchCta => 'Film / Serie suchen';

  @override
  String get heroStatLanguagesTitle => '10 Sprachen';

  @override
  String get heroStatLanguagesValue => 'Bereit zur Vorschau';

  @override
  String get heroStatMockTitle => 'Mock-APIs';

  @override
  String get heroStatMockValue => 'Backend-fР“В¤hige Schnittstelle';

  @override
  String get heroStatPathsTitle => '2 Wege';

  @override
  String get heroStatPathsValue => 'Suchen oder hochladen';

  @override
  String get heroSubtitle =>
      'Durchsuche Film- und Serienkataloge, wР“В¤hle Quellen und exportiere in Minuten sauber ausgearbeitete Р“Сљbersetzungen.';

  @override
  String get heroTitle => 'Untertitel schneller Р“Сbersetzen';

  @override
  String get heroUploadCta => 'Untertitel hochladen';

  @override
  String historyCountLabel(Object count) {
    return '$count Р“Сљbersetzungen';
  }

  @override
  String get historyEmptyMessage =>
      'Deine Р“Сbersetzten UntertitelauftrР“В¤ge erscheinen hier, sobald du einen Such- oder Upload-Ablauf abgeschlossen hast.';

  @override
  String get historyEmptyTitle => 'Der Verlauf ist leer';

  @override
  String get historyFailedItemMessage =>
      'Р“Сљbersetzung fehlgeschlagen. Tippe, um neu zu starten.';

  @override
  String get historyFailedTitle => 'Verlauf konnte nicht geladen werden';

  @override
  String get historyFilterAiTranslated => 'Mit KI Р“Сbersetzt';

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
      'Р“вЂ“ffne frР“Сhere UntertitelauftrР“В¤ge erneut, prР“Сfe die Vorschau noch einmal oder exportiere sie spР“В¤ter.';

  @override
  String get historyTitle => 'Р“Сљbersetzungsverlauf';

  @override
  String get homeFailedRecentTitle =>
      'Letzte AuftrР“В¤ge konnten nicht geladen werden';

  @override
  String get homeFutureSubtitle =>
      'Austauschbare Mock-Repositories schР“Сtzen den UI-Code vor Р“вЂћnderungen im Backend.';

  @override
  String get homeFutureTitle => 'Zukunftssichere Repositories';

  @override
  String get homeNoRecentMessage =>
      'Starte mit einer Filmsuche oder lade eine Untertiteldatei hoch, dann erscheinen deine letzten Р“Сљbersetzungen hier.';

  @override
  String get homeNoRecentTitle => 'Noch keine letzten AuftrР“В¤ge';

  @override
  String get homePreviewSubtitle =>
      'PrР“Сfe Ergebnisse vor dem Export in der Original-, Р“Сbersetzten oder zweisprachigen Ansicht.';

  @override
  String get homePreviewTitle => 'Vorschau-orientierter Р“Сљbersetzungsablauf';

  @override
  String get homeQuickHistory => 'Verlauf';

  @override
  String get homeQuickSearch => 'Suchen';

  @override
  String get homeQuickUpload => 'Hochladen';

  @override
  String get homeRecentJobsSubtitle =>
      'Р“вЂ“ffne deine neuesten Untertitel-Sitzungen erneut, ohne von vorn zu beginnen.';

  @override
  String get homeRecentJobsTitle => 'Letzte AuftrР“В¤ge';

  @override
  String get homeSearchPlaceholder => 'Filme oder Serien suchen...';

  @override
  String get homeStatesSubtitle =>
      'Lade-, Leer-, Retry-, Validierungs- und Mock-Offline-Szenarien gehР“В¶ren von Anfang an zur UX.';

  @override
  String get homeStatesTitle => 'Saubere ZustР“В¤nde inklusive';

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
  String get homeWelcomeSubtitle => 'Untertitel finden und Р“Сbersetzen';

  @override
  String get homeWelcomeTitle => 'Willkommen zurР“Сck';

  @override
  String jobConfidence(Object level) {
    return 'Sicherheit: $level';
  }

  @override
  String get jobOpenPreview => 'Vorschau Р“В¶ffnen';

  @override
  String get jobReuseSubtitle => 'Untertitel wiederverwenden';

  @override
  String get jobReuseTranslation => 'Р“Сљbersetzung wiederverwenden';

  @override
  String get legalBodyAbout =>
      'SubFlix ist ein Flutter-Client im Premium-Stil fР“Сr KI-UntertitelР“Сbersetzung. Dieser Build verwendet Mock-Repositories, kР“Сnstliche Latenz und lokale Speicherung, damit UI und Architektur reifen kР“В¶nnen, bevor ein echtes Backend angeschlossen wird.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix speichert derzeit nur Demo-Einstellungen und Р“Сљbersetzungsverlauf lokal auf dem GerР“В¤t. Eine spР“В¤tere Backend-Integration kann das durch authentifizierten Speicher, Audit-Trails und serverseitig verwaltete Aufbewahrungsrichtlinien ersetzen.';

  @override
  String get legalBodySupport =>
      'Der Support ist derzeit nur ein Platzhalter. In einer Produktionsversion kann dieser Bereich E-Mail, Problemberichte und Hilfe fР“Сr Premium-Konten anbinden, ohne die App-Struktur zu verР“В¤ndern.';

  @override
  String get legalBodyTerms =>
      'Dieser Demo-Build dient dazu, ProduktablР“В¤ufe, UI-ZustР“В¤nde und Architekturgrenzen zu erproben. Wenn spР“В¤ter ein produktives NestJS- und Postgres-Backend angebunden wird, kann die rechtliche Basis um echte Nutzungsbedingungen und Formulierungen zur Datenverarbeitung erweitert werden.';

  @override
  String get legalPlaceholderBody =>
      'Diese Seite ist in der Demo-App nur ein Platzhalter. Verbinde sie mit deinen rechtlichen Inhalten fР“Сr die Produktion.';

  @override
  String get legalTitleAbout => 'Р“Сљber SubFlix';

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
  String get metadataEstimatedDuration => 'GeschР“В¤tzte Dauer';

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
  String get onboardingEnterApp => 'SubFlix Р“В¶ffnen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingPage1Description =>
      'Suche einen Titel, prР“Сfe die verfР“Сgbaren englischen Untertitelquellen und starte einen Р“Сљbersetzungsablauf, der sich sofort anfР“Сhlt.';

  @override
  String get onboardingPage1Eyebrow => 'Suchen und laden';

  @override
  String get onboardingPage1Highlight1 =>
      'Deterministischer Demo-Katalog fР“Сr verlР“В¤ssliche Entwicklung';

  @override
  String get onboardingPage1Highlight2 =>
      'QualitР“В¤tslabels und Format-Badges fР“Сr Untertitelquellen';

  @override
  String get onboardingPage1Highlight3 =>
      'So gebaut, dass spР“В¤ter ein echtes Backend angeschlossen werden kann';

  @override
  String get onboardingPage1Title =>
      'Finde Filme oder Serien und hole sofort Р“Сbersetzbare Untertitel.';

  @override
  String get onboardingPage2Description =>
      'Importiere deine Untertiteldatei, prР“Сfe das Format und nutze dieselbe ausgereifte Р“Сљbersetzungspipeline, ohne die App zu verlassen.';

  @override
  String get onboardingPage2Eyebrow => 'Eigene Datei verwenden';

  @override
  String get onboardingPage2Highlight1 =>
      'Lokale DateiprР“Сfung und saubere Retry-ZustР“В¤nde';

  @override
  String get onboardingPage2Highlight2 =>
      'Konsistente Р“Сљbersetzungseinrichtung fР“Сr Upload und Suche';

  @override
  String get onboardingPage2Highlight3 =>
      'Vor dem Export ansehen, damit nichts undurchsichtig wirkt';

  @override
  String get onboardingPage2Title =>
      'Lade `.srt`- oder `.vtt`-Dateien hoch, wenn du das Skript schon hast.';

  @override
  String get onboardingPage3Description =>
      'Wechsle zwischen Original-, Р“Сљbersetzungs- und zweisprachiger Ansicht, gehe in den Verlauf zurР“Сck und exportiere saubere Untertiteldateien, sobald das Ergebnis passt.';

  @override
  String get onboardingPage3Eyebrow => 'Р“Сљbersetzen und exportieren';

  @override
  String get onboardingPage3Highlight1 =>
      'Schnelle Vorschau-Steuerung mit Metadaten und Suche';

  @override
  String get onboardingPage3Highlight2 =>
      'Der Verlauf hР“В¤lt frР“Сhere AuftrР“В¤ge nur einen Tipp entfernt';

  @override
  String get onboardingPage3Highlight3 =>
      'Gestaltet wie ein Premium-Medienwerkzeug, nicht wie eine Demo';

  @override
  String get onboardingPage3Title =>
      'WР“В¤hle Zielsprachen, prР“Сfe Untertitel und exportiere sofort.';

  @override
  String get onboardingSkip => 'Р“Сљberspringen';

  @override
  String get onboardingStart => 'Р“Сљbersetzung starten';

  @override
  String get previewFailedTitle => 'Vorschau konnte nicht geladen werden';

  @override
  String get previewModeBilingual => 'Zweisprachig';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Р“Сљbersetzt';

  @override
  String get previewNoMatchesMessage =>
      'Versuche einen anderen Suchbegriff oder entferne den Filter, um die komplette Р“Сљbersetzung zu prР“Сfen.';

  @override
  String get previewNoMatchesTitle => 'Keine Untertitelzeilen gefunden';

  @override
  String get previewNotReadyMessage =>
      'Die Р“Сљbersetzung ist fertig, aber das Backend hat noch keine Vorschau-Cues zurР“Сckgegeben. Lade diesen Bildschirm in einem Moment erneut.';

  @override
  String get previewNotReadyTitle =>
      'Vorschau-Cues sind noch nicht verfР“Сgbar';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get retryTranslation => 'Р“Сљbersetzung erneut starten';

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
      'Es konnte nicht bestimmt werden, fР“Сr welchen Titel Untertitelquellen geladen werden sollen. Starte die Suche erneut.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Untertitelquellen';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Es wurde keine Р“Сљbersetzungsanfrage Р“Сbergeben. Starte eine neue Р“Сљbersetzung aus Suche oder Upload.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'Р“Сљbersetzungsfortschritt';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Bevor der Bildschirm fР“Сr die Р“Сљbersetzungseinrichtung geР“В¶ffnet werden kann, ist eine Untertitelquelle erforderlich.';

  @override
  String get routeMissingTranslationSetupTitle => 'Р“Сљbersetzungseinrichtung';

  @override
  String get searchFailedTitle => 'Suche fehlgeschlagen';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count Ergebnisse fР“Сr \'\'$query\'\' gefunden';
  }

  @override
  String get searchHintText => 'Suche nach Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Suche lР“В¤uft...';

  @override
  String get searchMockMessage =>
      'Probiere Titel wie Inception, Dune, Breaking Bad, Severance oder The Last of Us aus, um den Ablauf der Untertitelquellen zu erkunden.';

  @override
  String get searchMockTitle => 'Suche im Demo-Katalog nach beliebigen Titeln';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Finde einen Titel, prР“Сfe Untertitelquellen und starte mit wenigen TippvorgР“В¤ngen einen Р“Сљbersetzungsauftrag.';

  @override
  String get searchMovieOrSeriesTitle => 'Film oder Serie suchen';

  @override
  String searchNoResultsFor(Object query) {
    return 'Keine Ergebnisse fР“Сr \'\'$query\'\' gefunden';
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
    return 'WР“В¤hle eine Staffel von $title, um verfР“Сgbare Folgen zu sehen.';
  }

  @override
  String get seriesSeasonsTitle => 'Staffel auswР“В¤hlen';

  @override
  String get settingsAboutTitle => 'Р“Сљber SubFlix';

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
      'Р“Сљbersetzungsverlauf fР“Сr dieses GerР“В¤t gelР“В¶scht';

  @override
  String get settingsLanguageLabel => 'Bevorzugte Zielsprache';

  @override
  String get settingsMaintenanceSubtitle =>
      'LР“В¶sche backendverwaltete Р“СљbersetzungsauftrР“В¤ge fР“Сr dieses GerР“В¤t und starte mit leerem Verlauf.';

  @override
  String get settingsMaintenanceTitle => 'Wartung';

  @override
  String get settingsNotificationsSubtitle =>
      'Benachrichtigungseinstellungen verwalten';

  @override
  String get settingsNotificationsTitle => 'Benachrichtigungen';

  @override
  String get settingsPremiumSubtitle =>
      'SpР“В¤ter kР“В¶nnen wir hier Abos, Abrechnung und Cloud-Projektsynchronisierung anbinden.';

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
  String get settingsSupportSubtitle => 'Demo-Seite fР“Сr Hilfe und Kontakt';

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
  String get splashSubtitle => 'KI-gestР“Сtzte UntertitelР“Сbersetzung';

  @override
  String get startTranslation => 'Р“Сљbersetzung starten';

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
      'WР“В¤hle eine Untertitelquelle und fahre mit einer ausgereiften Р“Сљbersetzungseinrichtung fort, die auf Untertitel-Timing abgestimmt ist.';

  @override
  String get subtitleSourcesBannerTitle => 'KI-Р“Сљbersetzung verfР“Сgbar';

  @override
  String get subtitleSourcesFailedTitle =>
      'Untertitelquellen konnten nicht geladen werden';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'WР“В¤hle eine Untertitelquelle fР“Сr $title$target und danach im nР“В¤chsten Schritt die Zielsprache.';
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
      'WР“В¤hlt automatisch die passende Ausgabestruktur fР“Сr Untertitel.';

  @override
  String get translateSetupLanguageTitle => 'Р“Сљbersetzen nach';

  @override
  String get translateSetupOptionsTitle => 'Optionen';

  @override
  String get translateSetupPreserveTiming => 'Timing beibehalten';

  @override
  String get translateSetupPreserveTimingBody =>
      'BehР“В¤lt die ursprР“Сnglichen Untertitelzeiten in Р“Сљbereinstimmung mit der Quelldatei bei.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Unser Р“Сљbersetzungsablauf Р“СbertrР“В¤gt diesen Untertitel in $language, mit erhaltenem Timing und sauberer Cue-Struktur.';
  }

  @override
  String get translateSetupReadyTitle => 'KI-Р“Сљbersetzung bereit';

  @override
  String get translateSetupSelectLanguage => 'Sprache auswР“В¤hlen';

  @override
  String get translateSetupSourceTitle => 'Quelluntertitel';

  @override
  String get translateSetupSubtitle =>
      'WР“В¤hle die Zielsprache, prР“Сfe die Untertitelquelle und starte dann den Р“Сљbersetzungsauftrag im Backend.';

  @override
  String get translateSetupTitle => 'Р“Сљbersetzung einrichten';

  @override
  String get translationFailedMessage => 'Etwas ist schiefgelaufen.';

  @override
  String get translationFailedTitle =>
      'Р“Сљbersetzung konnte nicht abgeschlossen werden';

  @override
  String get translationPreviewHeader => 'Р“Сљbersetzte Untertitel prР“Сfen';

  @override
  String get translationPreviewSearchHint => 'Untertitelzeilen durchsuchen';

  @override
  String get translationPreviewSubtitle =>
      'Suche innerhalb der Cues, wechsle den Vorschaumodus und exportiere erst, wenn die Р“Сљbersetzung stimmt.';

  @override
  String get translationPreviewTitle => 'Р“Сљbersetzungsvorschau';

  @override
  String get translationProgressHeadline =>
      'KI-UntertitelР“Сbersetzung lР“В¤uft';

  @override
  String get translationProgressTitle => 'Р“Сљbersetzungsfortschritt';

  @override
  String get translationResultCompleteSubtitle =>
      'Dein Untertitel ist zur Vorschau oder zum Download bereit.';

  @override
  String get translationResultCompleteTitle => 'Р“Сљbersetzung abgeschlossen';

  @override
  String get translationResultConfidenceLabel => 'Р“Сљbersetzungssicherheit';

  @override
  String get translationResultDetailsTitle => 'Р“Сљbersetzungsdetails';

  @override
  String get translationResultDownloadCta => 'Untertitel herunterladen';

  @override
  String get translationResultHomeCta => 'ZurР“Сck zur Startseite';

  @override
  String get translationResultMediaLabel => 'Medientitel';

  @override
  String get translationResultMethodAi => 'Mit KI Р“Сbersetzt';

  @override
  String get translationResultMetricsTitle => 'QualitР“В¤tsmetriken';

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
      'Einige Fachbegriffe profitieren womР“В¶glich noch von einer kurzen menschlichen KontextprР“Сfung.';

  @override
  String get translationStageAligning =>
      'Zeitstempel und Szenenkontext werden abgeglichen';

  @override
  String get translationStageGenerating =>
      'UntertitelР“Сbersetzung wird erstellt';

  @override
  String get translationStageIdle => 'Warten auf eine Р“Сљbersetzungsanfrage';

  @override
  String get translationStagePreparing => 'Untertitelpaket wird vorbereitet';

  @override
  String get translationStageQueued => 'Zur Р“Сљbersetzung eingereiht';

  @override
  String get translationStageReadability =>
      'LesbarkeitsprР“Сfung wird angewendet';

  @override
  String get translationStageReady => 'Р“Сљbersetzung bereit';

  @override
  String get tryAgain => 'Noch einmal versuchen';

  @override
  String get uploadChooseFile => 'Untertiteldatei auswР“В¤hlen';

  @override
  String get uploadChooseFileShort => 'Datei wР“В¤hlen';

  @override
  String get uploadContinueSetup => 'Weiter zur Р“Сљbersetzungseinrichtung';

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
      'Importiere eine englische `.srt`- oder `.vtt`-Datei, lasse sie vom Backend prР“Сfen und parsen und fahre dann mit der Р“Сљbersetzungseinrichtung fort.';

  @override
  String get uploadIntroTitle => 'Eigene Untertiteldatei verwenden';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount Zeilen';
  }

  @override
  String get uploadMetadataTitle => 'Untertiteldetails';

  @override
  String get uploadOpeningPicker => 'Dateiauswahl wird geР“В¶ffnet...';

  @override
  String get uploadPickSubtitle => 'Untertiteldatei wР“В¤hlen';

  @override
  String get uploadPickedFile => 'Untertiteldatei ausgewР“В¤hlt';

  @override
  String get uploadReadyTitle => 'Bereit zur Р“Сљbersetzung';

  @override
  String get uploadSubtitleTitle => 'Untertitel hochladen';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Englische Untertiteldateien im Format `.srt` und `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'UnterstР“Сtzte Formate';

  @override
  String get uploadUseDemoFile => 'Demo-Datei verwenden';
}
