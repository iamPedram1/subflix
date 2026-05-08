import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

abstract interface class TranslationRepository {
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  );

  Future<TranslationPreviewPage> fetchPreview({
    required String jobId,
    String query = '',
    int page = 1,
    int limit = 100,
  });
}
