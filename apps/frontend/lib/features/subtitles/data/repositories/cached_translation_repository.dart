import 'package:subflix/core/utils/async_cache.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

class CachedTranslationRepository implements TranslationRepository {
  CachedTranslationRepository(
    this._inner, {
    Duration previewTtl = const Duration(seconds: 45),
  }) : _previewCache =
            AsyncCache<TranslationPreviewPage>(ttl: previewTtl);

  final TranslationRepository _inner;
  final AsyncCache<TranslationPreviewPage> _previewCache;

  @override
  Future<TranslationPreviewPage> fetchPreview({
    required String jobId,
    String query = '',
    int page = 1,
    int limit = 100,
  }) {
    final key = [
      jobId,
      query.trim().toLowerCase(),
      page,
      limit,
    ].join('|');
    return _previewCache.get(
      key,
      () => _inner.fetchPreview(
        jobId: jobId,
        query: query,
        page: page,
        limit: limit,
      ),
    );
  }

  @override
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) {
    return _inner.startTranslation(request);
  }
}
