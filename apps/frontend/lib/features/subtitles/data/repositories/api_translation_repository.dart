import 'dart:async';

import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/subtitles/domain/models/translation_preview_page.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

/// Starts API translation jobs and polls for progress until completion.
class ApiTranslationRepository implements TranslationRepository {
  ApiTranslationRepository(this._api);

  final TranslationJobsApi _api;

  static const Duration _pollInterval = Duration(milliseconds: 900);

  @override
  Future<TranslationPreviewPage> fetchPreview({
    required String jobId,
    String query = '',
    int page = 1,
    int limit = 100,
  }) {
    return _api.getPreview(
      jobId: jobId,
      query: query,
      page: page,
      limit: limit,
    );
  }

  @override
  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) async* {
    var job = await _api.createJob(request);
    yield _toUpdate(job);

    while (_shouldPoll(job.status)) {
      await Future<void>.delayed(_pollInterval);
      job = await _api.getJob(job.id);

      if (job.status == TranslationJobStatus.failed) {
        throw ApiException(
          message: job.errorMessage ?? 'Translation failed to complete.',
          statusCode: 400,
        );
      }

      yield _toUpdate(job);
    }
  }

  TranslationProgressUpdate _toUpdate(TranslationJob job) {
    return TranslationProgressUpdate(
      progress: job.progress,
      stageLabel: job.stageLabel,
      job: job.status == TranslationJobStatus.completed ? job : null,
    );
  }

  bool _shouldPoll(TranslationJobStatus status) {
    return status == TranslationJobStatus.queued ||
        status == TranslationJobStatus.translating;
  }
}
