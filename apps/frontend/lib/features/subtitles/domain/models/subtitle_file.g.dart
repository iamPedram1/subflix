// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubtitleFile _$SubtitleFileFromJson(Map<String, dynamic> json) =>
    _SubtitleFile(
      id: json['id'] as String,
      name: json['fileName'] as String,
      format: $enumDecode(_$SubtitleFormatEnumMap, json['format']),
      sourceLanguage: $enumDecode(_$AppLanguageEnumMap, json['sourceLanguage']),
      lineCount: (json['lineCount'] as num).toInt(),
      durationMs: (json['durationMs'] as num).toInt(),
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => SubtitleLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SubtitleLine>[],
      originalPath: json['originalPath'] as String?,
    );

Map<String, dynamic> _$SubtitleFileToJson(_SubtitleFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.name,
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'sourceLanguage': _$AppLanguageEnumMap[instance.sourceLanguage]!,
      'lineCount': instance.lineCount,
      'durationMs': instance.durationMs,
      'lines': instance.lines,
      'originalPath': instance.originalPath,
    };

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};

const _$AppLanguageEnumMap = {
  AppLanguage.english: 'en',
  AppLanguage.spanish: 'es',
  AppLanguage.persian: 'fa',
  AppLanguage.arabic: 'ar',
  AppLanguage.french: 'fr',
  AppLanguage.german: 'de',
  AppLanguage.portuguese: 'pt',
  AppLanguage.japanese: 'ja',
  AppLanguage.chinese: 'zh',
  AppLanguage.korean: 'ko',
  AppLanguage.hindi: 'hi',
  AppLanguage.turkish: 'tr',
};
