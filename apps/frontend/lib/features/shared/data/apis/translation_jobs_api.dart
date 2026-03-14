import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/shared/data/models/translation_job_page_response.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

part 'translation_jobs_api.g.dart';

/// Shared API client for translation job summary, preview, and export flows.
class TranslationJobsApi {
  TranslationJobsApi(Dio dio, {String? baseUrl})
    : _client = TranslationJobsRestClient(dio, baseUrl: baseUrl);

  final TranslationJobsRestClient _client;

  Future<TranslationJob> createJob(TranslationRequest request) async {
    return _client.createJob(_createJobPayload(request)).guardApiCall();
  }

  Future<List<TranslationJob>> listJobs({int page = 1, int limit = 100}) async {
    final response = await _client.listJobs(page, limit).guardApiCall();
    return response.items;
  }

  Future<TranslationJob> getJob(String jobId) {
    return _client.getJob(jobId).guardApiCall();
  }

  Future<TranslationPreviewPage> getPreview({
    required String jobId,
    int page = 1,
    int limit = 100,
    String query = '',
  }) {
    return _client.getPreview(
      jobId,
      page,
      limit,
      query.trim().isEmpty ? null : query.trim(),
    ).guardApiCall();
  }

  Future<HttpResponse<String>> exportJob({
    required String jobId,
    required String format,
  }) {
    return _client.exportJob(jobId, format).guardApiCall();
  }

  Future<TranslationJob> retryJob(String jobId) {
    return _client.retryJob(jobId).guardApiCall();
  }

  Future<void> clearHistory() {
    return _client.clearHistory().guardApiCall();
  }

  Map<String, dynamic> _createJobPayload(TranslationRequest request) {
    return request.map(
      catalog: (catalogRequest) => <String, dynamic>{
        'sourceType': 'catalog',
        'mediaId': catalogRequest.item.id,
        'subtitleSourceId': catalogRequest.source.id,
        if (catalogRequest.seasonNumber != null)
          'seasonNumber': catalogRequest.seasonNumber,
        if (catalogRequest.episodeNumber != null)
          'episodeNumber': catalogRequest.episodeNumber,
        if (catalogRequest.releaseHint != null)
          'releaseHint': catalogRequest.releaseHint,
        'targetLanguage': catalogRequest.targetLanguage.code,
      },
      upload: (uploadRequest) => <String, dynamic>{
        'sourceType': 'upload',
        'parsedFileId': uploadRequest.file.id,
        'targetLanguage': uploadRequest.targetLanguage.code,
      },
    );
  }
}

@RestApi()
abstract class TranslationJobsRestClient {
  factory TranslationJobsRestClient(Dio dio, {String? baseUrl}) =
      _TranslationJobsRestClient;

  @POST(ApiPaths.translationJobs)
  Future<TranslationJob> createJob(@Body() Map<String, dynamic> payload);

  @GET(ApiPaths.translationJobs)
  Future<TranslationJobPageResponse> listJobs(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET(ApiPaths.translationJob)
  Future<TranslationJob> getJob(@Path('jobId') String jobId);

  @GET(ApiPaths.translationJobPreview)
  Future<TranslationPreviewPage> getPreview(
    @Path('jobId') String jobId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('q') String? query,
  );

  @GET(ApiPaths.translationJobExport)
  @DioResponseType(ResponseType.plain)
  Future<HttpResponse<String>> exportJob(
    @Path('jobId') String jobId,
    @Query('format') String format,
  );

  @POST(ApiPaths.translationJobRetry)
  Future<TranslationJob> retryJob(@Path('jobId') String jobId);

  @DELETE(ApiPaths.translationJobs)
  Future<void> clearHistory();
}
