// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubtitleFile _$SubtitleFileFromJson(Map<String, dynamic> json) =>
    _SubtitleFile(
      id: json['id'] as String,
      name: json['name'] as String,
      format: $enumDecode(_$SubtitleFormatEnumMap, json['format']),
      sourceLanguage: $enumDecode(_$AppLanguageEnumMap, json['sourceLanguage']),
      lines: (json['lines'] as List<dynamic>)
          .map((e) => SubtitleLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalPath: json['originalPath'] as String?,
    );

Map<String, dynamic> _$SubtitleFileToJson(_SubtitleFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'sourceLanguage': _$AppLanguageEnumMap[instance.sourceLanguage]!,
      'lines': instance.lines,
      'originalPath': instance.originalPath,
    };

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};

const _$AppLanguageEnumMap = {
  AppLanguage.english: 'english',
  AppLanguage.spanish: 'spanish',
  AppLanguage.arabic: 'arabic',
  AppLanguage.french: 'french',
  AppLanguage.german: 'german',
  AppLanguage.portuguese: 'portuguese',
  AppLanguage.japanese: 'japanese',
  AppLanguage.korean: 'korean',
  AppLanguage.hindi: 'hindi',
  AppLanguage.turkish: 'turkish',
};
