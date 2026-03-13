import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

/// Backend-backed translation history repository.
class BackendHistoryRepository implements HistoryRepository {
  BackendHistoryRepository(this._api);

  final TranslationJobsApi _api;

  @override
  Future<void> clear() {
    return _api.clearHistory();
  }

  @override
  Future<List<TranslationJob>> fetchJobs() {
    return _api.listJobs();
  }

  @override
  Future<TranslationJob?> getJobById(String id) async {
    try {
      return await _api.getJob(id);
    } on ApiException catch (error) {
      if (error.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }
}
