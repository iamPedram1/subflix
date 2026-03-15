/// Central API route definitions used by Retrofit clients.
abstract final class ApiPaths {
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
