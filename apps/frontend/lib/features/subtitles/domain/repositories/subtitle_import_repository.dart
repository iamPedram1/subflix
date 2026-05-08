import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';

abstract interface class SubtitleImportRepository {
  Future<SubtitleFile> pickSubtitleFile();

  Future<SubtitleFile> loadDemoFile();
}
