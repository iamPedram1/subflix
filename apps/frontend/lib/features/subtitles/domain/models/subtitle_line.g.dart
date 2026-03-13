// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubtitleLine _$SubtitleLineFromJson(Map<String, dynamic> json) =>
    _SubtitleLine(
      index: (json['index'] as num).toInt(),
      startMs: (json['startMs'] as num).toInt(),
      endMs: (json['endMs'] as num).toInt(),
      originalText: json['originalText'] as String,
      translatedText: json['translatedText'] as String?,
    );

Map<String, dynamic> _$SubtitleLineToJson(_SubtitleLine instance) =>
    <String, dynamic>{
      'index': instance.index,
      'startMs': instance.startMs,
      'endMs': instance.endMs,
      'originalText': instance.originalText,
      'translatedText': instance.translatedText,
    };
