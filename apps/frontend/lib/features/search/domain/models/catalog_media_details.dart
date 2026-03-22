import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';

part 'catalog_media_details.freezed.dart';
part 'catalog_media_details.g.dart';

enum CatalogProviderMediaType { movie, tv }

@freezed
abstract class CatalogSeasonDetails with _$CatalogSeasonDetails {
  const factory CatalogSeasonDetails({
    required int seasonNumber,
    required String name,
    required int episodeCount,
    String? airDate,
    String? overview,
    String? posterUrl,
  }) = _CatalogSeasonDetails;

  factory CatalogSeasonDetails.fromJson(Map<String, dynamic> json) =>
      _$CatalogSeasonDetailsFromJson(json);
}

@freezed
abstract class CatalogMediaDetails with _$CatalogMediaDetails {
  const CatalogMediaDetails._();

  const factory CatalogMediaDetails({
    required String id,
    required String title,
    required int year,
    required SearchMediaType mediaType,
    String? posterUrl,
    required String synopsis,
    required List<String> genres,
    required int runtimeMinutes,
    required double popularity,
    int? tmdbId,
    String? imdbId,
    String? originalTitle,
    required CatalogProviderMediaType providerMediaType,
    int? seasonsCount,
    int? episodesCount,
    List<CatalogSeasonDetails>? seasons,
  }) = _CatalogMediaDetails;

  factory CatalogMediaDetails.fromJson(Map<String, dynamic> json) =>
      _$CatalogMediaDetailsFromJson(json);

  MovieSearchItem toSearchItem() {
    return MovieSearchItem(
      id: id,
      title: title,
      year: year,
      mediaType: mediaType,
      posterUrl: posterUrl,
      synopsis: synopsis,
      genres: genres,
      runtimeMinutes: runtimeMinutes,
      popularity: popularity,
    );
  }
}
