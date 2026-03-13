import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

part 'translation_job.freezed.dart';
part 'translation_job.g.dart';

@freezed
abstract class TranslationJob with _$TranslationJob {
  const factory TranslationJob({
    required String id,
    required String title,
    required String sourceName,
    required TranslationSourceType sourceType,
    required TranslationJobStatus status,
    required AppLanguage sourceLanguage,
    required AppLanguage targetLanguage,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SubtitleFormat format,
    required List<SubtitleLine> lines,
    required double progress,
    String? errorMessage,
  }) = _TranslationJob;

  factory TranslationJob.fromJson(Map<String, dynamic> json) =>
      _$TranslationJobFromJson(json);
}
