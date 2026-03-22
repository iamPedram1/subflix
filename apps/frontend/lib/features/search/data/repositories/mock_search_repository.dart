import 'package:subflix/features/search/data/apis/mock_search_api.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

class MockSearchRepository implements SearchRepository {
  MockSearchRepository(this._api);

  final MockSearchApi _api;

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
