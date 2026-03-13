import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/translation_job.dart';

part 'translation_progress_update.freezed.dart';

@freezed
abstract class TranslationProgressUpdate with _$TranslationProgressUpdate {
  const factory TranslationProgressUpdate({
    required double progress,
    required String stageLabel,
    TranslationJob? job,
  }) = _TranslationProgressUpdate;
}
