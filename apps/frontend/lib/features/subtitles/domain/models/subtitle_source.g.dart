// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubtitleSource _$SubtitleSourceFromJson(Map<String, dynamic> json) =>
    _SubtitleSource(
      id: json['id'] as String,
      label: json['label'] as String,
      releaseGroup: json['releaseGroup'] as String,
      format: $enumDecode(_$SubtitleFormatEnumMap, json['format']),
      hearingImpaired: json['hearingImpaired'] as bool,
      lineCount: (json['lineCount'] as num).toInt(),
      downloads: (json['downloads'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$SubtitleSourceToJson(_SubtitleSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'releaseGroup': instance.releaseGroup,
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'hearingImpaired': instance.hearingImpaired,
      'lineCount': instance.lineCount,
      'downloads': instance.downloads,
      'rating': instance.rating,
    };

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};
