const Map<String, String> kStringsFr = <String, String>{
  'appTitle': "SubFlix",
  'searchTitles': "Rechercher des titres",
  'searchMovieOrSeriesTitle': "Rechercher un film ou une série",
  'searchMovieOrSeriesSubtitle':
      "Trouvez un titre, examinez les sources de sous-titres et lancez une traduction en quelques gestes.",
  'searchHintText': "Recherchez Dune, Breaking Bad, Severance...",
  'searchMockTitle':
      "Recherchez n'importe quoi dans le catalogue de démonstration",
  'searchMockMessage':
      "Essayez des titres comme Inception, Dune, Breaking Bad, Severance ou The Last of Us pour découvrir le flux des sources de sous-titres.",
  'searchFailedTitle': "La recherche a échoué",
  'noTitlesMatchedTitle': "Aucun résultat",
  'noTitlesMatchedMessage':
      "Nous n'avons pas trouvé ce titre dans le catalogue de démonstration. Essayez une recherche plus large ou l'un des titres proposés.",
  'searchTrendingTitle': "Recherches tendances",
  'searchLoadingLabel': "Recherche en cours...",
  'searchFoundResults': "{count} résultats trouvés pour \"{query}\"",
  'searchNoResultsFor': "Aucun résultat trouvé pour \"{query}\"",
  'searchTryDifferentKeywords': "Essayez avec d'autres mots-clés.",
  'retry': "Réessayer",
  'retryTranslation': "Relancer la traduction",
  'uploadSubtitleTitle': "Importer un sous-titre",
  'uploadIntroTitle': "Utilisez votre propre fichier de sous-titres",
  'uploadIntroSubtitle':
      "Importez un fichier anglais `.srt` ou `.vtt`, laissez le backend le valider et l'analyser, puis poursuivez vers la configuration de la traduction.",
  'uploadChooseFile': "Choisir un fichier de sous-titres",
  'uploadSupportedFormatsTitle': "Formats pris en charge",
  'uploadSupportedFormatsSubtitle':
      "Fichiers de sous-titres anglais `.srt` et `.vtt`",
  'uploadOpeningPicker': "Ouverture du sélecteur...",
  'uploadChooseFileShort': "Choisir un fichier",
  'uploadPickSubtitle': "Choisir un fichier de sous-titres",
  'uploadPickedFile': "Fichier de sous-titres sélectionné",
  'uploadUseDemoFile': "Utiliser un fichier de démonstration",
  'uploadFailedTitle': "L'import du fichier a échoué",
  'uploadFailedMessage':
      "Nous n'avons pas pu lire ce fichier de sous-titres. Essayez un autre fichier ou une exportation plus légère.",
  'uploadFailedFallback': "Veuillez essayer un autre fichier de sous-titres.",
  'tryAgain': "Réessayer",
  'uploadMetadataTitle': "Détails du sous-titre",
  'uploadReadyTitle': "Prêt à traduire",
  'uploadLineCount': "{lineCount} lignes",
  'uploadEnglishSource': "Source anglaise",
  'uploadContinueSetup': "Continuer vers la configuration",
  'translateSetupTitle': "Configuration de la traduction",
  'translateSetupSubtitle':
      "Choisissez la langue cible, vérifiez la source du sous-titre, puis lancez la traduction côté backend.",
  'translateSetupSourceTitle': "Sous-titre source",
  'translateSetupLanguageTitle': "Traduire vers",
  'translateSetupOptionsTitle': "Options",
  'translateSetupSelectLanguage': "Choisir une langue",
  'translateSetupReadyTitle': "Traduction IA prête",
  'translateSetupReadyBody':
      "Notre flux adaptera ce sous-titre en {language} en conservant le timing et une structure de cues propre.",
  'translateSetupPreserveTiming': "Conserver le timing",
  'translateSetupPreserveTimingBody':
      "Conserve le minutage d'origine aligné sur le fichier source.",
  'translateSetupAutoDetect': "Détection automatique du format",
  'translateSetupAutoDetectBody':
      "Choisit automatiquement la bonne structure de sortie pour les sous-titres.",
  'subtitleSourceFormatLabel': "Source de sous-titres {format}",
  'targetLanguage': "Langue cible",
  'startTranslation': "Démarrer la traduction",
  'translationProgressTitle': "Progression de la traduction",
  'translationProgressHeadline':
      "La traduction IA des sous-titres est en cours",
  'translationFailedTitle': "La traduction n'a pas pu aboutir",
  'translationFailedMessage': "Un problème est survenu.",
  'translationStageQueued': "Mis en file pour traduction",
  'translationStageIdle': "En attente d'une demande de traduction",
  'translationStagePreparing': "Préparation du paquet de sous-titres",
  'translationStageAligning':
      "Alignement des horodatages et du contexte de scène",
  'translationStageGenerating': "Génération de la traduction des sous-titres",
  'translationStageReadability': "Application du passage de lisibilité",
  'translationStageReady': "Traduction prête",
  'translationResultCompleteTitle': "Traduction terminée",
  'translationResultCompleteSubtitle':
      "Votre sous-titre est prêt pour l'aperçu ou le téléchargement.",
  'translationResultDetailsTitle': "Détails de la traduction",
  'translationResultMediaLabel': "Titre du média",
  'translationResultSourceLabel': "Langue source",
  'translationResultTargetLabel': "Langue cible",
  'translationResultMethodAi': "Traduit par IA",
  'translationResultMetricsTitle': "Indicateurs de qualité",
  'translationResultConfidenceLabel': "Confiance de traduction",
  'translationResultTimingLabel': "Précision du timing",
  'translationResultTimingPreserved': "Timing conservé",
  'translationResultProcessedIn': "Traité en {duration}",
  'translationResultWarning':
      "Certains termes techniques peuvent encore mériter une relecture humaine rapide pour le contexte.",
  'translationResultPreviewCta': "Aperçu du sous-titre",
  'translationResultDownloadCta': "Télécharger le sous-titre",
  'translationResultHomeCta': "Retour à l'accueil",
  'translationPreviewTitle': "Aperçu de la traduction",
  'translationPreviewHeader': "Vérifiez les sous-titres traduits",
  'translationPreviewSubtitle':
      "Recherchez dans les cues, changez de mode d'aperçu, puis exportez une fois que le rendu vous convient.",
  'translationPreviewSearchHint': "Rechercher dans les lignes",
  'previewModeOriginal': "Original",
  'previewModeTranslated': "Traduit",
  'previewModeBilingual': "Bilingue",
  'previewNotReadyTitle': "Les cues d'aperçu ne sont pas encore disponibles",
  'previewNotReadyMessage':
      "La traduction est terminée, mais le backend n'a pas encore renvoyé les cues d'aperçu. Réessayez dans un instant.",
  'previewNoMatchesTitle': "Aucune ligne correspondante",
  'previewNoMatchesMessage':
      "Essayez un autre terme de recherche ou supprimez le filtre pour inspecter toute la traduction.",
  'previewFailedTitle': "Échec du chargement de l'aperçu",
  'exportingLabel': "Export en cours...",
  'exportSubtitleLabel': "Exporter le sous-titre traduit",
  'exportedSnack': "{fileName} exporté vers {path}",
  'exportFailedSnack': "Échec de l'export : {error}",
  'metadataFormat': "Format",
  'metadataLines': "Lignes",
  'metadataLanguages': "Langues",
  'metadataEstimatedDuration': "Durée estimée",
  'subtitleSourcesTitle': "Sources de sous-titres anglais",
  'subtitleSourcesSubtitle':
      "Choisissez une source de sous-titres pour {title}{target}, puis sélectionnez la langue cible à l'étape suivante.",
  'subtitleSourcesBannerTitle': "Traduction IA disponible",
  'subtitleSourcesBannerMessage':
      "Sélectionnez une source de sous-titres et poursuivez vers une configuration soignée, optimisée pour le timing des sous-titres.",
  'subtitleSourcesFailedTitle':
      "Impossible de charger les sources de sous-titres",
  'seriesSeasonsTitle': "Choisir une saison",
  'seriesSeasonsSubtitle':
      "Choisissez une saison de {title} pour parcourir les épisodes disponibles.",
  'seriesSeasonLabel': "Saison {seasonNumber}",
  'seriesSeasonMeta': "{episodeCount} épisodes{year}",
  'seriesEpisodesTitle': "Saison {seasonNumber}",
  'seriesEpisodesSubtitle': "{episodeCount} épisodes{year}",
  'seriesEpisodeLabel': "Épisode {episodeNumber}",
  'seriesEpisodeMeta': "Env. {runtime} min",
  'historyTitle': "Historique des traductions",
  'historySubtitle':
      "Rouvrez vos anciens travaux de sous-titres, revoyez l'aperçu ou exportez-les plus tard.",
  'historyEmptyTitle': "L'historique est vide",
  'historyEmptyMessage':
      "Vos sous-titres traduits apparaîtront ici une fois qu'un parcours de recherche ou d'import sera terminé.",
  'historyFailedTitle': "Impossible de charger l'historique",
  'historyCountLabel': "{count} traductions",
  'historyFilterAll': "Tout",
  'historyFilterMovies': "Films",
  'historyFilterSeries': "Séries",
  'historyFilterCompleted': "Terminés",
  'historyFilterAiTranslated': "Traduit par IA",
  'historyFilterFailed': "Échec",
  'historyFilterReused': "Réutilisé",
  'historyFailedItemMessage':
      "La traduction a échoué. Touchez pour recommencer.",
  'homeRecentJobsTitle': "Travaux récents",
  'homeRecentJobsSubtitle':
      "Rouvrez vos dernières sessions de sous-titres sans repartir de zéro.",
  'homeNoRecentTitle': "Pas encore de travaux récents",
  'homeNoRecentMessage':
      "Commencez par rechercher un film ou importer un fichier de sous-titres, et vos traductions récentes apparaîtront ici.",
  'homeFailedRecentTitle': "Impossible de charger les travaux récents",
  'homeWelcomeTitle': "Bon retour",
  'homeWelcomeSubtitle': "Trouvez et traduisez des sous-titres",
  'homeSearchPlaceholder': "Rechercher des films ou des séries...",
  'homeQuickSearch': "Rechercher",
  'homeQuickHistory': "Historique",
  'homeQuickUpload': "Importer",
  'homeViewAll': "Voir tout",
  'homeTrendingNow': "Tendances du moment",
  'homeTrustTitle': "Pourquoi les équipes lui font confiance",
  'homeTrustSubtitle':
      "Encore simulé aujourd'hui, mais structuré comme un vrai produit prêt à être lancé.",
  'homeFutureTitle': "Repositories prêts pour l'avenir",
  'homeFutureSubtitle':
      "Des repositories mock interchangeables protègent le code UI des changements backend.",
  'homePreviewTitle': "Flux de traduction orienté aperçu",
  'homePreviewSubtitle':
      "Examinez les résultats avant export en vue originale, traduite ou bilingue.",
  'homeStatesTitle': "États soignés inclus",
  'homeStatesSubtitle':
      "Chargement, vide, relance, validation et scénarios mock hors ligne font partie de l'UX dès le premier jour.",
  'navHome': "Accueil",
  'navHistory': "Historique",
  'navSettings': "Réglages",
  'heroTitle': "Traduisez les sous-titres plus vite",
  'heroSubtitle':
      "Parcourez les catalogues de films et de séries, choisissez vos sources et exportez des traductions soignées en quelques minutes.",
  'heroBadge': "Workflow premium pour sous-titres",
  'heroHeadline':
      "Traduisez les sous-titres de films et de séries avec un flux de niveau studio.",
  'heroBody':
      "Choisissez entre un catalogue de titres consultable ou l'import direct d'un fichier, puis prévisualisez et exportez des sous-titres soignés en quelques minutes.",
  'heroSearchCta': "Rechercher film / série",
  'heroUploadCta': "Importer un sous-titre",
  'heroStatPathsTitle': "2 parcours",
  'heroStatPathsValue': "Recherche ou import",
  'heroStatLanguagesTitle': "10 langues",
  'heroStatLanguagesValue': "Prêtes pour l'aperçu",
  'heroStatMockTitle': "APIs mock",
  'heroStatMockValue': "Passerelle prête pour le backend",
  'settingsTitle': "Réglages",
  'settingsSubtitle': "Gérez vos préférences",
  'settingsProfileName': "Utilisateur SubFlix",
  'settingsProfileTier': "Membre premium",
  'settingsLanguageLabel': "Langue cible préférée",
  'settingsThemeLabel': "Apparence",
  'themeSystem': "Système",
  'themeDark': "Sombre",
  'themeLight': "Clair",
  'settingsPremiumTitle': "Emplacement premium",
  'settingsPremiumSubtitle':
      "Plus tard, nous pourrons connecter ici les abonnements, la facturation et la synchronisation cloud des projets.",
  'settingsNotificationsTitle': "Notifications",
  'settingsNotificationsSubtitle': "Gérez les préférences de notification",
  'settingsHelpCenterTitle': "Centre d'aide",
  'settingsContactTitle': "Nous contacter",
  'settingsSupportTitle': "Emplacement support",
  'settingsSupportSubtitle': "Page mock d'aide et de contact",
  'settingsPrivacyTitle': "Politique de confidentialité",
  'settingsPrivacySubtitle': "Contenu mock de confidentialité",
  'settingsTermsTitle': "Conditions d'utilisation",
  'settingsTermsSubtitle': "Contenu mock des conditions",
  'settingsMaintenanceTitle': "Maintenance",
  'settingsMaintenanceSubtitle':
      "Effacez les travaux de traduction gérés par le backend sur cet appareil et repartez avec un historique vide.",
  'settingsHistoryClearedSnack':
      "Historique des traductions effacé pour cet appareil",
  'settingsAboutTitle': "À propos de SubFlix",
  'settingsVersion': "Version {version}",
  'settingsClearCache': "Vider le cache",
  'settingsCacheCleared': "Cache vidé",
  'settingsFailedTitle': "Impossible de charger les réglages",
  'legalPlaceholderBody':
      "Cette page n'est qu'un emplacement dans l'application de démonstration. Reliez-la à votre contenu juridique de production.",
  'legalTitlePrivacy': "Politique de confidentialité",
  'legalTitleTerms': "Conditions d'utilisation",
  'legalTitleSupport': "Support",
  'legalTitleAbout': "À propos de SubFlix",
  'legalBodyPrivacy':
      "SubFlix stocke actuellement uniquement des préférences mock et l'historique des traductions sur l'appareil via une persistance locale. Une future intégration backend pourra remplacer cela par un stockage authentifié, des pistes d'audit et des politiques de rétention gérées côté serveur.",
  'legalBodyTerms':
      "Cette version mock sert à éprouver les flux produit, les états UI et les limites d'architecture. Lorsqu'un backend de production NestJS et Postgres sera connecté plus tard, la couche juridique pourra être enrichie avec de vraies conditions de service et un langage de traitement des données.",
  'legalBodySupport':
      "Le support n'est pour l'instant qu'un emplacement. En production, cette section pourra se connecter à l'e-mail, aux signalements de problème et à l'aide des comptes premium sans modifier la structure générale de l'application.",
  'legalBodyAbout':
      "SubFlix est un client Flutter au style premium dédié à la traduction IA de sous-titres. Cette version utilise des repositories mock, une latence artificielle et une persistance locale afin que l'UI et l'architecture puissent mûrir avant l'arrivée d'un vrai backend.",
  'routeMissingSubtitleSourcesTitle': "Sources de sous-titres",
  'routeMissingSubtitleSourcesMessage':
      "Nous n'avons pas pu déterminer pour quel titre charger les sources de sous-titres. Reprenez depuis la recherche.",
  'routeMissingSeriesSeasonsTitle': "Saisons de la série",
  'routeMissingSeriesSeasonsMessage':
      "Nous n'avons pas pu déterminer quelle série charger. Reprenez depuis la recherche.",
  'routeMissingSeasonEpisodesTitle': "Épisodes de la saison",
  'routeMissingSeasonEpisodesMessage':
      "Nous n'avons pas pu déterminer quelle saison charger. Reprenez depuis la recherche.",
  'routeMissingTranslationSetupTitle': "Configuration de la traduction",
  'routeMissingTranslationSetupMessage':
      "Une source de sous-titres est requise avant l'ouverture de l'écran de configuration de la traduction.",
  'routeMissingTranslationProgressTitle': "Progression de la traduction",
  'routeMissingTranslationProgressMessage':
      "Aucune demande de traduction n'a été fournie. Lancez une nouvelle traduction depuis la recherche ou l'import.",
  'searchResultPopularity': "Popularité {score}",
  'subtitleSourceLines': "{lineCount} lignes",
  'subtitleSourceDownloads': "{downloads} téléchargements",
  'subtitleSourceRating': "Note {rating}",
  'subtitleSourceHiLabel': "HI / SDH",
  'mediaTypeMovie': "Film",
  'mediaTypeSeries': "Série",
  'jobReuseTranslation': "Réutiliser la traduction",
  'jobReuseSubtitle': "Réutiliser le sous-titre",
  'jobConfidence': "Confiance : {level}",
  'jobOpenPreview': "Ouvrir l'aperçu",
  'onboardingPage1Title':
      "Trouvez des films ou des séries et récupérez des sous-titres prêts à traduire.",
  'onboardingPage1Eyebrow': "Chercher et récupérer",
  'onboardingPage1Description':
      "Recherchez un titre, consultez les sources de sous-titres anglais disponibles et lancez un parcours de traduction quasi instantané.",
  'onboardingPage1Highlight1':
      "Catalogue mock déterministe pour un développement fiable",
  'onboardingPage1Highlight2':
      "Libellés de qualité et badges de format pour les sources",
  'onboardingPage1Highlight3':
      "Pensé pour être raccordé à un vrai backend plus tard",
  'onboardingPage2Title':
      "Importez des fichiers `.srt` ou `.vtt` quand vous avez déjà le script.",
  'onboardingPage2Eyebrow': "Apportez votre propre fichier",
  'onboardingPage2Description':
      "Importez votre fichier de sous-titres, validez le format et lancez le même pipeline soigné sans quitter l'application.",
  'onboardingPage2Highlight1':
      "Validation locale des fichiers et états de relance élégants",
  'onboardingPage2Highlight2':
      "Configuration cohérente pour l'import et la recherche",
  'onboardingPage2Highlight3':
      "Aperçu avant export pour que rien ne paraisse opaque",
  'onboardingPage3Title':
      "Choisissez vos langues cibles, prévisualisez les sous-titres et exportez aussitôt.",
  'onboardingPage3Eyebrow': "Traduire et exporter",
  'onboardingPage3Description':
      "Passez de la vue originale à la vue traduite ou bilingue, revenez à l'historique et exportez des fichiers propres dès que le résultat vous convient.",
  'onboardingPage3Highlight1':
      "Contrôles d'aperçu rapides avec métadonnées et recherche",
  'onboardingPage3Highlight2':
      "L'historique garde les anciens travaux à portée de geste",
  'onboardingPage3Highlight3':
      "Conçu comme un outil média premium, pas comme une démo",
  'onboardingStart': "Démarrer la traduction",
  'onboardingNext': "Suivant",
  'onboardingSkip': "Passer",
  'onboardingContinue': "Continuer",
  'onboardingEnterApp': "Entrer dans SubFlix",
  'splashHeadline': "SubFlix",
  'splashSubtitle': "Traduction de sous-titres par IA",
  'splashPreparing': "Préparation de votre studio de sous-titres",
  'brandSubtitleCompact': "Intelligence des sous-titres",
  'brandSubtitleFull': "Studio IA de traduction de sous-titres",
  'comingSoonTitle': "Bientôt disponible",
  'comingSoonMessage': "Cet écran est encore en préparation.",
};
