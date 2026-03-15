import 'package:subflix/features/search/domain/models/movie_search_item.dart';

class SeriesEpisodesArgs {
  const SeriesEpisodesArgs({
    required this.item,
    required this.seasonNumber,
    required this.episodeCount,
    this.seasonYear,
  });

  final MovieSearchItem item;
  final int seasonNumber;
  final int episodeCount;
  final int? seasonYear;
}
