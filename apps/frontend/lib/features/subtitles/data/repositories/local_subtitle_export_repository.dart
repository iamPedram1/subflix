import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:subflix/core/utils/subtitle_formatter.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_export_repository.dart';

class LocalSubtitleExportRepository implements SubtitleExportRepository {
  LocalSubtitleExportRepository(this._formatter);

  final SubtitleFormatter _formatter;

  @override
  Future<SubtitleExportResult> exportJob(TranslationJob job) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final sanitizedTitle = job.title.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '_',
    );
    final fileName =
        '${sanitizedTitle}_${job.targetLanguage.code}.${job.format.name}';
    final filePath = path.join(documentsDirectory.path, fileName);
    final file = File(filePath);
    await file.writeAsString(_formatter.formatJob(job));
    return SubtitleExportResult(fileName: fileName, path: file.path);
  }
}
