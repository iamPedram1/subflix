import 'package:subflix/core/utils/fake_latency.dart';
import 'package:subflix/features/history/data/datasources/history_local_data_source.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

class LocalHistoryRepository implements HistoryRepository {
  LocalHistoryRepository(this._dataSource);

  final HistoryLocalDataSource _dataSource;

  @override
  Future<void> clear() async {
    await fakeDelay(const Duration(milliseconds: 250));
    await _dataSource.writeJobs(const <TranslationJob>[]);
  }

  @override
  Future<List<TranslationJob>> fetchJobs() async {
    await fakeDelay(const Duration(milliseconds: 380));
    final jobs = await _dataSource.readJobs();
    jobs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return jobs;
  }

  @override
  Future<TranslationJob?> getJobById(String id) async {
    final jobs = await fetchJobs();
    for (final job in jobs) {
      if (job.id == id) {
        return job;
      }
    }
    return null;
  }
}
