import 'package:subflix/features/subtitles/data/apis/mock_translation_api.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

class MockTranslationRepository implements TranslationRepository {
  MockTranslationRepository(this._api);

  final MockTranslationApi _api;

  @override
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) {
    return _api.startTranslation(request);
  }
}
