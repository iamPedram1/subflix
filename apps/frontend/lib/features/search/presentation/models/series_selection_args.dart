import 'package:subflix/features/search/domain/models/catalog_media_details.dart';

class SeriesEpisodesArgs {
  const SeriesEpisodesArgs({
    required this.media,
    required this.seasonNumber,
    required this.episodeCount,
    this.seasonName,
    this.seasonYear,
  });

  final CatalogMediaDetails media;
  final int seasonNumber;
  final int episodeCount;
  final String? seasonName;
  final int? seasonYear;
}
