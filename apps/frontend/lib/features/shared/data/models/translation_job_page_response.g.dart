// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_job_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationJobPageResponse _$TranslationJobPageResponseFromJson(
  Map<String, dynamic> json,
) => TranslationJobPageResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => TranslationJob.fromJson(e as Map<String, dynamic>))
      .toList(),
);
