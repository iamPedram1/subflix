import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/subtitles/application/translation_preview_query.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';

part 'translation_preview_provider.g.dart';

@riverpod
Future<TranslationPreviewPage> translationPreview(
  Ref ref,
  TranslationPreviewQuery request,
) {
  return ref
      .watch(translationRepositoryProvider)
      .fetchPreview(
        jobId: request.jobId,
        query: request.query,
        page: request.page,
        limit: request.limit,
      );
}
