import 'package:subflix/features/shared/domain/models/translation_job.dart';

abstract interface class HistoryRepository {
  Future<List<TranslationJob>> fetchJobs();

  Future<TranslationJob?> getJobById(String id);

  Future<void> saveJob(TranslationJob job);

  Future<void> clear();
}
