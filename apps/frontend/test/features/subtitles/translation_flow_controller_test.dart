import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/subtitles/application/translation_flow_controller.dart';
import 'package:subflix/features/subtitles/application/translation_flow_state.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

void main() {
  test('runs a translation job and exposes it through history', () async {
    final persistedJobs = <TranslationJob>[];
    final translationRepository = _FakeTranslationRepository(persistedJobs);
    final historyRepository = _InMemoryHistoryRepository(persistedJobs);

    final container = ProviderContainer(
      overrides: [
        translationRepositoryProvider.overrideWithValue(translationRepository),
        historyRepositoryProvider.overrideWithValue(historyRepository),
      ],
    );
    addTearDown(container.dispose);

    final request = TranslationRequest.catalog(
      item: const MovieSearchItem(
        id: 'dune_part_two',
        title: 'Dune: Part Two',
        year: 2024,
        mediaType: SearchMediaType.movie,
        synopsis: 'Epic science-fiction drama.',
        genres: <String>['Sci-Fi'],
        runtimeMinutes: 166,
        popularity: 9.6,
      ),
      source: const SubtitleSource(
        id: 'dune_part_two-webdl',
        label: 'English WEB-DL 1080p',
        releaseGroup: 'SubFlix Studio',
        format: SubtitleFormat.srt,
        hearingImpaired: false,
        lineCount: 612,
        downloads: 24870,
        rating: 4.9,
      ),
      targetLanguage: AppLanguage.french,
    );

    await container
        .read(translationFlowControllerProvider.notifier)
        .start(request);
    await Future<void>.delayed(const Duration(milliseconds: 120));

    final flowState = container.read(translationFlowControllerProvider);
    expect(flowState.status, TranslationFlowStatus.completed);
    expect(flowState.job, isNotNull);
    expect(flowState.job!.stageLabel, 'Translation ready');

    final history = await container.read(historyControllerProvider.future);
    expect(history.any((job) => job.id == flowState.job!.id), isTrue);
  });
}

class _FakeTranslationRepository implements TranslationRepository {
  _FakeTranslationRepository(this._persistedJobs);

  final List<TranslationJob> _persistedJobs;

  @override
  Future<TranslationPreviewPage> fetchPreview({
    required String jobId,
    String query = '',
    int page = 1,
    int limit = 100,
  }) {
    throw UnimplementedError();
  }

  @override
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) async* {
    yield const TranslationProgressUpdate(
      progress: 0.42,
      stageLabel: 'Translating subtitle lines',
    );
    await Future<void>.delayed(const Duration(milliseconds: 40));

    final job = TranslationJob(
      id: 'job_001',
      title: request.when(
        catalog: (item, source, targetLanguage, seasonNumber, episodeNumber,
                releaseHint) =>
            item.title,
        upload: (file, targetLanguage) => file.name,
      ),
      sourceName: request.when(
        catalog: (item, source, targetLanguage, seasonNumber, episodeNumber,
                releaseHint) =>
            source.label,
        upload: (file, targetLanguage) => file.name,
      ),
      sourceType: request.map(
        catalog: (_) => TranslationSourceType.catalog,
        upload: (_) => TranslationSourceType.upload,
      ),
      status: TranslationJobStatus.completed,
      stageLabel: 'Translation ready',
      sourceLanguage: AppLanguage.english,
      targetLanguage: request.when(
        catalog: (item, source, targetLanguage, seasonNumber, episodeNumber,
                releaseHint) =>
            targetLanguage,
        upload: (file, targetLanguage) => targetLanguage,
      ),
      createdAt: DateTime(2026, 3, 14, 12),
      updatedAt: DateTime(2026, 3, 14, 12, 0, 4),
      format: request.when(
        catalog: (item, source, targetLanguage, seasonNumber, episodeNumber,
                releaseHint) =>
            source.format,
        upload: (file, targetLanguage) => file.format,
      ),
      lineCount: 2,
      durationMs: 6250,
      lines: const <SubtitleLine>[
        SubtitleLine(
          index: 1,
          startMs: 1000,
          endMs: 3500,
          originalText: 'We only have one clean pass.',
          translatedText: 'Version francaise: We only have one clean pass.',
        ),
      ],
      progress: 1,
    );
    _persistedJobs
      ..clear()
      ..add(job);

    yield TranslationProgressUpdate(
      progress: 1,
      stageLabel: 'Translation ready',
      job: job,
    );
  }
}

class _InMemoryHistoryRepository implements HistoryRepository {
  _InMemoryHistoryRepository(this._persistedJobs);

  final List<TranslationJob> _persistedJobs;

  @override
  Future<void> clear() async {
    _persistedJobs.clear();
  }

  @override
  Future<List<TranslationJob>> fetchJobs() async {
    return List<TranslationJob>.from(_persistedJobs);
  }

  @override
  Future<TranslationJob?> getJobById(String id) async {
    for (final job in _persistedJobs) {
      if (job.id == id) {
        return job;
      }
    }
    return null;
  }
}
