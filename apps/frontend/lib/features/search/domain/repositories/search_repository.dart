import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

abstract interface class SearchRepository {
  Future<List<MovieSearchItem>> searchTitles(String query);

  Future<CatalogMediaDetails?> fetchMediaDetails(String mediaId);

  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  });
}
