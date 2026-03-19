import 'package:subflix/features/subtitles/data/apis/mock_translation_api.dart';
import 'package:subflix/features/history/data/datasources/history_local_data_source.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

class MockTranslationRepository implements TranslationRepository {
  MockTranslationRepository(this._api, this._historyLocalDataSource);

  final MockTranslationApi _api;
  final HistoryLocalDataSource _historyLocalDataSource;

  @override
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) async* {
    await for (final update in _api.startTranslation(request)) {
      final job = update.job;
      if (job != null) {
        final existing = await _historyLocalDataSource.readJobs();
        final updated = <TranslationJob>[
          job,
          ...existing.where((item) => item.id != job.id),
        ];
        await _historyLocalDataSource.writeJobs(updated);
      }
      yield update;
    }
  }

  @override
  Future<TranslationPreviewPage> fetchPreview({
    required String jobId,
    String query = '',
    int page = 1,
    int limit = 100,
  }) {
    return _loadPreview(jobId: jobId, query: query, page: page, limit: limit);
  }

  Future<TranslationPreviewPage> _loadPreview({
    required String jobId,
    required String query,
    required int page,
    required int limit,
  }) async {
    final jobs = await _historyLocalDataSource.readJobs();
    final job = jobs.firstWhere(
      (item) => item.id == jobId,
      orElse: () => throw Exception('Preview job not found.'),
    );
    final normalized = query.trim().toLowerCase();
    final filtered = normalized.isEmpty
        ? job.lines
        : job.lines
              .where(
                (line) =>
                    line.originalText.toLowerCase().contains(normalized) ||
                    (line.translatedText?.toLowerCase().contains(normalized) ??
                        false),
              )
              .toList(growable: false);
    final start = (page - 1) * limit;
    final end = (start + limit).clamp(0, filtered.length);
    final items = start >= filtered.length
        ? const <SubtitleLine>[]
        : filtered.sublist(start, end);

    return TranslationPreviewPage(
      job: job,
      items: items,
      page: page,
      limit: limit,
      total: filtered.length,
      totalPages: filtered.isEmpty ? 1 : (filtered.length / limit).ceil(),
    );
  }
}
