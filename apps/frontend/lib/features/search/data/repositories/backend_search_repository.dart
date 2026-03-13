import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

/// Backend-backed implementation for catalog discovery flows.
class BackendSearchRepository implements SearchRepository {
  BackendSearchRepository(this._api);

  final CatalogApi _api;

  @override
  Future<List<SubtitleSource>> fetchSubtitleSources(String mediaId) {
    return _api.fetchSubtitleSources(mediaId);
  }

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) {
    return _api.searchTitles(query);
  }
}
