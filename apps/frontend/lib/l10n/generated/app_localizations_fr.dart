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
  String get authAccountSectionTitle => 'Compte';

  @override
  String get authAlreadySignedInTitle => 'Vous êtes déjà connecté';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'Cet appareil est déjà connecté en tant que $email.';
  }

  @override
  String get authBackToAccount => 'Retour au compte';

  @override
  String get authBackToSignIn => 'Retour à la connexion';

  @override
  String get authCheckInboxTitle => 'Vérifiez votre boîte mail';

  @override
  String get authConfirmEmailAction => 'Confirmer l\'e-mail';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Utilisez le jeton de vérification envoyé à $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Collez le jeton de vérification reçu par e-mail pour terminer l\'activation de ce compte.';

  @override
  String get authConfirmEmailSuccess =>
      'E-mail confirmé. Vous pouvez maintenant vous connecter.';

  @override
  String get authConfirmEmailTitle => 'Vérifiez votre e-mail';

  @override
  String get authConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get authContinueToReset => 'Continuer vers la réinitialisation';

  @override
  String get authContinueWithGoogle => 'Continuer avec Google';

  @override
  String get authCreateAccountAction => 'Créer un compte';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Jeton de débogage : $token';
  }

  @override
  String get authDisplayNameLabel => 'Nom affiché';

  @override
  String get authEmailLabel => 'Adresse e-mail';

  @override
  String get authEyebrow => 'Espace sécurisé';

  @override
  String get authFieldRequired => 'Ce champ est obligatoire.';

  @override
  String get authForgotPasswordAction => 'Envoyer le lien de réinitialisation';

  @override
  String get authForgotPasswordDebugMessage =>
      'Un jeton de réinitialisation a été renvoyé pour cet environnement de débogage. Vous pouvez passer directement au formulaire de réinitialisation.';

  @override
  String get authForgotPasswordLink => 'Mot de passe oublié ?';

  @override
  String get authForgotPasswordSubtitle =>
      'Saisissez votre e-mail et nous demanderons au backend une réinitialisation de mot de passe pour ce compte.';

  @override
  String get authForgotPasswordSuccess =>
      'Si le compte existe, un message de réinitialisation du mot de passe a été envoyé.';

  @override
  String get authForgotPasswordTitle => 'Réinitialisez votre mot de passe';

  @override
  String get authGoogleHelper =>
      'La connexion Google utilise Firebase OAuth et fonctionnera une fois que cette application sera reliée à un projet Firebase.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'Vous avez déjà un compte ? Connectez-vous';

  @override
  String get authInvalidEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String get authNewPasswordLabel => 'Nouveau mot de passe';

  @override
  String get authNoAccountLink => 'Besoin d\'un compte ? Créez-en un';

  @override
  String get authOrDivider => 'ou';

  @override
  String get authPasswordLabel => 'Mot de passe';

  @override
  String get authPasswordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get authPasswordTooShort => 'Utilisez au moins 8 caractères.';

  @override
  String get authProfileRefreshed => 'Données du compte actualisées.';

  @override
  String get authRefreshProfileAction => 'Actualiser le profil';

  @override
  String get authRefreshProfileSubtitle =>
      'Charger les données de profil les plus récentes depuis le backend.';

  @override
  String get authResetPasswordAction => 'Enregistrer le nouveau mot de passe';

  @override
  String authResetPasswordHint(Object email) {
    return 'Réinitialisez le mot de passe de $email avec le jeton reçu par e-mail.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Saisissez le jeton de réinitialisation et choisissez un nouveau mot de passe pour ce compte.';

  @override
  String get authResetPasswordSuccess =>
      'Mot de passe mis à jour. Veuillez vous reconnecter.';

  @override
  String get authResetPasswordTitle => 'Choisissez un nouveau mot de passe';

  @override
  String get authSignInAction => 'Se connecter';

  @override
  String get authSignInSubtitle =>
      'Connectez cette application à votre compte SubFlix pour synchroniser les données du profil et débloquer les flux backend authentifiés.';

  @override
  String get authSignInSuccess => 'Connexion réussie.';

  @override
  String get authSignInTitle => 'Bon retour';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Connecté en tant que $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Connectez-vous pour gérer votre compte, utiliser Firebase OAuth et préparer les fonctionnalités authentifiées pour une future synchronisation.';

  @override
  String get authSignedOutCardTitle => 'Connectez-vous à SubFlix';

  @override
  String get authSignOutAction => 'Se déconnecter';

  @override
  String get authSignOutSubtitle =>
      'Révoquer la session actuelle sur cet appareil et effacer les jetons locaux.';

  @override
  String get authSignOutSuccess => 'Déconnecté sur cet appareil.';

  @override
  String get authSignUpAction => 'Créer mon compte';

  @override
  String get authSignUpSubtitle =>
      'Créez un compte pour que cette application puisse utiliser le profil authentifié et les flux de session du backend.';

  @override
  String get authSignUpSuccess =>
      'Compte créé. Continuez avec la vérification de l\'e-mail.';

  @override
  String get authSignUpTitle => 'Créez votre compte';

  @override
  String get authVerificationStatusTitle => 'Vérification de l\'e-mail';

  @override
  String get authVerificationTokenLabel => 'Jeton de vérification';

  @override
  String get authVerifiedStatus => 'Vérifié';

  @override
  String get authUnverifiedStatus => 'Vérification en attente';

  @override
  String get brandSubtitleCompact => 'Intelligence des sous-titres';

  @override
  String get brandSubtitleFull => 'Studio IA de traduction de sous-titres';

  @override
  String get comingSoonMessage => 'Cet Р“В©cran est encore en prР“В©paration.';

  @override
  String get comingSoonTitle => 'BientР“Т‘t disponible';

  @override
  String exportFailedSnack(Object error) {
    return 'Р“вЂ°chec de l\'\'export : $error';
  }

  @override
  String get exportSubtitleLabel => 'Exporter le sous-titre traduit';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName exportР“В© vers $path';
  }

  @override
  String get exportingLabel => 'Export en cours...';

  @override
  String get heroBadge => 'Workflow premium pour sous-titres';

  @override
  String get heroBody =>
      'Choisissez entre un catalogue de titres consultable ou l\'\'import direct d\'\'un fichier, puis prР“В©visualisez et exportez des sous-titres soignР“В©s en quelques minutes.';

  @override
  String get heroHeadline =>
      'Traduisez les sous-titres de films et de sР“В©ries avec un flux de niveau studio.';

  @override
  String get heroSearchCta => 'Rechercher film / sР“В©rie';

  @override
  String get heroStatLanguagesTitle => '10 langues';

  @override
  String get heroStatLanguagesValue => 'PrР“Р„tes pour l\'\'aperР“В§u';

  @override
  String get heroStatMockTitle => 'APIs mock';

  @override
  String get heroStatMockValue => 'Passerelle prР“Р„te pour le backend';

  @override
  String get heroStatPathsTitle => '2 parcours';

  @override
  String get heroStatPathsValue => 'Recherche ou import';

  @override
  String get heroSubtitle =>
      'Parcourez les catalogues de films et de sР“В©ries, choisissez vos sources et exportez des traductions soignР“В©es en quelques minutes.';

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
      'Vos sous-titres traduits apparaР“В®tront ici une fois qu\'\'un parcours de recherche ou d\'\'import sera terminР“В©.';

  @override
  String get historyEmptyTitle => 'L\'\'historique est vide';

  @override
  String get historyFailedItemMessage =>
      'La traduction a Р“В©chouР“В©. Touchez pour recommencer.';

  @override
  String get historyFailedTitle => 'Impossible de charger l\'\'historique';

  @override
  String get historyFilterAiTranslated => 'Traduit par IA';

  @override
  String get historyFilterAll => 'Tout';

  @override
  String get historyFilterCompleted => 'TerminР“В©s';

  @override
  String get historyFilterFailed => 'Р“вЂ°chec';

  @override
  String get historyFilterMovies => 'Films';

  @override
  String get historyFilterReused => 'RР“В©utilisР“В©';

  @override
  String get historyFilterSeries => 'SР“В©ries';

  @override
  String get historySubtitle =>
      'Rouvrez vos anciens travaux de sous-titres, revoyez l\'\'aperР“В§u ou exportez-les plus tard.';

  @override
  String get historyTitle => 'Historique des traductions';

  @override
  String get homeFailedRecentTitle =>
      'Impossible de charger les travaux rР“В©cents';

  @override
  String get homeFutureSubtitle =>
      'Des repositories mock interchangeables protР“РЃgent le code UI des changements backend.';

  @override
  String get homeFutureTitle => 'Repositories prР“Р„ts pour l\'\'avenir';

  @override
  String get homeNoRecentMessage =>
      'Commencez par rechercher un film ou importer un fichier de sous-titres, et vos traductions rР“В©centes apparaР“В®tront ici.';

  @override
  String get homeNoRecentTitle => 'Pas encore de travaux rР“В©cents';

  @override
  String get homePreviewSubtitle =>
      'Examinez les rР“В©sultats avant export en vue originale, traduite ou bilingue.';

  @override
  String get homePreviewTitle => 'Flux de traduction orientР“В© aperР“В§u';

  @override
  String get homeQuickHistory => 'Historique';

  @override
  String get homeQuickSearch => 'Rechercher';

  @override
  String get homeQuickUpload => 'Importer';

  @override
  String get homeRecentJobsSubtitle =>
      'Rouvrez vos derniР“РЃres sessions de sous-titres sans repartir de zР“В©ro.';

  @override
  String get homeRecentJobsTitle => 'Travaux rР“В©cents';

  @override
  String get homeSearchPlaceholder =>
      'Rechercher des films ou des sР“В©ries...';

  @override
  String get homeStatesSubtitle =>
      'Chargement, vide, relance, validation et scР“В©narios mock hors ligne font partie de l\'\'UX dР“РЃs le premier jour.';

  @override
  String get homeStatesTitle => 'Р“вЂ°tats soignР“В©s inclus';

  @override
  String get homeTrendingNow => 'Tendances du moment';

  @override
  String get homeTrustSubtitle =>
      'Encore simulР“В© aujourd\'\'hui, mais structurР“В© comme un vrai produit prР“Р„t Р“В  Р“Р„tre lancР“В©.';

  @override
  String get homeTrustTitle => 'Pourquoi les Р“В©quipes lui font confiance';

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
  String get jobOpenPreview => 'Ouvrir l\'\'aperР“В§u';

  @override
  String get jobReuseSubtitle => 'RР“В©utiliser le sous-titre';

  @override
  String get jobReuseTranslation => 'RР“В©utiliser la traduction';

  @override
  String get legalBodyAbout =>
      'SubFlix est un client Flutter au style premium dР“В©diР“В© Р“В  la traduction IA de sous-titres. Cette version utilise des repositories mock, une latence artificielle et une persistance locale afin que l\'\'UI et l\'\'architecture puissent mР“В»rir avant l\'\'arrivР“В©e d\'\'un vrai backend.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix stocke actuellement uniquement des prР“В©fР“В©rences mock et l\'\'historique des traductions sur l\'\'appareil via une persistance locale. Une future intР“В©gration backend pourra remplacer cela par un stockage authentifiР“В©, des pistes d\'\'audit et des politiques de rР“В©tention gР“В©rР“В©es cР“Т‘tР“В© serveur.';

  @override
  String get legalBodySupport =>
      'Le support n\'\'est pour l\'\'instant qu\'\'un emplacement. En production, cette section pourra se connecter Р“В  l\'\'e-mail, aux signalements de problР“РЃme et Р“В  l\'\'aide des comptes premium sans modifier la structure gР“В©nР“В©rale de l\'\'application.';

  @override
  String get legalBodyTerms =>
      'Cette version mock sert Р“В  Р“В©prouver les flux produit, les Р“В©tats UI et les limites d\'\'architecture. Lorsqu\'\'un backend de production NestJS et Postgres sera connectР“В© plus tard, la couche juridique pourra Р“Р„tre enrichie avec de vraies conditions de service et un langage de traitement des donnР“В©es.';

  @override
  String get legalPlaceholderBody =>
      'Cette page n\'\'est qu\'\'un emplacement dans l\'\'application de dР“В©monstration. Reliez-la Р“В  votre contenu juridique de production.';

  @override
  String get legalTitleAbout => 'Р“Р‚ propos de SubFlix';

  @override
  String get legalTitlePrivacy => 'Politique de confidentialitР“В©';

  @override
  String get legalTitleSupport => 'Support';

  @override
  String get legalTitleTerms => 'Conditions d\'\'utilisation';

  @override
  String get mediaTypeMovie => 'Film';

  @override
  String get mediaTypeSeries => 'SР“В©rie';

  @override
  String get metadataEstimatedDuration => 'DurР“В©e estimР“В©e';

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
  String get navSettings => 'RР“В©glages';

  @override
  String get noTitlesMatchedMessage =>
      'Nous n\'\'avons pas trouvР“В© ce titre dans le catalogue de dР“В©monstration. Essayez une recherche plus large ou l\'\'un des titres proposР“В©s.';

  @override
  String get noTitlesMatchedTitle => 'Aucun rР“В©sultat';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingEnterApp => 'Entrer dans SubFlix';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingPage1Description =>
      'Recherchez un titre, consultez les sources de sous-titres anglais disponibles et lancez un parcours de traduction quasi instantanР“В©.';

  @override
  String get onboardingPage1Eyebrow => 'Chercher et rР“В©cupР“В©rer';

  @override
  String get onboardingPage1Highlight1 =>
      'Catalogue mock dР“В©terministe pour un dР“В©veloppement fiable';

  @override
  String get onboardingPage1Highlight2 =>
      'LibellР“В©s de qualitР“В© et badges de format pour les sources';

  @override
  String get onboardingPage1Highlight3 =>
      'PensР“В© pour Р“Р„tre raccordР“В© Р“В  un vrai backend plus tard';

  @override
  String get onboardingPage1Title =>
      'Trouvez des films ou des sР“В©ries et rР“В©cupР“В©rez des sous-titres prР“Р„ts Р“В  traduire.';

  @override
  String get onboardingPage2Description =>
      'Importez votre fichier de sous-titres, validez le format et lancez le mР“Р„me pipeline soignР“В© sans quitter l\'\'application.';

  @override
  String get onboardingPage2Eyebrow => 'Apportez votre propre fichier';

  @override
  String get onboardingPage2Highlight1 =>
      'Validation locale des fichiers et Р“В©tats de relance Р“В©lР“В©gants';

  @override
  String get onboardingPage2Highlight2 =>
      'Configuration cohР“В©rente pour l\'\'import et la recherche';

  @override
  String get onboardingPage2Highlight3 =>
      'AperР“В§u avant export pour que rien ne paraisse opaque';

  @override
  String get onboardingPage2Title =>
      'Importez des fichiers `.srt` ou `.vtt` quand vous avez dР“В©jР“В  le script.';

  @override
  String get onboardingPage3Description =>
      'Passez de la vue originale Р“В  la vue traduite ou bilingue, revenez Р“В  l\'\'historique et exportez des fichiers propres dР“РЃs que le rР“В©sultat vous convient.';

  @override
  String get onboardingPage3Eyebrow => 'Traduire et exporter';

  @override
  String get onboardingPage3Highlight1 =>
      'ContrР“Т‘les d\'\'aperР“В§u rapides avec mР“В©tadonnР“В©es et recherche';

  @override
  String get onboardingPage3Highlight2 =>
      'L\'\'historique garde les anciens travaux Р“В  portР“В©e de geste';

  @override
  String get onboardingPage3Highlight3 =>
      'ConР“В§u comme un outil mР“В©dia premium, pas comme une dР“В©mo';

  @override
  String get onboardingPage3Title =>
      'Choisissez vos langues cibles, prР“В©visualisez les sous-titres et exportez aussitР“Т‘t.';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingStart => 'DР“В©marrer la traduction';

  @override
  String get previewFailedTitle => 'Р“вЂ°chec du chargement de l\'\'aperР“В§u';

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
      'La traduction est terminР“В©e, mais le backend n\'\'a pas encore renvoyР“В© les cues d\'\'aperР“В§u. RР“В©essayez dans un instant.';

  @override
  String get previewNotReadyTitle =>
      'Les cues d\'\'aperР“В§u ne sont pas encore disponibles';

  @override
  String get retry => 'RР“В©essayer';

  @override
  String get retryTranslation => 'Relancer la traduction';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Nous n\'\'avons pas pu dР“В©terminer quelle saison charger. Reprenez depuis la recherche.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Р“вЂ°pisodes de la saison';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Nous n\'\'avons pas pu dР“В©terminer quelle sР“В©rie charger. Reprenez depuis la recherche.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Saisons de la sР“В©rie';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Nous n\'\'avons pas pu dР“В©terminer pour quel titre charger les sources de sous-titres. Reprenez depuis la recherche.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Sources de sous-titres';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Aucune demande de traduction n\'\'a Р“В©tР“В© fournie. Lancez une nouvelle traduction depuis la recherche ou l\'\'import.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'Progression de la traduction';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Une source de sous-titres est requise avant l\'\'ouverture de l\'\'Р“В©cran de configuration de la traduction.';

  @override
  String get routeMissingTranslationSetupTitle =>
      'Configuration de la traduction';

  @override
  String get searchFailedTitle => 'La recherche a Р“В©chouР“В©';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count rР“В©sultats trouvР“В©s pour \"$query\"';
  }

  @override
  String get searchHintText => 'Recherchez Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Recherche en cours...';

  @override
  String get searchMockMessage =>
      'Essayez des titres comme Inception, Dune, Breaking Bad, Severance ou The Last of Us pour dР“В©couvrir le flux des sources de sous-titres.';

  @override
  String get searchMockTitle =>
      'Recherchez n\'\'importe quoi dans le catalogue de dР“В©monstration';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Trouvez un titre, examinez les sources de sous-titres et lancez une traduction en quelques gestes.';

  @override
  String get searchMovieOrSeriesTitle => 'Rechercher un film ou une sР“В©rie';

  @override
  String searchNoResultsFor(Object query) {
    return 'Aucun rР“В©sultat trouvР“В© pour \"$query\"';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'PopularitР“В© $score';
  }

  @override
  String get searchTitles => 'Rechercher des titres';

  @override
  String get searchTrendingTitle => 'Recherches tendances';

  @override
  String get searchTryDifferentKeywords =>
      'Essayez avec d\'\'autres mots-clР“В©s.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Р“вЂ°pisode $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Env. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount Р“В©pisodes$year';
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
    return '$episodeCount Р“В©pisodes$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Choisissez une saison de $title pour parcourir les Р“В©pisodes disponibles.';
  }

  @override
  String get seriesSeasonsTitle => 'Choisir une saison';

  @override
  String get settingsAboutTitle => 'Р“Р‚ propos de SubFlix';

  @override
  String get settingsCacheCleared => 'Cache vidР“В©';

  @override
  String get settingsClearCache => 'Vider le cache';

  @override
  String get settingsContactTitle => 'Nous contacter';

  @override
  String get settingsFailedTitle => 'Impossible de charger les rР“В©glages';

  @override
  String get settingsHelpCenterTitle => 'Centre d\'\'aide';

  @override
  String get settingsHistoryClearedSnack =>
      'Historique des traductions effacР“В© pour cet appareil';

  @override
  String get settingsLanguageLabel => 'Langue cible prР“В©fР“В©rР“В©e';

  @override
  String get settingsMaintenanceSubtitle =>
      'Effacez les travaux de traduction gР“В©rР“В©s par le backend sur cet appareil et repartez avec un historique vide.';

  @override
  String get settingsMaintenanceTitle => 'Maintenance';

  @override
  String get settingsNotificationsSubtitle =>
      'GР“В©rez les prР“В©fР“В©rences de notification';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsPremiumSubtitle =>
      'Plus tard, nous pourrons connecter ici les abonnements, la facturation et la synchronisation cloud des projets.';

  @override
  String get settingsPremiumTitle => 'Emplacement premium';

  @override
  String get settingsPrivacySubtitle => 'Contenu mock de confidentialitР“В©';

  @override
  String get settingsPrivacyTitle => 'Politique de confidentialitР“В©';

  @override
  String get settingsProfileName => 'Utilisateur SubFlix';

  @override
  String get settingsProfileTier => 'Membre premium';

  @override
  String get settingsSubtitle => 'GР“В©rez vos prР“В©fР“В©rences';

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
  String get settingsTitle => 'RР“В©glages';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'PrР“В©paration de votre studio de sous-titres';

  @override
  String get splashSubtitle => 'Traduction de sous-titres par IA';

  @override
  String get startTranslation => 'DР“В©marrer la traduction';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads tР“В©lР“В©chargements';
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
      'SР“В©lectionnez une source de sous-titres et poursuivez vers une configuration soignР“В©e, optimisР“В©e pour le timing des sous-titres.';

  @override
  String get subtitleSourcesBannerTitle => 'Traduction IA disponible';

  @override
  String get subtitleSourcesFailedTitle =>
      'Impossible de charger les sources de sous-titres';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Choisissez une source de sous-titres pour $title$target, puis sР“В©lectionnez la langue cible Р“В  l\'\'Р“В©tape suivante.';
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
  String get themeSystem => 'SystР“РЃme';

  @override
  String get translateSetupAutoDetect => 'DР“В©tection automatique du format';

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
      'Conserve le minutage d\'\'origine alignР“В© sur le fichier source.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Notre flux adaptera ce sous-titre en $language en conservant le timing et une structure de cues propre.';
  }

  @override
  String get translateSetupReadyTitle => 'Traduction IA prР“Р„te';

  @override
  String get translateSetupSelectLanguage => 'Choisir une langue';

  @override
  String get translateSetupSourceTitle => 'Sous-titre source';

  @override
  String get translateSetupSubtitle =>
      'Choisissez la langue cible, vР“В©rifiez la source du sous-titre, puis lancez la traduction cР“Т‘tР“В© backend.';

  @override
  String get translateSetupTitle => 'Configuration de la traduction';

  @override
  String get translationFailedMessage => 'Un problР“РЃme est survenu.';

  @override
  String get translationFailedTitle => 'La traduction n\'\'a pas pu aboutir';

  @override
  String get translationPreviewHeader => 'VР“В©rifiez les sous-titres traduits';

  @override
  String get translationPreviewSearchHint => 'Rechercher dans les lignes';

  @override
  String get translationPreviewSubtitle =>
      'Recherchez dans les cues, changez de mode d\'\'aperР“В§u, puis exportez une fois que le rendu vous convient.';

  @override
  String get translationPreviewTitle => 'AperР“В§u de la traduction';

  @override
  String get translationProgressHeadline =>
      'La traduction IA des sous-titres est en cours';

  @override
  String get translationProgressTitle => 'Progression de la traduction';

  @override
  String get translationResultCompleteSubtitle =>
      'Votre sous-titre est prР“Р„t pour l\'\'aperР“В§u ou le tР“В©lР“В©chargement.';

  @override
  String get translationResultCompleteTitle => 'Traduction terminР“В©e';

  @override
  String get translationResultConfidenceLabel => 'Confiance de traduction';

  @override
  String get translationResultDetailsTitle => 'DР“В©tails de la traduction';

  @override
  String get translationResultDownloadCta => 'TР“В©lР“В©charger le sous-titre';

  @override
  String get translationResultHomeCta => 'Retour Р“В  l\'\'accueil';

  @override
  String get translationResultMediaLabel => 'Titre du mР“В©dia';

  @override
  String get translationResultMethodAi => 'Traduit par IA';

  @override
  String get translationResultMetricsTitle => 'Indicateurs de qualitР“В©';

  @override
  String get translationResultPreviewCta => 'AperР“В§u du sous-titre';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'TraitР“В© en $duration';
  }

  @override
  String get translationResultSourceLabel => 'Langue source';

  @override
  String get translationResultTargetLabel => 'Langue cible';

  @override
  String get translationResultTimingLabel => 'PrР“В©cision du timing';

  @override
  String get translationResultTimingPreserved => 'Timing conservР“В©';

  @override
  String get translationResultWarning =>
      'Certains termes techniques peuvent encore mР“В©riter une relecture humaine rapide pour le contexte.';

  @override
  String get translationStageAligning =>
      'Alignement des horodatages et du contexte de scР“РЃne';

  @override
  String get translationStageGenerating =>
      'GР“В©nР“В©ration de la traduction des sous-titres';

  @override
  String get translationStageIdle =>
      'En attente d\'\'une demande de traduction';

  @override
  String get translationStagePreparing =>
      'PrР“В©paration du paquet de sous-titres';

  @override
  String get translationStageQueued => 'Mis en file pour traduction';

  @override
  String get translationStageReadability =>
      'Application du passage de lisibilitР“В©';

  @override
  String get translationStageReady => 'Traduction prР“Р„te';

  @override
  String get tryAgain => 'RР“В©essayer';

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
      'Nous n\'\'avons pas pu lire ce fichier de sous-titres. Essayez un autre fichier ou une exportation plus lР“В©gР“РЃre.';

  @override
  String get uploadFailedTitle => 'L\'\'import du fichier a Р“В©chouР“В©';

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
  String get uploadMetadataTitle => 'DР“В©tails du sous-titre';

  @override
  String get uploadOpeningPicker => 'Ouverture du sР“В©lecteur...';

  @override
  String get uploadPickSubtitle => 'Choisir un fichier de sous-titres';

  @override
  String get uploadPickedFile => 'Fichier de sous-titres sР“В©lectionnР“В©';

  @override
  String get uploadReadyTitle => 'PrР“Р„t Р“В  traduire';

  @override
  String get uploadSubtitleTitle => 'Importer un sous-titre';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Fichiers de sous-titres anglais `.srt` et `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formats pris en charge';

  @override
  String get uploadUseDemoFile => 'Utiliser un fichier de dР“В©monstration';
}
