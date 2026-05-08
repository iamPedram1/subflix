// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_media_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogSeasonDetails _$CatalogSeasonDetailsFromJson(
  Map<String, dynamic> json,
) => _CatalogSeasonDetails(
  seasonNumber: (json['seasonNumber'] as num).toInt(),
  name: json['name'] as String,
  episodeCount: (json['episodeCount'] as num).toInt(),
  airDate: json['airDate'] as String?,
  overview: json['overview'] as String?,
  posterUrl: json['posterUrl'] as String?,
);

Map<String, dynamic> _$CatalogSeasonDetailsToJson(
  _CatalogSeasonDetails instance,
) => <String, dynamic>{
  'seasonNumber': instance.seasonNumber,
  'name': instance.name,
  'episodeCount': instance.episodeCount,
  'airDate': instance.airDate,
  'overview': instance.overview,
  'posterUrl': instance.posterUrl,
};

_CatalogMediaDetails _$CatalogMediaDetailsFromJson(Map<String, dynamic> json) =>
    _CatalogMediaDetails(
      id: json['id'] as String,
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      mediaType: $enumDecode(_$SearchMediaTypeEnumMap, json['mediaType']),
      posterUrl: json['posterUrl'] as String?,
      synopsis: json['synopsis'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      runtimeMinutes: (json['runtimeMinutes'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      tmdbId: (json['tmdbId'] as num?)?.toInt(),
      imdbId: json['imdbId'] as String?,
      originalTitle: json['originalTitle'] as String?,
      providerMediaType: $enumDecode(
        _$CatalogProviderMediaTypeEnumMap,
        json['providerMediaType'],
      ),
      seasonsCount: (json['seasonsCount'] as num?)?.toInt(),
      episodesCount: (json['episodesCount'] as num?)?.toInt(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => CatalogSeasonDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CatalogMediaDetailsToJson(
  _CatalogMediaDetails instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'year': instance.year,
  'mediaType': _$SearchMediaTypeEnumMap[instance.mediaType]!,
  'posterUrl': instance.posterUrl,
  'synopsis': instance.synopsis,
  'genres': instance.genres,
  'runtimeMinutes': instance.runtimeMinutes,
  'popularity': instance.popularity,
  'tmdbId': instance.tmdbId,
  'imdbId': instance.imdbId,
  'originalTitle': instance.originalTitle,
  'providerMediaType':
      _$CatalogProviderMediaTypeEnumMap[instance.providerMediaType]!,
  'seasonsCount': instance.seasonsCount,
  'episodesCount': instance.episodesCount,
  'seasons': instance.seasons,
};

const _$SearchMediaTypeEnumMap = {
  SearchMediaType.movie: 'movie',
  SearchMediaType.series: 'series',
};

const _$CatalogProviderMediaTypeEnumMap = {
  CatalogProviderMediaType.movie: 'movie',
  CatalogProviderMediaType.tv: 'tv',
};
