import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:subflix/core/network/content_disposition.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_export_repository.dart';

/// Downloads translated subtitle content from the backend and saves it locally.
class BackendSubtitleExportRepository implements SubtitleExportRepository {
  BackendSubtitleExportRepository(this._api);

  final TranslationJobsApi _api;

  @override
  Future<SubtitleExportResult> exportJob(TranslationJob job) async {
    final response = await _api.exportJob(
      jobId: job.id,
      format: job.format.name,
    );
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final fallbackName =
        '${_sanitize(job.title)}_${job.targetLanguage.code}.${job.format.name}';
    final fileName = extractFileNameFromContentDisposition(
          response.response.headers.value('content-disposition'),
        ) ??
        fallbackName;
    final filePath = path.join(documentsDirectory.path, fileName);
    final file = File(filePath);
    await file.writeAsString(response.data);
    return SubtitleExportResult(fileName: fileName, path: file.path);
  }

  String _sanitize(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  }
}
