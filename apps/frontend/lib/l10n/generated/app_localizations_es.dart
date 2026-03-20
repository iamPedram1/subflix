// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get brandSubtitleCompact => 'Inteligencia de subtítulos';

  @override
  String get brandSubtitleFull => 'Estudio de traducción de subtítulos con IA';

  @override
  String get comingSoonMessage => 'Todavía estamos preparando esta pantalla.';

  @override
  String get comingSoonTitle => 'Próximamente';

  @override
  String exportFailedSnack(Object error) {
    return 'La exportación falló: $error';
  }

  @override
  String get exportSubtitleLabel => 'Exportar subtítulo traducido';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'Se exportó $fileName a $path';
  }

  @override
  String get exportingLabel => 'Exportando...';

  @override
  String get heroBadge => 'Flujo premium de subtítulos';

  @override
  String get heroBody =>
      'Elige entre un catálogo de títulos con búsqueda o la carga directa de archivos, y luego previsualiza y exporta subtítulos pulidos en minutos.';

  @override
  String get heroHeadline =>
      'Traduce subtítulos de películas y series con un flujo de nivel estudio.';

  @override
  String get heroSearchCta => 'Buscar película / serie';

  @override
  String get heroStatLanguagesTitle => '10 idiomas';

  @override
  String get heroStatLanguagesValue => 'Listos para vista previa';

  @override
  String get heroStatMockTitle => 'APIs mock';

  @override
  String get heroStatMockValue => 'Base lista para backend';

  @override
  String get heroStatPathsTitle => '2 caminos';

  @override
  String get heroStatPathsValue => 'Buscar o subir';

  @override
  String get heroSubtitle =>
      'Busca en catálogos de películas y series, elige fuentes y exporta traducciones pulidas en minutos.';

  @override
  String get heroTitle => 'Traduce subtítulos más rápido';

  @override
  String get heroUploadCta => 'Subir subtítulo';

  @override
  String historyCountLabel(Object count) {
    return '$count traducciones';
  }

  @override
  String get historyEmptyMessage =>
      'Tus trabajos de subtítulos traducidos aparecerán aquí después de completar un flujo de búsqueda o carga.';

  @override
  String get historyEmptyTitle => 'El historial está vacío';

  @override
  String get historyFailedItemMessage =>
      'La traducción falló. Toca para comenzar de nuevo.';

  @override
  String get historyFailedTitle => 'No se pudo cargar el historial';

  @override
  String get historyFilterAiTranslated => 'Traducido con IA';

  @override
  String get historyFilterAll => 'Todo';

  @override
  String get historyFilterCompleted => 'Completado';

  @override
  String get historyFilterFailed => 'Fallido';

  @override
  String get historyFilterMovies => 'Películas';

  @override
  String get historyFilterReused => 'Reutilizado';

  @override
  String get historyFilterSeries => 'Series';

  @override
  String get historySubtitle =>
      'Vuelve a abrir trabajos anteriores, revisa la vista previa otra vez o expórtalos más tarde.';

  @override
  String get historyTitle => 'Historial de traducciones';

  @override
  String get homeFailedRecentTitle =>
      'No se pudieron cargar los trabajos recientes';

  @override
  String get homeFutureSubtitle =>
      'Los repositorios mock intercambiables mantienen el código de UI aislado de los cambios del backend.';

  @override
  String get homeFutureTitle => 'Repositorios preparados para el futuro';

  @override
  String get homeNoRecentMessage =>
      'Empieza con una búsqueda de película o sube un archivo de subtítulos y tus traducciones recientes aparecerán aquí.';

  @override
  String get homeNoRecentTitle => 'Aún no hay trabajos recientes';

  @override
  String get homePreviewSubtitle =>
      'Revisa los resultados antes de exportar con vistas original, traducida o bilingüe.';

  @override
  String get homePreviewTitle =>
      'Flujo de traducción centrado en la vista previa';

  @override
  String get homeQuickHistory => 'Historial';

  @override
  String get homeQuickSearch => 'Buscar';

  @override
  String get homeQuickUpload => 'Subir';

  @override
  String get homeRecentJobsSubtitle =>
      'Vuelve a abrir tus sesiones recientes sin empezar desde cero.';

  @override
  String get homeRecentJobsTitle => 'Trabajos recientes';

  @override
  String get homeSearchPlaceholder => 'Buscar películas o series...';

  @override
  String get homeStatesSubtitle =>
      'Carga, vacío, reintento, validación y escenarios mock sin conexión forman parte de la UX desde el primer día.';

  @override
  String get homeStatesTitle => 'Estados bien resueltos incluidos';

  @override
  String get homeTrendingNow => 'Tendencias';

  @override
  String get homeTrustSubtitle =>
      'Hoy es una maqueta, pero está estructurado como un producto real listo para salir.';

  @override
  String get homeTrustTitle => 'Por qué los equipos confían en esto';

  @override
  String get homeViewAll => 'Ver todo';

  @override
  String get homeWelcomeSubtitle => 'Encuentra y traduce subtítulos';

  @override
  String get homeWelcomeTitle => 'Bienvenido de nuevo';

  @override
  String jobConfidence(Object level) {
    return 'Confianza: $level';
  }

  @override
  String get jobOpenPreview => 'Abrir vista previa';

  @override
  String get jobReuseSubtitle => 'Reutilizar subtítulo';

  @override
  String get jobReuseTranslation => 'Reutilizar traducción';

  @override
  String get legalBodyAbout =>
      'SubFlix es un cliente Flutter de estilo premium para traducción de subtítulos con IA. Esta compilación usa repositorios mock, latencia artificial y persistencia local para que la UI y la arquitectura evolucionen antes de conectar un backend real.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix actualmente solo guarda preferencias mock e historial de traducciones en el dispositivo mediante persistencia local. Una futura integración con backend puede sustituir esto por almacenamiento autenticado, trazas de auditoría y políticas de retención gestionadas por el servidor.';

  @override
  String get legalBodySupport =>
      'El soporte es por ahora un marcador. En una versión de producción, esta sección podría conectarse al correo, los reportes de incidencias y la ayuda para cuentas premium sin cambiar la estructura general de la app.';

  @override
  String get legalBodyTerms =>
      'Esta versión mock está pensada para poner a prueba los flujos del producto, los estados de la UI y los límites de la arquitectura. Cuando más adelante se conecte un backend de producción con NestJS y Postgres, la capa legal podrá ampliarse con términos reales del servicio y lenguaje de tratamiento de datos.';

  @override
  String get legalPlaceholderBody =>
      'Esta página es un marcador dentro de la app de demostración. Conéctala con tu contenido legal real para producción.';

  @override
  String get legalTitleAbout => 'Acerca de SubFlix';

  @override
  String get legalTitlePrivacy => 'Política de privacidad';

  @override
  String get legalTitleSupport => 'Soporte';

  @override
  String get legalTitleTerms => 'Términos del servicio';

  @override
  String get mediaTypeMovie => 'Película';

  @override
  String get mediaTypeSeries => 'Serie';

  @override
  String get metadataEstimatedDuration => 'Duración estimada';

  @override
  String get metadataFormat => 'Formato';

  @override
  String get metadataLanguages => 'Idiomas';

  @override
  String get metadataLines => 'Líneas';

  @override
  String get navHistory => 'Historial';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get noTitlesMatchedMessage =>
      'No pudimos encontrar ese título en el catálogo de prueba. Prueba una búsqueda más amplia o uno de los títulos sugeridos.';

  @override
  String get noTitlesMatchedTitle => 'No hubo coincidencias';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingEnterApp => 'Entrar en SubFlix';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingPage1Description =>
      'Busca un título, revisa las fuentes de subtítulos en inglés disponibles y lanza un flujo de traducción que se siente inmediato.';

  @override
  String get onboardingPage1Eyebrow => 'Buscar y obtener';

  @override
  String get onboardingPage1Highlight1 =>
      'Catálogo mock determinista para un desarrollo fiable';

  @override
  String get onboardingPage1Highlight2 =>
      'Etiquetas de calidad y distintivos de formato';

  @override
  String get onboardingPage1Highlight3 =>
      'Pensado para cambiarse a un backend real más adelante';

  @override
  String get onboardingPage1Title =>
      'Encuentra películas o series y trae subtítulos listos para traducir.';

  @override
  String get onboardingPage2Description =>
      'Importa tu archivo de subtítulos, valida el formato y ejecuta la misma canalización pulida sin salir de la app.';

  @override
  String get onboardingPage2Eyebrow => 'Usa tu propio archivo';

  @override
  String get onboardingPage2Highlight1 =>
      'Validación local de archivos y estados de reintento bien resueltos';

  @override
  String get onboardingPage2Highlight2 =>
      'Configuración coherente para cargas y búsquedas';

  @override
  String get onboardingPage2Highlight3 =>
      'Vista previa antes de exportar para que nada se sienta opaco';

  @override
  String get onboardingPage2Title =>
      'Sube archivos `.srt` o `.vtt` cuando ya tengas el guion.';

  @override
  String get onboardingPage3Description =>
      'Cambia entre vista original, traducida y bilingüe, vuelve al historial y exporta archivos limpios cuando el resultado se vea correcto.';

  @override
  String get onboardingPage3Eyebrow => 'Traducir y exportar';

  @override
  String get onboardingPage3Highlight1 =>
      'Controles rápidos de vista previa con metadatos y búsqueda';

  @override
  String get onboardingPage3Highlight2 =>
      'El historial mantiene los trabajos anteriores a un toque de distancia';

  @override
  String get onboardingPage3Highlight3 =>
      'Diseñado como una herramienta premium de medios, no como una demo';

  @override
  String get onboardingPage3Title =>
      'Elige idiomas de destino, previsualiza subtítulos y exporta al instante.';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingStart => 'Iniciar traducción';

  @override
  String get previewFailedTitle => 'No se pudo cargar la vista previa';

  @override
  String get previewModeBilingual => 'Bilingüe';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Traducido';

  @override
  String get previewNoMatchesMessage =>
      'Prueba con otro término de búsqueda o limpia el filtro para revisar la traducción completa.';

  @override
  String get previewNoMatchesTitle => 'No hubo coincidencias en las líneas';

  @override
  String get previewNotReadyMessage =>
      'La traducción terminó, pero el backend todavía no devolvió los cues de vista previa. Vuelve a cargar esta pantalla en un momento.';

  @override
  String get previewNotReadyTitle =>
      'Los cues de vista previa aún no están disponibles';

  @override
  String get retry => 'Reintentar';

  @override
  String get retryTranslation => 'Reintentar traducción';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'No pudimos determinar qué temporada debía cargarse. Empieza de nuevo desde la búsqueda.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Episodios de la temporada';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'No pudimos determinar qué serie debía cargarse. Empieza de nuevo desde la búsqueda.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Temporadas de la serie';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'No pudimos determinar qué título debía cargar las fuentes de subtítulos. Empieza de nuevo desde la búsqueda.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Fuentes de subtítulos';

  @override
  String get routeMissingTranslationProgressMessage =>
      'No se proporcionó ninguna solicitud de traducción. Inicia una nueva traducción desde búsqueda o carga.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'Progreso de la traducción';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Se requiere una fuente de subtítulos antes de abrir la pantalla de configuración.';

  @override
  String get routeMissingTranslationSetupTitle => 'Configuración de traducción';

  @override
  String get searchFailedTitle => 'La búsqueda falló';

  @override
  String searchFoundResults(Object count, Object query) {
    return 'Se encontraron $count resultados para \'\'$query\'\'';
  }

  @override
  String get searchHintText => 'Busca Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Buscando...';

  @override
  String get searchMockMessage =>
      'Prueba títulos como Inception, Dune, Breaking Bad, Severance o The Last of Us para explorar el flujo de fuentes de subtítulos.';

  @override
  String get searchMockTitle => 'Busca cualquier cosa en el catálogo de prueba';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Encuentra un título, revisa las fuentes de subtítulos y lanza una traducción con unos pocos toques.';

  @override
  String get searchMovieOrSeriesTitle => 'Buscar película o serie';

  @override
  String searchNoResultsFor(Object query) {
    return 'No se encontraron resultados para \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularidad $score';
  }

  @override
  String get searchTitles => 'Buscar títulos';

  @override
  String get searchTrendingTitle => 'Búsquedas en tendencia';

  @override
  String get searchTryDifferentKeywords => 'Prueba con otras palabras clave.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Episodio $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Aprox. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount episodios$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Temporada $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Temporada $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount episodios$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Elige una temporada de $title para ver los episodios disponibles.';
  }

  @override
  String get seriesSeasonsTitle => 'Elige una temporada';

  @override
  String get settingsAboutTitle => 'Acerca de SubFlix';

  @override
  String get settingsCacheCleared => 'Caché borrada';

  @override
  String get settingsClearCache => 'Borrar caché';

  @override
  String get settingsContactTitle => 'Contáctanos';

  @override
  String get settingsFailedTitle => 'No se pudieron cargar los ajustes';

  @override
  String get settingsHelpCenterTitle => 'Centro de ayuda';

  @override
  String get settingsHistoryClearedSnack =>
      'Historial de traducciones borrado en este dispositivo';

  @override
  String get settingsLanguageLabel => 'Idioma de destino preferido';

  @override
  String get settingsMaintenanceSubtitle =>
      'Borra los trabajos de traducción gestionados por el backend en este dispositivo y empieza con un historial vacío.';

  @override
  String get settingsMaintenanceTitle => 'Mantenimiento';

  @override
  String get settingsNotificationsSubtitle =>
      'Administra las preferencias de notificaciones';

  @override
  String get settingsNotificationsTitle => 'Notificaciones';

  @override
  String get settingsPremiumSubtitle =>
      'Más adelante podremos conectar aquí suscripciones, facturación y sincronización de proyectos en la nube.';

  @override
  String get settingsPremiumTitle => 'Marcador de premium';

  @override
  String get settingsPrivacySubtitle => 'Contenido mock de privacidad';

  @override
  String get settingsPrivacyTitle => 'Política de privacidad';

  @override
  String get settingsProfileName => 'Usuario de SubFlix';

  @override
  String get settingsProfileTier => 'Miembro premium';

  @override
  String get settingsSubtitle => 'Administra tus preferencias';

  @override
  String get settingsSupportSubtitle => 'Página mock de ayuda y contacto';

  @override
  String get settingsSupportTitle => 'Marcador de soporte';

  @override
  String get settingsTermsSubtitle => 'Contenido mock de términos';

  @override
  String get settingsTermsTitle => 'Términos del servicio';

  @override
  String get settingsThemeLabel => 'Apariencia';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String settingsVersion(Object version) {
    return 'Versión $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Preparando tu estudio de subtítulos';

  @override
  String get splashSubtitle => 'Traducción de subtítulos con IA';

  @override
  String get startTranslation => 'Iniciar traducción';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads descargas';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Fuente de subtítulos $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount líneas';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'Calificación $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Selecciona una fuente de subtítulos y continúa con una configuración pulida, ajustada al tiempo de los subtítulos.';

  @override
  String get subtitleSourcesBannerTitle => 'Traducción con IA disponible';

  @override
  String get subtitleSourcesFailedTitle =>
      'No se pudieron cargar las fuentes de subtítulos';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Elige una fuente de subtítulos para $title$target y luego selecciona el idioma de destino en el siguiente paso.';
  }

  @override
  String get subtitleSourcesTitle => 'Fuentes de subtítulos en inglés';

  @override
  String get targetLanguage => 'Idioma de destino';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get translateSetupAutoDetect => 'Detectar formato automáticamente';

  @override
  String get translateSetupAutoDetectBody =>
      'Elige automáticamente la estructura de salida adecuada para subtítulos.';

  @override
  String get translateSetupLanguageTitle => 'Traducir a';

  @override
  String get translateSetupOptionsTitle => 'Opciones';

  @override
  String get translateSetupPreserveTiming => 'Conservar tiempos';

  @override
  String get translateSetupPreserveTimingBody =>
      'Mantén los tiempos originales del subtítulo alineados con el archivo de origen.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Nuestro flujo adaptará este subtítulo al idioma $language con el tiempo preservado y una estructura limpia de cues.';
  }

  @override
  String get translateSetupReadyTitle => 'Traducción con IA lista';

  @override
  String get translateSetupSelectLanguage => 'Seleccionar idioma';

  @override
  String get translateSetupSourceTitle => 'Subtítulo de origen';

  @override
  String get translateSetupSubtitle =>
      'Elige el idioma de destino, revisa la fuente del subtítulo y luego inicia la traducción en el backend.';

  @override
  String get translateSetupTitle => 'Configuración de traducción';

  @override
  String get translationFailedMessage => 'Algo salió mal.';

  @override
  String get translationFailedTitle => 'No se pudo completar la traducción';

  @override
  String get translationPreviewHeader => 'Revisa los subtítulos traducidos';

  @override
  String get translationPreviewSearchHint => 'Buscar líneas de subtítulos';

  @override
  String get translationPreviewSubtitle =>
      'Busca dentro de los cues, cambia el modo de vista previa y exporta cuando la traducción se vea bien.';

  @override
  String get translationPreviewTitle => 'Vista previa de la traducción';

  @override
  String get translationProgressHeadline =>
      'La traducción de subtítulos con IA está en curso';

  @override
  String get translationProgressTitle => 'Progreso de la traducción';

  @override
  String get translationResultCompleteSubtitle =>
      'Tu subtítulo está listo para previsualizar o descargar.';

  @override
  String get translationResultCompleteTitle => 'Traducción completa';

  @override
  String get translationResultConfidenceLabel => 'Confianza de traducción';

  @override
  String get translationResultDetailsTitle => 'Detalles de la traducción';

  @override
  String get translationResultDownloadCta => 'Descargar subtítulo';

  @override
  String get translationResultHomeCta => 'Volver al inicio';

  @override
  String get translationResultMediaLabel => 'Título del contenido';

  @override
  String get translationResultMethodAi => 'Traducido con IA';

  @override
  String get translationResultMetricsTitle => 'Métricas de calidad';

  @override
  String get translationResultPreviewCta => 'Previsualizar subtítulo';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Procesado en $duration';
  }

  @override
  String get translationResultSourceLabel => 'Idioma de origen';

  @override
  String get translationResultTargetLabel => 'Idioma de destino';

  @override
  String get translationResultTimingLabel => 'Precisión del tiempo';

  @override
  String get translationResultTimingPreserved => 'Tiempo preservado';

  @override
  String get translationResultWarning =>
      'Algunos términos técnicos aún pueden beneficiarse de una revisión humana rápida para asegurar el contexto.';

  @override
  String get translationStageAligning =>
      'Alineando marcas de tiempo y contexto de escena';

  @override
  String get translationStageGenerating =>
      'Generando la traducción de subtítulos';

  @override
  String get translationStageIdle => 'Esperando una solicitud de traducción';

  @override
  String get translationStagePreparing => 'Preparando el paquete de subtítulos';

  @override
  String get translationStageQueued => 'En cola para traducir';

  @override
  String get translationStageReadability =>
      'Aplicando una revisión de legibilidad';

  @override
  String get translationStageReady => 'Traducción lista';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get uploadChooseFile => 'Elegir archivo de subtítulos';

  @override
  String get uploadChooseFileShort => 'Elegir archivo';

  @override
  String get uploadContinueSetup => 'Continuar con la configuración';

  @override
  String get uploadEnglishSource => 'Origen en inglés';

  @override
  String get uploadFailedFallback => 'Prueba con otro archivo de subtítulos.';

  @override
  String get uploadFailedMessage =>
      'No pudimos leer este archivo de subtítulos. Prueba con otro archivo o con una exportación más pequeña.';

  @override
  String get uploadFailedTitle => 'La importación del archivo falló';

  @override
  String get uploadIntroSubtitle =>
      'Importa un archivo `.srt` o `.vtt` en inglés, deja que el backend lo valide y lo procese, y luego continúa con la configuración de la traducción.';

  @override
  String get uploadIntroTitle => 'Usa tu propio archivo de subtítulos';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount líneas';
  }

  @override
  String get uploadMetadataTitle => 'Detalles del subtítulo';

  @override
  String get uploadOpeningPicker => 'Abriendo selector...';

  @override
  String get uploadPickSubtitle => 'Seleccionar archivo de subtítulos';

  @override
  String get uploadPickedFile => 'Archivo de subtítulos seleccionado';

  @override
  String get uploadReadyTitle => 'Listo para traducir';

  @override
  String get uploadSubtitleTitle => 'Subir subtítulo';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Archivos de subtítulos en inglés `.srt` y `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formatos compatibles';

  @override
  String get uploadUseDemoFile => 'Usar archivo de prueba';
}
