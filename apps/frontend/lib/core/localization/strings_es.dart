const Map<String, String> kStringsEs = <String, String>{
  'appTitle': 'SubFlix',
  'searchTitles': 'Buscar títulos',
  'searchMovieOrSeriesTitle': 'Buscar película o serie',
  'searchMovieOrSeriesSubtitle':
      'Encuentra un título, revisa las fuentes de subtítulos y lanza una traducción con unos pocos toques.',
  'searchHintText': 'Busca Dune, Breaking Bad, Severance...',
  'searchMockTitle': 'Busca cualquier cosa en el catálogo de prueba',
  'searchMockMessage':
      'Prueba títulos como Inception, Dune, Breaking Bad, Severance o The Last of Us para explorar el flujo de fuentes de subtítulos.',
  'searchFailedTitle': 'La búsqueda falló',
  'noTitlesMatchedTitle': 'No hubo coincidencias',
  'noTitlesMatchedMessage':
      'No pudimos encontrar ese título en el catálogo de prueba. Prueba una búsqueda más amplia o uno de los títulos sugeridos.',
  'searchTrendingTitle': 'Búsquedas en tendencia',
  'searchLoadingLabel': 'Buscando...',
  'searchFoundResults': 'Se encontraron {count} resultados para \'{query}\'',
  'searchNoResultsFor': 'No se encontraron resultados para \'{query}\'',
  'searchTryDifferentKeywords': 'Prueba con otras palabras clave.',
  'retry': 'Reintentar',
  'retryTranslation': 'Reintentar traducción',
  'uploadSubtitleTitle': 'Subir subtítulo',
  'uploadIntroTitle': 'Usa tu propio archivo de subtítulos',
  'uploadIntroSubtitle':
      'Importa un archivo `.srt` o `.vtt` en inglés, deja que el backend lo valide y lo procese, y luego continúa con la configuración de la traducción.',
  'uploadChooseFile': 'Elegir archivo de subtítulos',
  'uploadSupportedFormatsTitle': 'Formatos compatibles',
  'uploadSupportedFormatsSubtitle':
      'Archivos de subtítulos en inglés `.srt` y `.vtt`',
  'uploadOpeningPicker': 'Abriendo selector...',
  'uploadChooseFileShort': 'Elegir archivo',
  'uploadPickSubtitle': 'Seleccionar archivo de subtítulos',
  'uploadPickedFile': 'Archivo de subtítulos seleccionado',
  'uploadUseDemoFile': 'Usar archivo de prueba',
  'uploadFailedTitle': 'La importación del archivo falló',
  'uploadFailedMessage':
      'No pudimos leer este archivo de subtítulos. Prueba con otro archivo o con una exportación más pequeña.',
  'uploadFailedFallback': 'Prueba con otro archivo de subtítulos.',
  'tryAgain': 'Intentar de nuevo',
  'uploadMetadataTitle': 'Detalles del subtítulo',
  'uploadReadyTitle': 'Listo para traducir',
  'uploadLineCount': '{lineCount} líneas',
  'uploadEnglishSource': 'Origen en inglés',
  'uploadContinueSetup': 'Continuar con la configuración',
  'translateSetupTitle': 'Configuración de traducción',
  'translateSetupSubtitle':
      'Elige el idioma de destino, revisa la fuente del subtítulo y luego inicia la traducción en el backend.',
  'translateSetupSourceTitle': 'Subtítulo de origen',
  'translateSetupLanguageTitle': 'Traducir a',
  'translateSetupOptionsTitle': 'Opciones',
  'translateSetupSelectLanguage': 'Seleccionar idioma',
  'translateSetupReadyTitle': 'Traducción con IA lista',
  'translateSetupReadyBody':
      'Nuestro flujo adaptará este subtítulo al idioma {language} con el tiempo preservado y una estructura limpia de cues.',
  'translateSetupPreserveTiming': 'Conservar tiempos',
  'translateSetupPreserveTimingBody':
      'Mantén los tiempos originales del subtítulo alineados con el archivo de origen.',
  'translateSetupAutoDetect': 'Detectar formato automáticamente',
  'translateSetupAutoDetectBody':
      'Elige automáticamente la estructura de salida adecuada para subtítulos.',
  'subtitleSourceFormatLabel': 'Fuente de subtítulos {format}',
  'targetLanguage': 'Idioma de destino',
  'startTranslation': 'Iniciar traducción',
  'translationProgressTitle': 'Progreso de la traducción',
  'translationProgressHeadline':
      'La traducción de subtítulos con IA está en curso',
  'translationFailedTitle': 'No se pudo completar la traducción',
  'translationFailedMessage': 'Algo salió mal.',
  'translationStageQueued': 'En cola para traducir',
  'translationStageIdle': 'Esperando una solicitud de traducción',
  'translationStagePreparing': 'Preparando el paquete de subtítulos',
  'translationStageAligning': 'Alineando marcas de tiempo y contexto de escena',
  'translationStageGenerating': 'Generando la traducción de subtítulos',
  'translationStageReadability': 'Aplicando una revisión de legibilidad',
  'translationStageReady': 'Traducción lista',
  'translationResultCompleteTitle': 'Traducción completa',
  'translationResultCompleteSubtitle':
      'Tu subtítulo está listo para previsualizar o descargar.',
  'translationResultDetailsTitle': 'Detalles de la traducción',
  'translationResultMediaLabel': 'Título del contenido',
  'translationResultSourceLabel': 'Idioma de origen',
  'translationResultTargetLabel': 'Idioma de destino',
  'translationResultMethodAi': 'Traducido con IA',
  'translationResultMetricsTitle': 'Métricas de calidad',
  'translationResultConfidenceLabel': 'Confianza de traducción',
  'translationResultTimingLabel': 'Precisión del tiempo',
  'translationResultTimingPreserved': 'Tiempo preservado',
  'translationResultProcessedIn': 'Procesado en {duration}',
  'translationResultWarning':
      'Algunos términos técnicos aún pueden beneficiarse de una revisión humana rápida para asegurar el contexto.',
  'translationResultPreviewCta': 'Previsualizar subtítulo',
  'translationResultDownloadCta': 'Descargar subtítulo',
  'translationResultHomeCta': 'Volver al inicio',
  'translationPreviewTitle': 'Vista previa de la traducción',
  'translationPreviewHeader': 'Revisa los subtítulos traducidos',
  'translationPreviewSubtitle':
      'Busca dentro de los cues, cambia el modo de vista previa y exporta cuando la traducción se vea bien.',
  'translationPreviewSearchHint': 'Buscar líneas de subtítulos',
  'previewModeOriginal': 'Original',
  'previewModeTranslated': 'Traducido',
  'previewModeBilingual': 'Bilingüe',
  'previewNotReadyTitle': 'Los cues de vista previa aún no están disponibles',
  'previewNotReadyMessage':
      'La traducción terminó, pero el backend todavía no devolvió los cues de vista previa. Vuelve a cargar esta pantalla en un momento.',
  'previewNoMatchesTitle': 'No hubo coincidencias en las líneas',
  'previewNoMatchesMessage':
      'Prueba con otro término de búsqueda o limpia el filtro para revisar la traducción completa.',
  'previewFailedTitle': 'No se pudo cargar la vista previa',
  'exportingLabel': 'Exportando...',
  'exportSubtitleLabel': 'Exportar subtítulo traducido',
  'exportedSnack': 'Se exportó {fileName} a {path}',
  'exportFailedSnack': 'La exportación falló: {error}',
  'metadataFormat': 'Formato',
  'metadataLines': 'Líneas',
  'metadataLanguages': 'Idiomas',
  'metadataEstimatedDuration': 'Duración estimada',
  'subtitleSourcesTitle': 'Fuentes de subtítulos en inglés',
  'subtitleSourcesSubtitle':
      'Elige una fuente de subtítulos para {title}{target} y luego selecciona el idioma de destino en el siguiente paso.',
  'subtitleSourcesBannerTitle': 'Traducción con IA disponible',
  'subtitleSourcesBannerMessage':
      'Selecciona una fuente de subtítulos y continúa con una configuración pulida, ajustada al tiempo de los subtítulos.',
  'subtitleSourcesFailedTitle':
      'No se pudieron cargar las fuentes de subtítulos',
  'seriesSeasonsTitle': 'Elige una temporada',
  'seriesSeasonsSubtitle':
      'Elige una temporada de {title} para ver los episodios disponibles.',
  'seriesSeasonLabel': 'Temporada {seasonNumber}',
  'seriesSeasonMeta': '{episodeCount} episodios{year}',
  'seriesEpisodesTitle': 'Temporada {seasonNumber}',
  'seriesEpisodesSubtitle': '{episodeCount} episodios{year}',
  'seriesEpisodeLabel': 'Episodio {episodeNumber}',
  'seriesEpisodeMeta': 'Aprox. {runtime} min',
  'historyTitle': 'Historial de traducciones',
  'historySubtitle':
      'Vuelve a abrir trabajos anteriores, revisa la vista previa otra vez o expórtalos más tarde.',
  'historyEmptyTitle': 'El historial está vacío',
  'historyEmptyMessage':
      'Tus trabajos de subtítulos traducidos aparecerán aquí después de completar un flujo de búsqueda o carga.',
  'historyFailedTitle': 'No se pudo cargar el historial',
  'historyCountLabel': '{count} traducciones',
  'historyFilterAll': 'Todo',
  'historyFilterMovies': 'Películas',
  'historyFilterSeries': 'Series',
  'historyFilterCompleted': 'Completado',
  'historyFilterAiTranslated': 'Traducido con IA',
  'historyFilterFailed': 'Fallido',
  'historyFilterReused': 'Reutilizado',
  'historyFailedItemMessage':
      'La traducción falló. Toca para comenzar de nuevo.',
  'homeRecentJobsTitle': 'Trabajos recientes',
  'homeRecentJobsSubtitle':
      'Vuelve a abrir tus sesiones recientes sin empezar desde cero.',
  'homeNoRecentTitle': 'Aún no hay trabajos recientes',
  'homeNoRecentMessage':
      'Empieza con una búsqueda de película o sube un archivo de subtítulos y tus traducciones recientes aparecerán aquí.',
  'homeFailedRecentTitle': 'No se pudieron cargar los trabajos recientes',
  'homeWelcomeTitle': 'Bienvenido de nuevo',
  'homeWelcomeSubtitle': 'Encuentra y traduce subtítulos',
  'homeSearchPlaceholder': 'Buscar películas o series...',
  'homeQuickSearch': 'Buscar',
  'homeQuickHistory': 'Historial',
  'homeQuickUpload': 'Subir',
  'homeViewAll': 'Ver todo',
  'homeTrendingNow': 'Tendencias',
  'homeTrustTitle': 'Por qué los equipos confían en esto',
  'homeTrustSubtitle':
      'Hoy es una maqueta, pero está estructurado como un producto real listo para salir.',
  'homeFutureTitle': 'Repositorios preparados para el futuro',
  'homeFutureSubtitle':
      'Los repositorios mock intercambiables mantienen el código de UI aislado de los cambios del backend.',
  'homePreviewTitle': 'Flujo de traducción centrado en la vista previa',
  'homePreviewSubtitle':
      'Revisa los resultados antes de exportar con vistas original, traducida o bilingüe.',
  'homeStatesTitle': 'Estados bien resueltos incluidos',
  'homeStatesSubtitle':
      'Carga, vacío, reintento, validación y escenarios mock sin conexión forman parte de la UX desde el primer día.',
  'navHome': 'Inicio',
  'navHistory': 'Historial',
  'navSettings': 'Ajustes',
  'heroTitle': 'Traduce subtítulos más rápido',
  'heroSubtitle':
      'Busca en catálogos de películas y series, elige fuentes y exporta traducciones pulidas en minutos.',
  'heroBadge': 'Flujo premium de subtítulos',
  'heroHeadline':
      'Traduce subtítulos de películas y series con un flujo de nivel estudio.',
  'heroBody':
      'Elige entre un catálogo de títulos con búsqueda o la carga directa de archivos, y luego previsualiza y exporta subtítulos pulidos en minutos.',
  'heroSearchCta': 'Buscar película / serie',
  'heroUploadCta': 'Subir subtítulo',
  'heroStatPathsTitle': '2 caminos',
  'heroStatPathsValue': 'Buscar o subir',
  'heroStatLanguagesTitle': '10 idiomas',
  'heroStatLanguagesValue': 'Listos para vista previa',
  'heroStatMockTitle': 'APIs mock',
  'heroStatMockValue': 'Base lista para backend',
  'settingsTitle': 'Ajustes',
  'settingsSubtitle': 'Administra tus preferencias',
  'settingsProfileName': 'Usuario de SubFlix',
  'settingsProfileTier': 'Miembro premium',
  'settingsLanguageLabel': 'Idioma de destino preferido',
  'settingsThemeLabel': 'Apariencia',
  'themeSystem': 'Sistema',
  'themeDark': 'Oscuro',
  'themeLight': 'Claro',
  'settingsPremiumTitle': 'Marcador de premium',
  'settingsPremiumSubtitle':
      'Más adelante podremos conectar aquí suscripciones, facturación y sincronización de proyectos en la nube.',
  'settingsNotificationsTitle': 'Notificaciones',
  'settingsNotificationsSubtitle':
      'Administra las preferencias de notificaciones',
  'settingsHelpCenterTitle': 'Centro de ayuda',
  'settingsContactTitle': 'Contáctanos',
  'settingsSupportTitle': 'Marcador de soporte',
  'settingsSupportSubtitle': 'Página mock de ayuda y contacto',
  'settingsPrivacyTitle': 'Política de privacidad',
  'settingsPrivacySubtitle': 'Contenido mock de privacidad',
  'settingsTermsTitle': 'Términos del servicio',
  'settingsTermsSubtitle': 'Contenido mock de términos',
  'settingsMaintenanceTitle': 'Mantenimiento',
  'settingsMaintenanceSubtitle':
      'Borra los trabajos de traducción gestionados por el backend en este dispositivo y empieza con un historial vacío.',
  'settingsHistoryClearedSnack':
      'Historial de traducciones borrado en este dispositivo',
  'settingsAboutTitle': 'Acerca de SubFlix',
  'settingsVersion': 'Versión {version}',
  'settingsClearCache': 'Borrar caché',
  'settingsCacheCleared': 'Caché borrada',
  'settingsFailedTitle': 'No se pudieron cargar los ajustes',
  'legalPlaceholderBody':
      'Esta página es un marcador dentro de la app de demostración. Conéctala con tu contenido legal real para producción.',
  'legalTitlePrivacy': 'Política de privacidad',
  'legalTitleTerms': 'Términos del servicio',
  'legalTitleSupport': 'Soporte',
  'legalTitleAbout': 'Acerca de SubFlix',
  'legalBodyPrivacy':
      'SubFlix actualmente solo guarda preferencias mock e historial de traducciones en el dispositivo mediante persistencia local. Una futura integración con backend puede sustituir esto por almacenamiento autenticado, trazas de auditoría y políticas de retención gestionadas por el servidor.',
  'legalBodyTerms':
      'Esta versión mock está pensada para poner a prueba los flujos del producto, los estados de la UI y los límites de la arquitectura. Cuando más adelante se conecte un backend de producción con NestJS y Postgres, la capa legal podrá ampliarse con términos reales del servicio y lenguaje de tratamiento de datos.',
  'legalBodySupport':
      'El soporte es por ahora un marcador. En una versión de producción, esta sección podría conectarse al correo, los reportes de incidencias y la ayuda para cuentas premium sin cambiar la estructura general de la app.',
  'legalBodyAbout':
      'SubFlix es un cliente Flutter de estilo premium para traducción de subtítulos con IA. Esta compilación usa repositorios mock, latencia artificial y persistencia local para que la UI y la arquitectura evolucionen antes de conectar un backend real.',
  'routeMissingSubtitleSourcesTitle': 'Fuentes de subtítulos',
  'routeMissingSubtitleSourcesMessage':
      'No pudimos determinar qué título debía cargar las fuentes de subtítulos. Empieza de nuevo desde la búsqueda.',
  'routeMissingSeriesSeasonsTitle': 'Temporadas de la serie',
  'routeMissingSeriesSeasonsMessage':
      'No pudimos determinar qué serie debía cargarse. Empieza de nuevo desde la búsqueda.',
  'routeMissingSeasonEpisodesTitle': 'Episodios de la temporada',
  'routeMissingSeasonEpisodesMessage':
      'No pudimos determinar qué temporada debía cargarse. Empieza de nuevo desde la búsqueda.',
  'routeMissingTranslationSetupTitle': 'Configuración de traducción',
  'routeMissingTranslationSetupMessage':
      'Se requiere una fuente de subtítulos antes de abrir la pantalla de configuración.',
  'routeMissingTranslationProgressTitle': 'Progreso de la traducción',
  'routeMissingTranslationProgressMessage':
      'No se proporcionó ninguna solicitud de traducción. Inicia una nueva traducción desde búsqueda o carga.',
  'searchResultPopularity': 'Popularidad {score}',
  'subtitleSourceLines': '{lineCount} líneas',
  'subtitleSourceDownloads': '{downloads} descargas',
  'subtitleSourceRating': 'Calificación {rating}',
  'subtitleSourceHiLabel': 'HI / SDH',
  'mediaTypeMovie': 'Película',
  'mediaTypeSeries': 'Serie',
  'jobReuseTranslation': 'Reutilizar traducción',
  'jobReuseSubtitle': 'Reutilizar subtítulo',
  'jobConfidence': 'Confianza: {level}',
  'jobOpenPreview': 'Abrir vista previa',
  'onboardingPage1Title':
      'Encuentra películas o series y trae subtítulos listos para traducir.',
  'onboardingPage1Eyebrow': 'Buscar y obtener',
  'onboardingPage1Description':
      'Busca un título, revisa las fuentes de subtítulos en inglés disponibles y lanza un flujo de traducción que se siente inmediato.',
  'onboardingPage1Highlight1':
      'Catálogo mock determinista para un desarrollo fiable',
  'onboardingPage1Highlight2': 'Etiquetas de calidad y distintivos de formato',
  'onboardingPage1Highlight3':
      'Pensado para cambiarse a un backend real más adelante',
  'onboardingPage2Title':
      'Sube archivos `.srt` o `.vtt` cuando ya tengas el guion.',
  'onboardingPage2Eyebrow': 'Usa tu propio archivo',
  'onboardingPage2Description':
      'Importa tu archivo de subtítulos, valida el formato y ejecuta la misma canalización pulida sin salir de la app.',
  'onboardingPage2Highlight1':
      'Validación local de archivos y estados de reintento bien resueltos',
  'onboardingPage2Highlight2':
      'Configuración coherente para cargas y búsquedas',
  'onboardingPage2Highlight3':
      'Vista previa antes de exportar para que nada se sienta opaco',
  'onboardingPage3Title':
      'Elige idiomas de destino, previsualiza subtítulos y exporta al instante.',
  'onboardingPage3Eyebrow': 'Traducir y exportar',
  'onboardingPage3Description':
      'Cambia entre vista original, traducida y bilingüe, vuelve al historial y exporta archivos limpios cuando el resultado se vea correcto.',
  'onboardingPage3Highlight1':
      'Controles rápidos de vista previa con metadatos y búsqueda',
  'onboardingPage3Highlight2':
      'El historial mantiene los trabajos anteriores a un toque de distancia',
  'onboardingPage3Highlight3':
      'Diseñado como una herramienta premium de medios, no como una demo',
  'onboardingStart': 'Iniciar traducción',
  'onboardingNext': 'Siguiente',
  'onboardingSkip': 'Omitir',
  'onboardingContinue': 'Continuar',
  'onboardingEnterApp': 'Entrar en SubFlix',
  'splashHeadline': 'SubFlix',
  'splashSubtitle': 'Traducción de subtítulos con IA',
  'splashPreparing': 'Preparando tu estudio de subtítulos',
  'brandSubtitleCompact': 'Inteligencia de subtítulos',
  'brandSubtitleFull': 'Estudio de traducción de subtítulos con IA',
  'comingSoonTitle': 'Próximamente',
  'comingSoonMessage': 'Todavía estamos preparando esta pantalla.',
};
