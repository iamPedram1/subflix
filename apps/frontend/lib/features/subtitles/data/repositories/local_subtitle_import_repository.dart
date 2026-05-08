import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:subflix/core/utils/subtitle_parser.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_import_repository.dart';

class SubtitleImportCancelledException implements Exception {
  const SubtitleImportCancelledException();
}

class LocalSubtitleImportRepository implements SubtitleImportRepository {
  LocalSubtitleImportRepository(this._parser);

  final SubtitleParser _parser;

  @override
  Future<SubtitleFile> loadDemoFile() async {
    return _parser.parseDemoSample();
  }

  @override
  Future<SubtitleFile> pickSubtitleFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const <String>['srt', 'vtt'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      throw const SubtitleImportCancelledException();
    }

    final pickedFile = result.files.single;
    final content = await _readContent(pickedFile);

    return _parser.parse(
      fileName: pickedFile.name,
      content: content,
      originalPath: pickedFile.path,
    );
  }

  Future<String> _readContent(PlatformFile file) async {
    if (file.bytes != null) {
      return utf8.decode(file.bytes!);
    }

    final filePath = file.path;
    if (filePath == null) {
      throw const FormatException(
        'The selected subtitle file could not be read.',
      );
    }

    return File(filePath).readAsString();
  }
}
