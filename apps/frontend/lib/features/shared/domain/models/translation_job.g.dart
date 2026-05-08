// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationJob _$TranslationJobFromJson(
  Map<String, dynamic> json,
) => _TranslationJob(
  id: json['id'] as String,
  title: json['title'] as String,
  sourceName: json['sourceName'] as String,
  sourceType: $enumDecode(_$TranslationSourceTypeEnumMap, json['sourceType']),
  status: $enumDecode(_$TranslationJobStatusEnumMap, json['status']),
  stageLabel: json['stageLabel'] as String,
  sourceLanguage: $enumDecode(_$AppLanguageEnumMap, json['sourceLanguage']),
  targetLanguage: $enumDecode(_$AppLanguageEnumMap, json['targetLanguage']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  format: $enumDecode(_$SubtitleFormatEnumMap, json['format']),
  lineCount: (json['lineCount'] as num).toInt(),
  durationMs: (json['durationMs'] as num).toInt(),
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => SubtitleLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SubtitleLine>[],
  progress: (json['progress'] as num).toDouble(),
  errorMessage: json['errorMessage'] as String?,
  subtitleConfidenceScore: (json['subtitleConfidenceScore'] as num?)?.toInt(),
  subtitleConfidenceLevel: json['subtitleConfidenceLevel'] as String?,
  subtitleWarnings:
      (json['subtitleWarnings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  subtitleTimingOffsetMs: (json['subtitleTimingOffsetMs'] as num?)?.toInt(),
  subtitleTimingConfidence: (json['subtitleTimingConfidence'] as num?)?.toInt(),
  subtitleTimingCorrected: json['subtitleTimingCorrected'] as bool?,
  subtitleAcquisitionMode: json['subtitleAcquisitionMode'] as String?,
  reusedExistingSubtitle: json['reusedExistingSubtitle'] as bool?,
  reusedSubtitleConfidenceScore: (json['reusedSubtitleConfidenceScore'] as num?)
      ?.toInt(),
  reusedSubtitleConfidenceLevel:
      json['reusedSubtitleConfidenceLevel'] as String?,
  translationReuse: json['translationReuse'] as bool?,
  translationReusedFromJobId: json['translationReusedFromJobId'] as String?,
);

Map<String, dynamic> _$TranslationJobToJson(_TranslationJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sourceName': instance.sourceName,
      'sourceType': _$TranslationSourceTypeEnumMap[instance.sourceType]!,
      'status': _$TranslationJobStatusEnumMap[instance.status]!,
      'stageLabel': instance.stageLabel,
      'sourceLanguage': _$AppLanguageEnumMap[instance.sourceLanguage]!,
      'targetLanguage': _$AppLanguageEnumMap[instance.targetLanguage]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'lineCount': instance.lineCount,
      'durationMs': instance.durationMs,
      'lines': instance.lines,
      'progress': instance.progress,
      'errorMessage': instance.errorMessage,
      'subtitleConfidenceScore': instance.subtitleConfidenceScore,
      'subtitleConfidenceLevel': instance.subtitleConfidenceLevel,
      'subtitleWarnings': instance.subtitleWarnings,
      'subtitleTimingOffsetMs': instance.subtitleTimingOffsetMs,
      'subtitleTimingConfidence': instance.subtitleTimingConfidence,
      'subtitleTimingCorrected': instance.subtitleTimingCorrected,
      'subtitleAcquisitionMode': instance.subtitleAcquisitionMode,
      'reusedExistingSubtitle': instance.reusedExistingSubtitle,
      'reusedSubtitleConfidenceScore': instance.reusedSubtitleConfidenceScore,
      'reusedSubtitleConfidenceLevel': instance.reusedSubtitleConfidenceLevel,
      'translationReuse': instance.translationReuse,
      'translationReusedFromJobId': instance.translationReusedFromJobId,
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

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};
