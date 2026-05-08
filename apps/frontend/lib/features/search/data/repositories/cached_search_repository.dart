import 'package:subflix/core/utils/async_cache.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

class CachedSearchRepository implements SearchRepository {
  CachedSearchRepository(
    this._inner, {
    Duration searchTtl = const Duration(minutes: 5),
    Duration detailsTtl = const Duration(minutes: 5),
    Duration sourcesTtl = const Duration(minutes: 3),
  }) : _searchCache = AsyncCache<List<MovieSearchItem>>(ttl: searchTtl),
       _detailsCache = AsyncCache<CatalogMediaDetails?>(ttl: detailsTtl),
       _sourcesCache = AsyncCache<List<SubtitleSource>>(ttl: sourcesTtl);

  final SearchRepository _inner;
  final AsyncCache<List<MovieSearchItem>> _searchCache;
  final AsyncCache<CatalogMediaDetails?> _detailsCache;
  final AsyncCache<List<SubtitleSource>> _sourcesCache;

  @override
  Future<CatalogMediaDetails?> fetchMediaDetails(String mediaId) {
    return _detailsCache.get(mediaId, () => _inner.fetchMediaDetails(mediaId));
  }

  @override
  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) {
    final key = [
      mediaId,
      preferredLanguage,
      seasonNumber ?? '',
      episodeNumber ?? '',
      releaseHint ?? '',
    ].join('|');
    return _sourcesCache.get(
      key,
      () => _inner.fetchSubtitleSources(
        mediaId,
        preferredLanguage: preferredLanguage,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
        releaseHint: releaseHint,
      ),
    );
  }

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) {
    final key = query.trim().toLowerCase();
    return _searchCache.get(key, () => _inner.searchTitles(query));
  }
}
