// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_preview_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationPreviewPage _$TranslationPreviewPageFromJson(
  Map<String, dynamic> json,
) => _TranslationPreviewPage(
  job: TranslationJob.fromJson(json['job'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => SubtitleLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$TranslationPreviewPageToJson(
  _TranslationPreviewPage instance,
) => <String, dynamic>{
  'job': instance.job,
  'items': instance.items,
  'page': instance.page,
  'limit': instance.limit,
  'total': instance.total,
  'totalPages': instance.totalPages,
};
