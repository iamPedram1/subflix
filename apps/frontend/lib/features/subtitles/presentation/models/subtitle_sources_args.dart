import 'package:subflix/features/search/domain/models/movie_search_item.dart';

class SubtitleSourcesArgs {
  const SubtitleSourcesArgs({
    required this.item,
    this.seasonNumber,
    this.episodeNumber,
    this.releaseHint,
  });

  final MovieSearchItem item;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? releaseHint;
}
