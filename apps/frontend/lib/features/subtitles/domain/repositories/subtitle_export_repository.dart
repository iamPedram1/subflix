import 'package:subflix/features/shared/domain/models/translation_job.dart';

class SubtitleExportResult {
  const SubtitleExportResult({required this.fileName, required this.path});

  final String fileName;
  final String path;
}

abstract interface class SubtitleExportRepository {
  Future<SubtitleExportResult> exportJob(TranslationJob job);
}
