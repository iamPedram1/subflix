// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationJob _$TranslationJobFromJson(Map<String, dynamic> json) =>
    _TranslationJob(
      id: json['id'] as String,
      title: json['title'] as String,
      sourceName: json['sourceName'] as String,
      sourceType: $enumDecode(
        _$TranslationSourceTypeEnumMap,
        json['sourceType'],
      ),
      status: $enumDecode(_$TranslationJobStatusEnumMap, json['status']),
      sourceLanguage: $enumDecode(_$AppLanguageEnumMap, json['sourceLanguage']),
      targetLanguage: $enumDecode(_$AppLanguageEnumMap, json['targetLanguage']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      format: $enumDecode(_$SubtitleFormatEnumMap, json['format']),
      lines: (json['lines'] as List<dynamic>)
          .map((e) => SubtitleLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      progress: (json['progress'] as num).toDouble(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$TranslationJobToJson(_TranslationJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sourceName': instance.sourceName,
      'sourceType': _$TranslationSourceTypeEnumMap[instance.sourceType]!,
      'status': _$TranslationJobStatusEnumMap[instance.status]!,
      'sourceLanguage': _$AppLanguageEnumMap[instance.sourceLanguage]!,
      'targetLanguage': _$AppLanguageEnumMap[instance.targetLanguage]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'lines': instance.lines,
      'progress': instance.progress,
      'errorMessage': instance.errorMessage,
    };

const _$TranslationSourceTypeEnumMap = {
  TranslationSourceType.catalog: 'catalog',
  TranslationSourceType.upload: 'upload',
};

const _$TranslationJobStatusEnumMap = {
  TranslationJobStatus.queued: 'queued',
  TranslationJobStatus.translating: 'translating',
  TranslationJobStatus.completed: 'completed',
  TranslationJobStatus.failed: 'failed',
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

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};
