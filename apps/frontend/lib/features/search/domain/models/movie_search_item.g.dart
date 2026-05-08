// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MovieSearchItem _$MovieSearchItemFromJson(Map<String, dynamic> json) =>
    _MovieSearchItem(
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
    );

Map<String, dynamic> _$MovieSearchItemToJson(_MovieSearchItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'mediaType': _$SearchMediaTypeEnumMap[instance.mediaType]!,
      'posterUrl': instance.posterUrl,
      'synopsis': instance.synopsis,
      'genres': instance.genres,
      'runtimeMinutes': instance.runtimeMinutes,
      'popularity': instance.popularity,
    };

const _$SearchMediaTypeEnumMap = {
  SearchMediaType.movie: 'movie',
  SearchMediaType.series: 'series',
};
