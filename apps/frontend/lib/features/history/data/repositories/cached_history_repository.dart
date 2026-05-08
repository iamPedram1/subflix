import 'package:subflix/core/utils/async_cache.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

class CachedHistoryRepository implements HistoryRepository {
  CachedHistoryRepository(
    this._inner, {
    Duration ttl = const Duration(minutes: 2),
  }) : _cache = AsyncCache<List<TranslationJob>>(ttl: ttl);

  final HistoryRepository _inner;
  final AsyncCache<List<TranslationJob>> _cache;

  @override
  Future<List<TranslationJob>> fetchJobs() {
    return _cache.get('jobs', _inner.fetchJobs);
  }

  @override
  Future<TranslationJob?> getJobById(String id) async {
    final cached = await _cache.get('jobs', _inner.fetchJobs);
    for (final job in cached) {
      if (job.id == id) {
        return job;
      }
    }
    return _inner.getJobById(id);
  }

  @override
  Future<void> clear() async {
    _cache.clear();
    await _inner.clear();
  }
}
