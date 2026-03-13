import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

abstract interface class SearchRepository {
  Future<List<MovieSearchItem>> searchTitles(String query);

  Future<List<SubtitleSource>> fetchSubtitleSources(String mediaId);
}
