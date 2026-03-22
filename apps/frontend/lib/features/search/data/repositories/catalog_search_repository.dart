import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

/// API-backed implementation for catalog discovery flows.
class CatalogSearchRepository implements SearchRepository {
  CatalogSearchRepository(this._api);

  final CatalogApi _api;

  @override
  Future<CatalogMediaDetails?> fetchMediaDetails(String mediaId) {
    return _api.fetchMediaDetails(mediaId);
  }

  @override
  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) {
    return _api.fetchSubtitleSources(
      mediaId,
      preferredLanguage: preferredLanguage,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      releaseHint: releaseHint,
    );
  }

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) {
    return _api.searchTitles(query);
  }
}
