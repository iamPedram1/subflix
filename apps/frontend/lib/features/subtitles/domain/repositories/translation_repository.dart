import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

abstract interface class TranslationRepository {
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  );
}
