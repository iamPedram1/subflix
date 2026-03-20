// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

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
  String get brandSubtitleCompact => 'Intelligence des sous-titres';

  @override
  String get brandSubtitleFull => 'Studio IA de traduction de sous-titres';

  @override
  String get comingSoonMessage => 'Cet écran est encore en préparation.';

  @override
  String get comingSoonTitle => 'Bientôt disponible';

  @override
  String exportFailedSnack(Object error) {
    return 'Échec de l\'\'export : $error';
  }

  @override
  String get exportSubtitleLabel => 'Exporter le sous-titre traduit';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName exporté vers $path';
  }

  @override
  String get exportingLabel => 'Export en cours...';

  @override
  String get heroBadge => 'Workflow premium pour sous-titres';

  @override
  String get heroBody =>
      'Choisissez entre un catalogue de titres consultable ou l\'\'import direct d\'\'un fichier, puis prévisualisez et exportez des sous-titres soignés en quelques minutes.';

  @override
  String get heroHeadline =>
      'Traduisez les sous-titres de films et de séries avec un flux de niveau studio.';

  @override
  String get heroSearchCta => 'Rechercher film / série';

  @override
  String get heroStatLanguagesTitle => '10 langues';

  @override
  String get heroStatLanguagesValue => 'Prêtes pour l\'\'aperçu';

  @override
  String get heroStatMockTitle => 'APIs mock';

  @override
  String get heroStatMockValue => 'Passerelle prête pour le backend';

  @override
  String get heroStatPathsTitle => '2 parcours';

  @override
  String get heroStatPathsValue => 'Recherche ou import';

  @override
  String get heroSubtitle =>
      'Parcourez les catalogues de films et de séries, choisissez vos sources et exportez des traductions soignées en quelques minutes.';

  @override
  String get heroTitle => 'Traduisez les sous-titres plus vite';

  @override
  String get heroUploadCta => 'Importer un sous-titre';

  @override
  String historyCountLabel(Object count) {
    return '$count traductions';
  }

  @override
  String get historyEmptyMessage =>
      'Vos sous-titres traduits apparaîtront ici une fois qu\'\'un parcours de recherche ou d\'\'import sera terminé.';

  @override
  String get historyEmptyTitle => 'L\'\'historique est vide';

  @override
  String get historyFailedItemMessage =>
      'La traduction a échoué. Touchez pour recommencer.';

  @override
  String get historyFailedTitle => 'Impossible de charger l\'\'historique';

  @override
  String get historyFilterAiTranslated => 'Traduit par IA';

  @override
  String get historyFilterAll => 'Tout';

  @override
  String get historyFilterCompleted => 'Terminés';

  @override
  String get historyFilterFailed => 'Échec';

  @override
  String get historyFilterMovies => 'Films';

  @override
  String get historyFilterReused => 'Réutilisé';

  @override
  String get historyFilterSeries => 'Séries';

  @override
  String get historySubtitle =>
      'Rouvrez vos anciens travaux de sous-titres, revoyez l\'\'aperçu ou exportez-les plus tard.';

  @override
  String get historyTitle => 'Historique des traductions';

  @override
  String get homeFailedRecentTitle =>
      'Impossible de charger les travaux récents';

  @override
  String get homeFutureSubtitle =>
      'Des repositories mock interchangeables protègent le code UI des changements backend.';

  @override
  String get homeFutureTitle => 'Repositories prêts pour l\'\'avenir';

  @override
  String get homeNoRecentMessage =>
      'Commencez par rechercher un film ou importer un fichier de sous-titres, et vos traductions récentes apparaîtront ici.';

  @override
  String get homeNoRecentTitle => 'Pas encore de travaux récents';

  @override
  String get homePreviewSubtitle =>
      'Examinez les résultats avant export en vue originale, traduite ou bilingue.';

  @override
  String get homePreviewTitle => 'Flux de traduction orienté aperçu';

  @override
  String get homeQuickHistory => 'Historique';

  @override
  String get homeQuickSearch => 'Rechercher';

  @override
  String get homeQuickUpload => 'Importer';

  @override
  String get homeRecentJobsSubtitle =>
      'Rouvrez vos dernières sessions de sous-titres sans repartir de zéro.';

  @override
  String get homeRecentJobsTitle => 'Travaux récents';

  @override
  String get homeSearchPlaceholder => 'Rechercher des films ou des séries...';

  @override
  String get homeStatesSubtitle =>
      'Chargement, vide, relance, validation et scénarios mock hors ligne font partie de l\'\'UX dès le premier jour.';

  @override
  String get homeStatesTitle => 'États soignés inclus';

  @override
  String get homeTrendingNow => 'Tendances du moment';

  @override
  String get homeTrustSubtitle =>
      'Encore simulé aujourd\'\'hui, mais structuré comme un vrai produit prêt à être lancé.';

  @override
  String get homeTrustTitle => 'Pourquoi les équipes lui font confiance';

  @override
  String get homeViewAll => 'Voir tout';

  @override
  String get homeWelcomeSubtitle => 'Trouvez et traduisez des sous-titres';

  @override
  String get homeWelcomeTitle => 'Bon retour';

  @override
  String jobConfidence(Object level) {
    return 'Confiance : $level';
  }

  @override
  String get jobOpenPreview => 'Ouvrir l\'\'aperçu';

  @override
  String get jobReuseSubtitle => 'Réutiliser le sous-titre';

  @override
  String get jobReuseTranslation => 'Réutiliser la traduction';

  @override
  String get legalBodyAbout =>
      'SubFlix est un client Flutter au style premium dédié à la traduction IA de sous-titres. Cette version utilise des repositories mock, une latence artificielle et une persistance locale afin que l\'\'UI et l\'\'architecture puissent mûrir avant l\'\'arrivée d\'\'un vrai backend.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix stocke actuellement uniquement des préférences mock et l\'\'historique des traductions sur l\'\'appareil via une persistance locale. Une future intégration backend pourra remplacer cela par un stockage authentifié, des pistes d\'\'audit et des politiques de rétention gérées côté serveur.';

  @override
  String get legalBodySupport =>
      'Le support n\'\'est pour l\'\'instant qu\'\'un emplacement. En production, cette section pourra se connecter à l\'\'e-mail, aux signalements de problème et à l\'\'aide des comptes premium sans modifier la structure générale de l\'\'application.';

  @override
  String get legalBodyTerms =>
      'Cette version mock sert à éprouver les flux produit, les états UI et les limites d\'\'architecture. Lorsqu\'\'un backend de production NestJS et Postgres sera connecté plus tard, la couche juridique pourra être enrichie avec de vraies conditions de service et un langage de traitement des données.';

  @override
  String get legalPlaceholderBody =>
      'Cette page n\'\'est qu\'\'un emplacement dans l\'\'application de démonstration. Reliez-la à votre contenu juridique de production.';

  @override
  String get legalTitleAbout => 'À propos de SubFlix';

  @override
  String get legalTitlePrivacy => 'Politique de confidentialité';

  @override
  String get legalTitleSupport => 'Support';

  @override
  String get legalTitleTerms => 'Conditions d\'\'utilisation';

  @override
  String get mediaTypeMovie => 'Film';

  @override
  String get mediaTypeSeries => 'Série';

  @override
  String get metadataEstimatedDuration => 'Durée estimée';

  @override
  String get metadataFormat => 'Format';

  @override
  String get metadataLanguages => 'Langues';

  @override
  String get metadataLines => 'Lignes';

  @override
  String get navHistory => 'Historique';

  @override
  String get navHome => 'Accueil';

  @override
  String get navSettings => 'Réglages';

  @override
  String get noTitlesMatchedMessage =>
      'Nous n\'\'avons pas trouvé ce titre dans le catalogue de démonstration. Essayez une recherche plus large ou l\'\'un des titres proposés.';

  @override
  String get noTitlesMatchedTitle => 'Aucun résultat';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingEnterApp => 'Entrer dans SubFlix';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingPage1Description =>
      'Recherchez un titre, consultez les sources de sous-titres anglais disponibles et lancez un parcours de traduction quasi instantané.';

  @override
  String get onboardingPage1Eyebrow => 'Chercher et récupérer';

  @override
  String get onboardingPage1Highlight1 =>
      'Catalogue mock déterministe pour un développement fiable';

  @override
  String get onboardingPage1Highlight2 =>
      'Libellés de qualité et badges de format pour les sources';

  @override
  String get onboardingPage1Highlight3 =>
      'Pensé pour être raccordé à un vrai backend plus tard';

  @override
  String get onboardingPage1Title =>
      'Trouvez des films ou des séries et récupérez des sous-titres prêts à traduire.';

  @override
  String get onboardingPage2Description =>
      'Importez votre fichier de sous-titres, validez le format et lancez le même pipeline soigné sans quitter l\'\'application.';

  @override
  String get onboardingPage2Eyebrow => 'Apportez votre propre fichier';

  @override
  String get onboardingPage2Highlight1 =>
      'Validation locale des fichiers et états de relance élégants';

  @override
  String get onboardingPage2Highlight2 =>
      'Configuration cohérente pour l\'\'import et la recherche';

  @override
  String get onboardingPage2Highlight3 =>
      'Aperçu avant export pour que rien ne paraisse opaque';

  @override
  String get onboardingPage2Title =>
      'Importez des fichiers `.srt` ou `.vtt` quand vous avez déjà le script.';

  @override
  String get onboardingPage3Description =>
      'Passez de la vue originale à la vue traduite ou bilingue, revenez à l\'\'historique et exportez des fichiers propres dès que le résultat vous convient.';

  @override
  String get onboardingPage3Eyebrow => 'Traduire et exporter';

  @override
  String get onboardingPage3Highlight1 =>
      'Contrôles d\'\'aperçu rapides avec métadonnées et recherche';

  @override
  String get onboardingPage3Highlight2 =>
      'L\'\'historique garde les anciens travaux à portée de geste';

  @override
  String get onboardingPage3Highlight3 =>
      'Conçu comme un outil média premium, pas comme une démo';

  @override
  String get onboardingPage3Title =>
      'Choisissez vos langues cibles, prévisualisez les sous-titres et exportez aussitôt.';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingStart => 'Démarrer la traduction';

  @override
  String get previewFailedTitle => 'Échec du chargement de l\'\'aperçu';

  @override
  String get previewModeBilingual => 'Bilingue';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Traduit';

  @override
  String get previewNoMatchesMessage =>
      'Essayez un autre terme de recherche ou supprimez le filtre pour inspecter toute la traduction.';

  @override
  String get previewNoMatchesTitle => 'Aucune ligne correspondante';

  @override
  String get previewNotReadyMessage =>
      'La traduction est terminée, mais le backend n\'\'a pas encore renvoyé les cues d\'\'aperçu. Réessayez dans un instant.';

  @override
  String get previewNotReadyTitle =>
      'Les cues d\'\'aperçu ne sont pas encore disponibles';

  @override
  String get retry => 'Réessayer';

  @override
  String get retryTranslation => 'Relancer la traduction';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Nous n\'\'avons pas pu déterminer quelle saison charger. Reprenez depuis la recherche.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Épisodes de la saison';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Nous n\'\'avons pas pu déterminer quelle série charger. Reprenez depuis la recherche.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Saisons de la série';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Nous n\'\'avons pas pu déterminer pour quel titre charger les sources de sous-titres. Reprenez depuis la recherche.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Sources de sous-titres';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Aucune demande de traduction n\'\'a été fournie. Lancez une nouvelle traduction depuis la recherche ou l\'\'import.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'Progression de la traduction';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Une source de sous-titres est requise avant l\'\'ouverture de l\'\'écran de configuration de la traduction.';

  @override
  String get routeMissingTranslationSetupTitle =>
      'Configuration de la traduction';

  @override
  String get searchFailedTitle => 'La recherche a échoué';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count résultats trouvés pour \"$query\"';
  }

  @override
  String get searchHintText => 'Recherchez Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Recherche en cours...';

  @override
  String get searchMockMessage =>
      'Essayez des titres comme Inception, Dune, Breaking Bad, Severance ou The Last of Us pour découvrir le flux des sources de sous-titres.';

  @override
  String get searchMockTitle =>
      'Recherchez n\'\'importe quoi dans le catalogue de démonstration';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Trouvez un titre, examinez les sources de sous-titres et lancez une traduction en quelques gestes.';

  @override
  String get searchMovieOrSeriesTitle => 'Rechercher un film ou une série';

  @override
  String searchNoResultsFor(Object query) {
    return 'Aucun résultat trouvé pour \"$query\"';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularité $score';
  }

  @override
  String get searchTitles => 'Rechercher des titres';

  @override
  String get searchTrendingTitle => 'Recherches tendances';

  @override
  String get searchTryDifferentKeywords =>
      'Essayez avec d\'\'autres mots-clés.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Épisode $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Env. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount épisodes$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Saison $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Saison $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount épisodes$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Choisissez une saison de $title pour parcourir les épisodes disponibles.';
  }

  @override
  String get seriesSeasonsTitle => 'Choisir une saison';

  @override
  String get settingsAboutTitle => 'À propos de SubFlix';

  @override
  String get settingsCacheCleared => 'Cache vidé';

  @override
  String get settingsClearCache => 'Vider le cache';

  @override
  String get settingsContactTitle => 'Nous contacter';

  @override
  String get settingsFailedTitle => 'Impossible de charger les réglages';

  @override
  String get settingsHelpCenterTitle => 'Centre d\'\'aide';

  @override
  String get settingsHistoryClearedSnack =>
      'Historique des traductions effacé pour cet appareil';

  @override
  String get settingsLanguageLabel => 'Langue cible préférée';

  @override
  String get settingsMaintenanceSubtitle =>
      'Effacez les travaux de traduction gérés par le backend sur cet appareil et repartez avec un historique vide.';

  @override
  String get settingsMaintenanceTitle => 'Maintenance';

  @override
  String get settingsNotificationsSubtitle =>
      'Gérez les préférences de notification';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsPremiumSubtitle =>
      'Plus tard, nous pourrons connecter ici les abonnements, la facturation et la synchronisation cloud des projets.';

  @override
  String get settingsPremiumTitle => 'Emplacement premium';

  @override
  String get settingsPrivacySubtitle => 'Contenu mock de confidentialité';

  @override
  String get settingsPrivacyTitle => 'Politique de confidentialité';

  @override
  String get settingsProfileName => 'Utilisateur SubFlix';

  @override
  String get settingsProfileTier => 'Membre premium';

  @override
  String get settingsSubtitle => 'Gérez vos préférences';

  @override
  String get settingsSupportSubtitle => 'Page mock d\'\'aide et de contact';

  @override
  String get settingsSupportTitle => 'Emplacement support';

  @override
  String get settingsTermsSubtitle => 'Contenu mock des conditions';

  @override
  String get settingsTermsTitle => 'Conditions d\'\'utilisation';

  @override
  String get settingsThemeLabel => 'Apparence';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Préparation de votre studio de sous-titres';

  @override
  String get splashSubtitle => 'Traduction de sous-titres par IA';

  @override
  String get startTranslation => 'Démarrer la traduction';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads téléchargements';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Source de sous-titres $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount lignes';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'Note $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Sélectionnez une source de sous-titres et poursuivez vers une configuration soignée, optimisée pour le timing des sous-titres.';

  @override
  String get subtitleSourcesBannerTitle => 'Traduction IA disponible';

  @override
  String get subtitleSourcesFailedTitle =>
      'Impossible de charger les sources de sous-titres';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Choisissez une source de sous-titres pour $title$target, puis sélectionnez la langue cible à l\'\'étape suivante.';
  }

  @override
  String get subtitleSourcesTitle => 'Sources de sous-titres anglais';

  @override
  String get targetLanguage => 'Langue cible';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeSystem => 'Système';

  @override
  String get translateSetupAutoDetect => 'Détection automatique du format';

  @override
  String get translateSetupAutoDetectBody =>
      'Choisit automatiquement la bonne structure de sortie pour les sous-titres.';

  @override
  String get translateSetupLanguageTitle => 'Traduire vers';

  @override
  String get translateSetupOptionsTitle => 'Options';

  @override
  String get translateSetupPreserveTiming => 'Conserver le timing';

  @override
  String get translateSetupPreserveTimingBody =>
      'Conserve le minutage d\'\'origine aligné sur le fichier source.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Notre flux adaptera ce sous-titre en $language en conservant le timing et une structure de cues propre.';
  }

  @override
  String get translateSetupReadyTitle => 'Traduction IA prête';

  @override
  String get translateSetupSelectLanguage => 'Choisir une langue';

  @override
  String get translateSetupSourceTitle => 'Sous-titre source';

  @override
  String get translateSetupSubtitle =>
      'Choisissez la langue cible, vérifiez la source du sous-titre, puis lancez la traduction côté backend.';

  @override
  String get translateSetupTitle => 'Configuration de la traduction';

  @override
  String get translationFailedMessage => 'Un problème est survenu.';

  @override
  String get translationFailedTitle => 'La traduction n\'\'a pas pu aboutir';

  @override
  String get translationPreviewHeader => 'Vérifiez les sous-titres traduits';

  @override
  String get translationPreviewSearchHint => 'Rechercher dans les lignes';

  @override
  String get translationPreviewSubtitle =>
      'Recherchez dans les cues, changez de mode d\'\'aperçu, puis exportez une fois que le rendu vous convient.';

  @override
  String get translationPreviewTitle => 'Aperçu de la traduction';

  @override
  String get translationProgressHeadline =>
      'La traduction IA des sous-titres est en cours';

  @override
  String get translationProgressTitle => 'Progression de la traduction';

  @override
  String get translationResultCompleteSubtitle =>
      'Votre sous-titre est prêt pour l\'\'aperçu ou le téléchargement.';

  @override
  String get translationResultCompleteTitle => 'Traduction terminée';

  @override
  String get translationResultConfidenceLabel => 'Confiance de traduction';

  @override
  String get translationResultDetailsTitle => 'Détails de la traduction';

  @override
  String get translationResultDownloadCta => 'Télécharger le sous-titre';

  @override
  String get translationResultHomeCta => 'Retour à l\'\'accueil';

  @override
  String get translationResultMediaLabel => 'Titre du média';

  @override
  String get translationResultMethodAi => 'Traduit par IA';

  @override
  String get translationResultMetricsTitle => 'Indicateurs de qualité';

  @override
  String get translationResultPreviewCta => 'Aperçu du sous-titre';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Traité en $duration';
  }

  @override
  String get translationResultSourceLabel => 'Langue source';

  @override
  String get translationResultTargetLabel => 'Langue cible';

  @override
  String get translationResultTimingLabel => 'Précision du timing';

  @override
  String get translationResultTimingPreserved => 'Timing conservé';

  @override
  String get translationResultWarning =>
      'Certains termes techniques peuvent encore mériter une relecture humaine rapide pour le contexte.';

  @override
  String get translationStageAligning =>
      'Alignement des horodatages et du contexte de scène';

  @override
  String get translationStageGenerating =>
      'Génération de la traduction des sous-titres';

  @override
  String get translationStageIdle =>
      'En attente d\'\'une demande de traduction';

  @override
  String get translationStagePreparing =>
      'Préparation du paquet de sous-titres';

  @override
  String get translationStageQueued => 'Mis en file pour traduction';

  @override
  String get translationStageReadability =>
      'Application du passage de lisibilité';

  @override
  String get translationStageReady => 'Traduction prête';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get uploadChooseFile => 'Choisir un fichier de sous-titres';

  @override
  String get uploadChooseFileShort => 'Choisir un fichier';

  @override
  String get uploadContinueSetup => 'Continuer vers la configuration';

  @override
  String get uploadEnglishSource => 'Source anglaise';

  @override
  String get uploadFailedFallback =>
      'Veuillez essayer un autre fichier de sous-titres.';

  @override
  String get uploadFailedMessage =>
      'Nous n\'\'avons pas pu lire ce fichier de sous-titres. Essayez un autre fichier ou une exportation plus légère.';

  @override
  String get uploadFailedTitle => 'L\'\'import du fichier a échoué';

  @override
  String get uploadIntroSubtitle =>
      'Importez un fichier anglais `.srt` ou `.vtt`, laissez le backend le valider et l\'\'analyser, puis poursuivez vers la configuration de la traduction.';

  @override
  String get uploadIntroTitle => 'Utilisez votre propre fichier de sous-titres';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount lignes';
  }

  @override
  String get uploadMetadataTitle => 'Détails du sous-titre';

  @override
  String get uploadOpeningPicker => 'Ouverture du sélecteur...';

  @override
  String get uploadPickSubtitle => 'Choisir un fichier de sous-titres';

  @override
  String get uploadPickedFile => 'Fichier de sous-titres sélectionné';

  @override
  String get uploadReadyTitle => 'Prêt à traduire';

  @override
  String get uploadSubtitleTitle => 'Importer un sous-titre';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Fichiers de sous-titres anglais `.srt` et `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formats pris en charge';

  @override
  String get uploadUseDemoFile => 'Utiliser un fichier de démonstration';
}
