/// Central API route definitions used by Retrofit clients.
abstract final class ApiPaths {
  static const String health = '/health';

  static const String authSignUp = '/auth/signup';
  static const String authConfirmEmail = '/auth/confirm-email';
  static const String authSignIn = '/auth/signin';
  static const String authRefresh = '/auth/refresh';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String authFirebase = '/auth/oauth/firebase';
  static const String authSignOut = '/auth/signout';
  static const String authMe = '/auth/me';

  static const String catalogSearch = '/catalog/search';
  static const String catalogSubtitleSources =
      '/catalog/media/{mediaId}/subtitle-sources';

  static const String preferences = '/preferences';

  static const String subtitlesParse = '/subtitles/parse';

  static const String translationJobs = '/translation-jobs';
  static const String translationJob = '/translation-jobs/{jobId}';
  static const String translationJobPreview =
      '/translation-jobs/{jobId}/preview';
  static const String translationJobExport = '/translation-jobs/{jobId}/export';
  static const String translationJobRetry = '/translation-jobs/{jobId}/retry';
}
