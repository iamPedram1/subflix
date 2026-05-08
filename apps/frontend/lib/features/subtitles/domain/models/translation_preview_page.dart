import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

part 'translation_preview_page.freezed.dart';
part 'translation_preview_page.g.dart';

@freezed
abstract class TranslationPreviewPage with _$TranslationPreviewPage {
  const factory TranslationPreviewPage({
    required TranslationJob job,
    required List<SubtitleLine> items,
    required int page,
    required int limit,
    required int total,
    required int totalPages,
  }) = _TranslationPreviewPage;

  factory TranslationPreviewPage.fromJson(Map<String, dynamic> json) =>
      _$TranslationPreviewPageFromJson(json);
}
