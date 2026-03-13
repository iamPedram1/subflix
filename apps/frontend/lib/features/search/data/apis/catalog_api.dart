import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

/// HTTP client for public catalog discovery endpoints.
class CatalogApi {
  CatalogApi(this._dio);

  final Dio _dio;

  Future<List<MovieSearchItem>> searchTitles(String query) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/v1/catalog/search',
        queryParameters: <String, dynamic>{'q': query},
      );
      final items = response.data ?? const <dynamic>[];
      return items
          .map((item) => MovieSearchItem.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<List<SubtitleSource>> fetchSubtitleSources(String mediaId) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/v1/catalog/media/$mediaId/subtitle-sources',
      );
      final items = response.data ?? const <dynamic>[];
      return items
          .map((item) => SubtitleSource.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}
