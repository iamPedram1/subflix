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
  String get authAccountSectionTitle => 'Cuenta';

  @override
  String get authAlreadySignedInTitle => 'Ya has iniciado sesión';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'Este dispositivo ya está conectado como $email.';
  }

  @override
  String get authBackToAccount => 'Volver a la cuenta';

  @override
  String get authBackToSignIn => 'Volver a iniciar sesión';

  @override
  String get authCheckInboxTitle => 'Revisa tu correo';

  @override
  String get authConfirmEmailAction => 'Confirmar correo';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Usa el token de verificación enviado a $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Pega el token de verificación de tu correo para terminar de activar esta cuenta.';

  @override
  String get authConfirmEmailSuccess =>
      'Correo confirmado. Ya puedes iniciar sesión.';

  @override
  String get authConfirmEmailTitle => 'Verifica tu correo';

  @override
  String get authConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get authContinueToReset => 'Continuar para restablecer';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authCreateAccountAction => 'Crear cuenta';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Token de depuración: $token';
  }

  @override
  String get authDisplayNameLabel => 'Nombre para mostrar';

  @override
  String get authEmailLabel => 'Correo electrónico';

  @override
  String get authEyebrow => 'Espacio seguro';

  @override
  String get authFieldRequired => 'Este campo es obligatorio.';

  @override
  String get authForgotPasswordAction => 'Enviar enlace de restablecimiento';

  @override
  String get authForgotPasswordDebugMessage =>
      'Se devolvió un token de restablecimiento para este entorno de depuración. Puedes continuar directamente al formulario de restablecimiento.';

  @override
  String get authForgotPasswordLink => '¿Olvidaste tu contraseña?';

  @override
  String get authForgotPasswordSubtitle =>
      'Ingresa tu correo y solicitaremos al backend un restablecimiento de contraseña para esta cuenta.';

  @override
  String get authForgotPasswordSuccess =>
      'Si la cuenta existe, se ha enviado un mensaje para restablecer la contraseña.';

  @override
  String get authForgotPasswordTitle => 'Restablece tu contraseña';

  @override
  String get authGoogleHelper =>
      'El inicio de sesión con Google usa Firebase OAuth y funcionará cuando esta app esté conectada a un proyecto de Firebase.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get authInvalidEmail => 'Introduce un correo válido.';

  @override
  String get authNewPasswordLabel => 'Nueva contraseña';

  @override
  String get authNoAccountLink => '¿Necesitas una cuenta? Crea una';

  @override
  String get authOrDivider => 'o';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get authPasswordTooShort => 'Usa al menos 8 caracteres.';

  @override
  String get authProfileRefreshed => 'Datos de la cuenta actualizados.';

  @override
  String get authRefreshProfileAction => 'Actualizar perfil';

  @override
  String get authRefreshProfileSubtitle =>
      'Cargar los datos más recientes del perfil desde el backend.';

  @override
  String get authResetPasswordAction => 'Guardar nueva contraseña';

  @override
  String authResetPasswordHint(Object email) {
    return 'Restablece la contraseña de $email usando el token de tu correo.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Introduce el token de restablecimiento y elige una nueva contraseña para esta cuenta.';

  @override
  String get authResetPasswordSuccess =>
      'Contraseña actualizada. Vuelve a iniciar sesión.';

  @override
  String get authResetPasswordTitle => 'Elige una nueva contraseña';

  @override
  String get authSignInAction => 'Iniciar sesión';

  @override
  String get authSignInSubtitle =>
      'Conecta esta app a tu cuenta de SubFlix para sincronizar datos de perfil y desbloquear flujos autenticados del backend.';

  @override
  String get authSignInSuccess => 'Sesión iniciada correctamente.';

  @override
  String get authSignInTitle => 'Bienvenido de nuevo';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Conectado como $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Inicia sesión para gestionar tu cuenta, usar Firebase OAuth y dejar listas las funciones autenticadas para futuras sincronizaciones.';

  @override
  String get authSignedOutCardTitle => 'Inicia sesión en SubFlix';

  @override
  String get authSignOutAction => 'Cerrar sesión';

  @override
  String get authSignOutSubtitle =>
      'Revoca la sesión actual de este dispositivo y borra los tokens locales.';

  @override
  String get authSignOutSuccess => 'Sesión cerrada en este dispositivo.';

  @override
  String get authSignUpAction => 'Crear mi cuenta';

  @override
  String get authSignUpSubtitle =>
      'Crea una cuenta para que esta app pueda usar el perfil autenticado y los flujos de sesión del backend.';

  @override
  String get authSignUpSuccess =>
      'Cuenta creada. Continúa con la verificación del correo.';

  @override
  String get authSignUpTitle => 'Crea tu cuenta';

  @override
  String get authVerificationStatusTitle => 'Verificación del correo';

  @override
  String get authVerificationTokenLabel => 'Token de verificación';

  @override
  String get authVerifiedStatus => 'Verificado';

  @override
  String get authUnverifiedStatus => 'Verificación pendiente';

  @override
  String get brandSubtitleCompact => 'Inteligencia de subtР“В­tulos';

  @override
  String get brandSubtitleFull =>
      'Estudio de traducciР“С–n de subtР“В­tulos con IA';

  @override
  String get comingSoonMessage =>
      'TodavР“В­a estamos preparando esta pantalla.';

  @override
  String get comingSoonTitle => 'PrР“С–ximamente';

  @override
  String exportFailedSnack(Object error) {
    return 'La exportaciР“С–n fallР“С–: $error';
  }

  @override
  String get exportSubtitleLabel => 'Exportar subtР“В­tulo traducido';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'Se exportР“С– $fileName a $path';
  }

  @override
  String get exportingLabel => 'Exportando...';

  @override
  String get heroBadge => 'Flujo premium de subtР“В­tulos';

  @override
  String get heroBody =>
      'Elige entre un catР“РЋlogo de tР“В­tulos con bР“С”squeda o la carga directa de archivos, y luego previsualiza y exporta subtР“В­tulos pulidos en minutos.';

  @override
  String get heroHeadline =>
      'Traduce subtР“В­tulos de pelР“В­culas y series con un flujo de nivel estudio.';

  @override
  String get heroSearchCta => 'Buscar pelР“В­cula / serie';

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
      'Busca en catР“РЋlogos de pelР“В­culas y series, elige fuentes y exporta traducciones pulidas en minutos.';

  @override
  String get heroTitle => 'Traduce subtР“В­tulos mР“РЋs rР“РЋpido';

  @override
  String get heroUploadCta => 'Subir subtР“В­tulo';

  @override
  String historyCountLabel(Object count) {
    return '$count traducciones';
  }

  @override
  String get historyEmptyMessage =>
      'Tus trabajos de subtР“В­tulos traducidos aparecerР“РЋn aquР“В­ despuР“В©s de completar un flujo de bР“С”squeda o carga.';

  @override
  String get historyEmptyTitle => 'El historial estР“РЋ vacР“В­o';

  @override
  String get historyFailedItemMessage =>
      'La traducciР“С–n fallР“С–. Toca para comenzar de nuevo.';

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
  String get historyFilterMovies => 'PelР“В­culas';

  @override
  String get historyFilterReused => 'Reutilizado';

  @override
  String get historyFilterSeries => 'Series';

  @override
  String get historySubtitle =>
      'Vuelve a abrir trabajos anteriores, revisa la vista previa otra vez o expР“С–rtalos mР“РЋs tarde.';

  @override
  String get historyTitle => 'Historial de traducciones';

  @override
  String get homeFailedRecentTitle =>
      'No se pudieron cargar los trabajos recientes';

  @override
  String get homeFutureSubtitle =>
      'Los repositorios mock intercambiables mantienen el cР“С–digo de UI aislado de los cambios del backend.';

  @override
  String get homeFutureTitle => 'Repositorios preparados para el futuro';

  @override
  String get homeNoRecentMessage =>
      'Empieza con una bР“С”squeda de pelР“В­cula o sube un archivo de subtР“В­tulos y tus traducciones recientes aparecerР“РЋn aquР“В­.';

  @override
  String get homeNoRecentTitle => 'AР“С”n no hay trabajos recientes';

  @override
  String get homePreviewSubtitle =>
      'Revisa los resultados antes de exportar con vistas original, traducida o bilingР“Сe.';

  @override
  String get homePreviewTitle =>
      'Flujo de traducciР“С–n centrado en la vista previa';

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
  String get homeSearchPlaceholder => 'Buscar pelР“В­culas o series...';

  @override
  String get homeStatesSubtitle =>
      'Carga, vacР“В­o, reintento, validaciР“С–n y escenarios mock sin conexiР“С–n forman parte de la UX desde el primer dР“В­a.';

  @override
  String get homeStatesTitle => 'Estados bien resueltos incluidos';

  @override
  String get homeTrendingNow => 'Tendencias';

  @override
  String get homeTrustSubtitle =>
      'Hoy es una maqueta, pero estР“РЋ estructurado como un producto real listo para salir.';

  @override
  String get homeTrustTitle => 'Por quР“В© los equipos confР“В­an en esto';

  @override
  String get homeViewAll => 'Ver todo';

  @override
  String get homeWelcomeSubtitle => 'Encuentra y traduce subtР“В­tulos';

  @override
  String get homeWelcomeTitle => 'Bienvenido de nuevo';

  @override
  String jobConfidence(Object level) {
    return 'Confianza: $level';
  }

  @override
  String get jobOpenPreview => 'Abrir vista previa';

  @override
  String get jobReuseSubtitle => 'Reutilizar subtР“В­tulo';

  @override
  String get jobReuseTranslation => 'Reutilizar traducciР“С–n';

  @override
  String get legalBodyAbout =>
      'SubFlix es un cliente Flutter de estilo premium para traducciР“С–n de subtР“В­tulos con IA. Esta compilaciР“С–n usa repositorios mock, latencia artificial y persistencia local para que la UI y la arquitectura evolucionen antes de conectar un backend real.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix actualmente solo guarda preferencias mock e historial de traducciones en el dispositivo mediante persistencia local. Una futura integraciР“С–n con backend puede sustituir esto por almacenamiento autenticado, trazas de auditorР“В­a y polР“В­ticas de retenciР“С–n gestionadas por el servidor.';

  @override
  String get legalBodySupport =>
      'El soporte es por ahora un marcador. En una versiР“С–n de producciР“С–n, esta secciР“С–n podrР“В­a conectarse al correo, los reportes de incidencias y la ayuda para cuentas premium sin cambiar la estructura general de la app.';

  @override
  String get legalBodyTerms =>
      'Esta versiР“С–n mock estР“РЋ pensada para poner a prueba los flujos del producto, los estados de la UI y los lР“В­mites de la arquitectura. Cuando mР“РЋs adelante se conecte un backend de producciР“С–n con NestJS y Postgres, la capa legal podrР“РЋ ampliarse con tР“В©rminos reales del servicio y lenguaje de tratamiento de datos.';

  @override
  String get legalPlaceholderBody =>
      'Esta pР“РЋgina es un marcador dentro de la app de demostraciР“С–n. ConР“В©ctala con tu contenido legal real para producciР“С–n.';

  @override
  String get legalTitleAbout => 'Acerca de SubFlix';

  @override
  String get legalTitlePrivacy => 'PolР“В­tica de privacidad';

  @override
  String get legalTitleSupport => 'Soporte';

  @override
  String get legalTitleTerms => 'TР“В©rminos del servicio';

  @override
  String get mediaTypeMovie => 'PelР“В­cula';

  @override
  String get mediaTypeSeries => 'Serie';

  @override
  String get metadataEstimatedDuration => 'DuraciР“С–n estimada';

  @override
  String get metadataFormat => 'Formato';

  @override
  String get metadataLanguages => 'Idiomas';

  @override
  String get metadataLines => 'LР“В­neas';

  @override
  String get navHistory => 'Historial';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get noTitlesMatchedMessage =>
      'No pudimos encontrar ese tР“В­tulo en el catР“РЋlogo de prueba. Prueba una bР“С”squeda mР“РЋs amplia o uno de los tР“В­tulos sugeridos.';

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
      'Busca un tР“В­tulo, revisa las fuentes de subtР“В­tulos en inglР“В©s disponibles y lanza un flujo de traducciР“С–n que se siente inmediato.';

  @override
  String get onboardingPage1Eyebrow => 'Buscar y obtener';

  @override
  String get onboardingPage1Highlight1 =>
      'CatР“РЋlogo mock determinista para un desarrollo fiable';

  @override
  String get onboardingPage1Highlight2 =>
      'Etiquetas de calidad y distintivos de formato';

  @override
  String get onboardingPage1Highlight3 =>
      'Pensado para cambiarse a un backend real mР“РЋs adelante';

  @override
  String get onboardingPage1Title =>
      'Encuentra pelР“В­culas o series y trae subtР“В­tulos listos para traducir.';

  @override
  String get onboardingPage2Description =>
      'Importa tu archivo de subtР“В­tulos, valida el formato y ejecuta la misma canalizaciР“С–n pulida sin salir de la app.';

  @override
  String get onboardingPage2Eyebrow => 'Usa tu propio archivo';

  @override
  String get onboardingPage2Highlight1 =>
      'ValidaciР“С–n local de archivos y estados de reintento bien resueltos';

  @override
  String get onboardingPage2Highlight2 =>
      'ConfiguraciР“С–n coherente para cargas y bР“С”squedas';

  @override
  String get onboardingPage2Highlight3 =>
      'Vista previa antes de exportar para que nada se sienta opaco';

  @override
  String get onboardingPage2Title =>
      'Sube archivos `.srt` o `.vtt` cuando ya tengas el guion.';

  @override
  String get onboardingPage3Description =>
      'Cambia entre vista original, traducida y bilingР“Сe, vuelve al historial y exporta archivos limpios cuando el resultado se vea correcto.';

  @override
  String get onboardingPage3Eyebrow => 'Traducir y exportar';

  @override
  String get onboardingPage3Highlight1 =>
      'Controles rР“РЋpidos de vista previa con metadatos y bР“С”squeda';

  @override
  String get onboardingPage3Highlight2 =>
      'El historial mantiene los trabajos anteriores a un toque de distancia';

  @override
  String get onboardingPage3Highlight3 =>
      'DiseР“В±ado como una herramienta premium de medios, no como una demo';

  @override
  String get onboardingPage3Title =>
      'Elige idiomas de destino, previsualiza subtР“В­tulos y exporta al instante.';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingStart => 'Iniciar traducciР“С–n';

  @override
  String get previewFailedTitle => 'No se pudo cargar la vista previa';

  @override
  String get previewModeBilingual => 'BilingР“Сe';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Traducido';

  @override
  String get previewNoMatchesMessage =>
      'Prueba con otro tР“В©rmino de bР“С”squeda o limpia el filtro para revisar la traducciР“С–n completa.';

  @override
  String get previewNoMatchesTitle => 'No hubo coincidencias en las lР“В­neas';

  @override
  String get previewNotReadyMessage =>
      'La traducciР“С–n terminР“С–, pero el backend todavР“В­a no devolviР“С– los cues de vista previa. Vuelve a cargar esta pantalla en un momento.';

  @override
  String get previewNotReadyTitle =>
      'Los cues de vista previa aР“С”n no estР“РЋn disponibles';

  @override
  String get retry => 'Reintentar';

  @override
  String get retryTranslation => 'Reintentar traducciР“С–n';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'No pudimos determinar quР“В© temporada debР“В­a cargarse. Empieza de nuevo desde la bР“С”squeda.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Episodios de la temporada';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'No pudimos determinar quР“В© serie debР“В­a cargarse. Empieza de nuevo desde la bР“С”squeda.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Temporadas de la serie';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'No pudimos determinar quР“В© tР“В­tulo debР“В­a cargar las fuentes de subtР“В­tulos. Empieza de nuevo desde la bР“С”squeda.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Fuentes de subtР“В­tulos';

  @override
  String get routeMissingTranslationProgressMessage =>
      'No se proporcionР“С– ninguna solicitud de traducciР“С–n. Inicia una nueva traducciР“С–n desde bР“С”squeda o carga.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'Progreso de la traducciР“С–n';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Se requiere una fuente de subtР“В­tulos antes de abrir la pantalla de configuraciР“С–n.';

  @override
  String get routeMissingTranslationSetupTitle =>
      'ConfiguraciР“С–n de traducciР“С–n';

  @override
  String get searchFailedTitle => 'La bР“С”squeda fallР“С–';

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
      'Prueba tР“В­tulos como Inception, Dune, Breaking Bad, Severance o The Last of Us para explorar el flujo de fuentes de subtР“В­tulos.';

  @override
  String get searchMockTitle =>
      'Busca cualquier cosa en el catР“РЋlogo de prueba';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Encuentra un tР“В­tulo, revisa las fuentes de subtР“В­tulos y lanza una traducciР“С–n con unos pocos toques.';

  @override
  String get searchMovieOrSeriesTitle => 'Buscar pelР“В­cula o serie';

  @override
  String searchNoResultsFor(Object query) {
    return 'No se encontraron resultados para \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularidad $score';
  }

  @override
  String get searchTitles => 'Buscar tР“В­tulos';

  @override
  String get searchTrendingTitle => 'BР“С”squedas en tendencia';

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
  String get settingsCacheCleared => 'CachР“В© borrada';

  @override
  String get settingsClearCache => 'Borrar cachР“В©';

  @override
  String get settingsContactTitle => 'ContР“РЋctanos';

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
      'Borra los trabajos de traducciР“С–n gestionados por el backend en este dispositivo y empieza con un historial vacР“В­o.';

  @override
  String get settingsMaintenanceTitle => 'Mantenimiento';

  @override
  String get settingsNotificationsSubtitle =>
      'Administra las preferencias de notificaciones';

  @override
  String get settingsNotificationsTitle => 'Notificaciones';

  @override
  String get settingsPremiumSubtitle =>
      'MР“РЋs adelante podremos conectar aquР“В­ suscripciones, facturaciР“С–n y sincronizaciР“С–n de proyectos en la nube.';

  @override
  String get settingsPremiumTitle => 'Marcador de premium';

  @override
  String get settingsPrivacySubtitle => 'Contenido mock de privacidad';

  @override
  String get settingsPrivacyTitle => 'PolР“В­tica de privacidad';

  @override
  String get settingsProfileName => 'Usuario de SubFlix';

  @override
  String get settingsProfileTier => 'Miembro premium';

  @override
  String get settingsSubtitle => 'Administra tus preferencias';

  @override
  String get settingsSupportSubtitle => 'PР“РЋgina mock de ayuda y contacto';

  @override
  String get settingsSupportTitle => 'Marcador de soporte';

  @override
  String get settingsTermsSubtitle => 'Contenido mock de tР“В©rminos';

  @override
  String get settingsTermsTitle => 'TР“В©rminos del servicio';

  @override
  String get settingsThemeLabel => 'Apariencia';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String settingsVersion(Object version) {
    return 'VersiР“С–n $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Preparando tu estudio de subtР“В­tulos';

  @override
  String get splashSubtitle => 'TraducciР“С–n de subtР“В­tulos con IA';

  @override
  String get startTranslation => 'Iniciar traducciР“С–n';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads descargas';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Fuente de subtР“В­tulos $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount lР“В­neas';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'CalificaciР“С–n $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Selecciona una fuente de subtР“В­tulos y continР“С”a con una configuraciР“С–n pulida, ajustada al tiempo de los subtР“В­tulos.';

  @override
  String get subtitleSourcesBannerTitle => 'TraducciР“С–n con IA disponible';

  @override
  String get subtitleSourcesFailedTitle =>
      'No se pudieron cargar las fuentes de subtР“В­tulos';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Elige una fuente de subtР“В­tulos para $title$target y luego selecciona el idioma de destino en el siguiente paso.';
  }

  @override
  String get subtitleSourcesTitle => 'Fuentes de subtР“В­tulos en inglР“В©s';

  @override
  String get targetLanguage => 'Idioma de destino';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get translateSetupAutoDetect => 'Detectar formato automР“РЋticamente';

  @override
  String get translateSetupAutoDetectBody =>
      'Elige automР“РЋticamente la estructura de salida adecuada para subtР“В­tulos.';

  @override
  String get translateSetupLanguageTitle => 'Traducir a';

  @override
  String get translateSetupOptionsTitle => 'Opciones';

  @override
  String get translateSetupPreserveTiming => 'Conservar tiempos';

  @override
  String get translateSetupPreserveTimingBody =>
      'MantР“В©n los tiempos originales del subtР“В­tulo alineados con el archivo de origen.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Nuestro flujo adaptarР“РЋ este subtР“В­tulo al idioma $language con el tiempo preservado y una estructura limpia de cues.';
  }

  @override
  String get translateSetupReadyTitle => 'TraducciР“С–n con IA lista';

  @override
  String get translateSetupSelectLanguage => 'Seleccionar idioma';

  @override
  String get translateSetupSourceTitle => 'SubtР“В­tulo de origen';

  @override
  String get translateSetupSubtitle =>
      'Elige el idioma de destino, revisa la fuente del subtР“В­tulo y luego inicia la traducciР“С–n en el backend.';

  @override
  String get translateSetupTitle => 'ConfiguraciР“С–n de traducciР“С–n';

  @override
  String get translationFailedMessage => 'Algo saliР“С– mal.';

  @override
  String get translationFailedTitle => 'No se pudo completar la traducciР“С–n';

  @override
  String get translationPreviewHeader => 'Revisa los subtР“В­tulos traducidos';

  @override
  String get translationPreviewSearchHint =>
      'Buscar lР“В­neas de subtР“В­tulos';

  @override
  String get translationPreviewSubtitle =>
      'Busca dentro de los cues, cambia el modo de vista previa y exporta cuando la traducciР“С–n se vea bien.';

  @override
  String get translationPreviewTitle => 'Vista previa de la traducciР“С–n';

  @override
  String get translationProgressHeadline =>
      'La traducciР“С–n de subtР“В­tulos con IA estР“РЋ en curso';

  @override
  String get translationProgressTitle => 'Progreso de la traducciР“С–n';

  @override
  String get translationResultCompleteSubtitle =>
      'Tu subtР“В­tulo estР“РЋ listo para previsualizar o descargar.';

  @override
  String get translationResultCompleteTitle => 'TraducciР“С–n completa';

  @override
  String get translationResultConfidenceLabel => 'Confianza de traducciР“С–n';

  @override
  String get translationResultDetailsTitle => 'Detalles de la traducciР“С–n';

  @override
  String get translationResultDownloadCta => 'Descargar subtР“В­tulo';

  @override
  String get translationResultHomeCta => 'Volver al inicio';

  @override
  String get translationResultMediaLabel => 'TР“В­tulo del contenido';

  @override
  String get translationResultMethodAi => 'Traducido con IA';

  @override
  String get translationResultMetricsTitle => 'MР“В©tricas de calidad';

  @override
  String get translationResultPreviewCta => 'Previsualizar subtР“В­tulo';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Procesado en $duration';
  }

  @override
  String get translationResultSourceLabel => 'Idioma de origen';

  @override
  String get translationResultTargetLabel => 'Idioma de destino';

  @override
  String get translationResultTimingLabel => 'PrecisiР“С–n del tiempo';

  @override
  String get translationResultTimingPreserved => 'Tiempo preservado';

  @override
  String get translationResultWarning =>
      'Algunos tР“В©rminos tР“В©cnicos aР“С”n pueden beneficiarse de una revisiР“С–n humana rР“РЋpida para asegurar el contexto.';

  @override
  String get translationStageAligning =>
      'Alineando marcas de tiempo y contexto de escena';

  @override
  String get translationStageGenerating =>
      'Generando la traducciР“С–n de subtР“В­tulos';

  @override
  String get translationStageIdle => 'Esperando una solicitud de traducciР“С–n';

  @override
  String get translationStagePreparing =>
      'Preparando el paquete de subtР“В­tulos';

  @override
  String get translationStageQueued => 'En cola para traducir';

  @override
  String get translationStageReadability =>
      'Aplicando una revisiР“С–n de legibilidad';

  @override
  String get translationStageReady => 'TraducciР“С–n lista';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get uploadChooseFile => 'Elegir archivo de subtР“В­tulos';

  @override
  String get uploadChooseFileShort => 'Elegir archivo';

  @override
  String get uploadContinueSetup => 'Continuar con la configuraciР“С–n';

  @override
  String get uploadEnglishSource => 'Origen en inglР“В©s';

  @override
  String get uploadFailedFallback =>
      'Prueba con otro archivo de subtР“В­tulos.';

  @override
  String get uploadFailedMessage =>
      'No pudimos leer este archivo de subtР“В­tulos. Prueba con otro archivo o con una exportaciР“С–n mР“РЋs pequeР“В±a.';

  @override
  String get uploadFailedTitle => 'La importaciР“С–n del archivo fallР“С–';

  @override
  String get uploadIntroSubtitle =>
      'Importa un archivo `.srt` o `.vtt` en inglР“В©s, deja que el backend lo valide y lo procese, y luego continР“С”a con la configuraciР“С–n de la traducciР“С–n.';

  @override
  String get uploadIntroTitle => 'Usa tu propio archivo de subtР“В­tulos';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount lР“В­neas';
  }

  @override
  String get uploadMetadataTitle => 'Detalles del subtР“В­tulo';

  @override
  String get uploadOpeningPicker => 'Abriendo selector...';

  @override
  String get uploadPickSubtitle => 'Seleccionar archivo de subtР“В­tulos';

  @override
  String get uploadPickedFile => 'Archivo de subtР“В­tulos seleccionado';

  @override
  String get uploadReadyTitle => 'Listo para traducir';

  @override
  String get uploadSubtitleTitle => 'Subir subtР“В­tulo';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Archivos de subtР“В­tulos en inglР“В©s `.srt` y `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formatos compatibles';

  @override
  String get uploadUseDemoFile => 'Usar archivo de prueba';
}
