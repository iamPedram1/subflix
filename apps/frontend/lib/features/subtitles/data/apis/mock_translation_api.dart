import 'dart:async';

import 'package:subflix/core/utils/fake_latency.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/subtitles/data/services/mock_translation_composer.dart';
import 'package:subflix/features/subtitles/domain/models/translation_progress_update.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

class MockTranslationApi {
  MockTranslationApi(this._composer);

  final MockTranslationComposer _composer;

  Stream<TranslationProgressUpdate> startTranslation(
    TranslationRequest request,
  ) async* {
    final title = request.when(
      catalog:
          (
            item,
            source,
            targetLanguage,
            seasonNumber,
            episodeNumber,
            releaseHint,
          ) => item.title,
      upload: (file, targetLanguage) => file.name,
    );

    if (title.toLowerCase().contains('fail')) {
      await fakeDelay();
      throw Exception('Mock translation failed. Retry to continue.');
    }

    yield const TranslationProgressUpdate(
      progress: 0.12,
      stageLabel: 'Preparing subtitle package',
    );
    await fakeDelay(const Duration(milliseconds: 550));

    yield const TranslationProgressUpdate(
      progress: 0.34,
      stageLabel: 'Aligning timestamps and scene context',
    );
    await fakeDelay(const Duration(milliseconds: 600));

    yield const TranslationProgressUpdate(
      progress: 0.58,
      stageLabel: 'Generating subtitle translation',
    );
    await fakeDelay(const Duration(milliseconds: 700));

    yield const TranslationProgressUpdate(
      progress: 0.82,
      stageLabel: 'Applying readability pass',
    );
    await fakeDelay(const Duration(milliseconds: 650));

    final job = request.map(
      catalog: (catalogRequest) {
        final lines = _composer.buildCatalogLines(
          title: catalogRequest.item.title,
          targetLanguage: catalogRequest.targetLanguage,
        );
        return TranslationJob(
          id: 'job_${catalogRequest.item.id}_${catalogRequest.targetLanguage.code}_${DateTime.now().millisecondsSinceEpoch}',
          title: catalogRequest.item.title,
          sourceName: catalogRequest.source.label,
          sourceType: TranslationSourceType.catalog,
          status: TranslationJobStatus.completed,
          stageLabel: 'Translation ready',
          sourceLanguage: AppLanguage.english,
          targetLanguage: catalogRequest.targetLanguage,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          format: catalogRequest.source.format,
          lineCount: lines.length,
          durationMs: lines.isEmpty ? 0 : lines.last.endMs,
          lines: lines,
          progress: 1,
        );
      },
      upload: (uploadRequest) {
        final lines = _composer.buildUploadedLines(
          uploadRequest.file.lines,
          uploadRequest.targetLanguage,
        );
        return TranslationJob(
          id: 'job_${uploadRequest.file.id}_${uploadRequest.targetLanguage.code}_${DateTime.now().millisecondsSinceEpoch}',
          title: uploadRequest.file.name,
          sourceName: uploadRequest.file.name,
          sourceType: TranslationSourceType.upload,
          status: TranslationJobStatus.completed,
          stageLabel: 'Translation ready',
          sourceLanguage: uploadRequest.file.sourceLanguage,
          targetLanguage: uploadRequest.targetLanguage,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          format: uploadRequest.file.format,
          lineCount: lines.length,
          durationMs: lines.isEmpty ? 0 : lines.last.endMs,
          lines: lines,
          progress: 1,
        );
      },
    );

    yield TranslationProgressUpdate(
      progress: 1,
      stageLabel: 'Translation ready',
      job: job,
    );
  }
}
