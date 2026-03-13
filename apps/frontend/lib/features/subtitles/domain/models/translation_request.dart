import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

part 'translation_request.freezed.dart';

@freezed
sealed class TranslationRequest with _$TranslationRequest {
  const factory TranslationRequest.catalog({
    required MovieSearchItem item,
    required SubtitleSource source,
    required AppLanguage targetLanguage,
  }) = CatalogTranslationRequest;

  const factory TranslationRequest.upload({
    required SubtitleFile file,
    required AppLanguage targetLanguage,
  }) = UploadTranslationRequest;
}
