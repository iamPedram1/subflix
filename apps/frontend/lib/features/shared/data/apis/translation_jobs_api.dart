import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

/// Shared API client for translation job summary, preview, and export flows.
class TranslationJobsApi {
  TranslationJobsApi(this._dio);

  final Dio _dio;

  Future<TranslationJob> createJob(TranslationRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/translation-jobs',
        data: request.map(
          catalog: (catalogRequest) => <String, dynamic>{
            'sourceType': 'catalog',
            'mediaId': catalogRequest.item.id,
            'subtitleSourceId': catalogRequest.source.id,
            'targetLanguage': catalogRequest.targetLanguage.code,
          },
          upload: (uploadRequest) => <String, dynamic>{
            'sourceType': 'upload',
            'parsedFileId': uploadRequest.file.id,
            'targetLanguage': uploadRequest.targetLanguage.code,
          },
        ),
      );
      return TranslationJob.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<List<TranslationJob>> listJobs({int page = 1, int limit = 100}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/translation-jobs',
        queryParameters: <String, dynamic>{'page': page, 'limit': limit},
      );
      final items = response.data?['items'] as List<dynamic>? ?? const <dynamic>[];
      return items
          .map((item) => TranslationJob.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<TranslationJob> getJob(String jobId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/translation-jobs/$jobId',
      );
      return TranslationJob.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<TranslationPreviewPage> getPreview({
    required String jobId,
    int page = 1,
    int limit = 100,
    String query = '',
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/translation-jobs/$jobId/preview',
        queryParameters: <String, dynamic>{
          'page': page,
          'limit': limit,
          if (query.trim().isNotEmpty) 'q': query.trim(),
        },
      );
      return TranslationPreviewPage.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<Response<String>> exportJob({
    required String jobId,
    required String format,
  }) async {
    try {
      return _dio.get<String>(
        '/v1/translation-jobs/$jobId/export',
        queryParameters: <String, dynamic>{'format': format},
        options: Options(responseType: ResponseType.plain),
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<TranslationJob> retryJob(String jobId) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/translation-jobs/$jobId/retry',
      );
      return TranslationJob.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<void> clearHistory() async {
    try {
      await _dio.delete<void>('/v1/translation-jobs');
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}
