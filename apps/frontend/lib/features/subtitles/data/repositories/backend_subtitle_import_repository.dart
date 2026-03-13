import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:subflix/core/utils/subtitle_parser.dart';
import 'package:subflix/features/subtitles/data/apis/subtitles_api.dart';
import 'package:subflix/features/subtitles/data/repositories/local_subtitle_import_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_import_repository.dart';

/// Uploads local subtitle files to the backend parser and returns the summary.
class BackendSubtitleImportRepository implements SubtitleImportRepository {
  BackendSubtitleImportRepository(this._api, this._parser);

  final SubtitlesApi _api;
  final SubtitleParser _parser;

  @override
  Future<SubtitleFile> loadDemoFile() async {
    return _api.parseFile(
      fileName: _parser.demoSampleFileName,
      bytes: _parser.demoSampleBytes,
    );
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
    final bytes = await _readBytes(pickedFile);
    final file = await _api.parseFile(fileName: pickedFile.name, bytes: bytes);
    return file.copyWith(originalPath: pickedFile.path);
  }

  Future<Uint8List> _readBytes(PlatformFile file) async {
    if (file.bytes != null) {
      return file.bytes!;
    }

    final filePath = file.path;
    if (filePath == null) {
      throw const FormatException(
        'The selected subtitle file could not be read.',
      );
    }

    final content = await File(filePath).readAsString();
    return Uint8List.fromList(utf8.encode(content));
  }
}
