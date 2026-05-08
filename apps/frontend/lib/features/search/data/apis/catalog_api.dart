import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

part 'catalog_api.g.dart';

/// HTTP client for public catalog discovery endpoints.
class CatalogApi {
  CatalogApi(Dio dio, {String? baseUrl})
    : _client = CatalogRestClient(dio, baseUrl: baseUrl);

  final CatalogRestClient _client;

  Future<List<MovieSearchItem>> searchTitles(String query) {
    return _client.searchTitles(query).guardApiCall();
  }

  Future<CatalogMediaDetails?> fetchMediaDetails(String mediaId) {
    return _client.fetchMediaDetails(mediaId).guardApiCall();
  }

  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) {
    return _client
        .fetchSubtitleSources(
          mediaId,
          preferredLanguage,
          seasonNumber,
          episodeNumber,
          releaseHint,
        )
        .guardApiCall();
  }
}

@RestApi()
abstract class CatalogRestClient {
  factory CatalogRestClient(Dio dio, {String? baseUrl}) = _CatalogRestClient;

  @GET(ApiPaths.catalogSearch)
  Future<List<MovieSearchItem>> searchTitles(@Query('q') String query);

  @GET(ApiPaths.catalogMediaDetails)
  Future<CatalogMediaDetails?> fetchMediaDetails(@Path('mediaId') String mediaId);

  @GET(ApiPaths.catalogSubtitleSources)
  Future<List<SubtitleSource>> fetchSubtitleSources(
    @Path('mediaId') String mediaId,
    @Query('preferredLanguage') String preferredLanguage,
    @Query('seasonNumber') int? seasonNumber,
    @Query('episodeNumber') int? episodeNumber,
    @Query('releaseHint') String? releaseHint,
  );
}
