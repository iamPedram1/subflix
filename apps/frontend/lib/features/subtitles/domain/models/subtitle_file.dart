// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

part 'subtitle_file.freezed.dart';
part 'subtitle_file.g.dart';

@freezed
abstract class SubtitleFile with _$SubtitleFile {
  const factory SubtitleFile({
    required String id,
    @JsonKey(name: 'fileName') required String name,
    required SubtitleFormat format,
    required AppLanguage sourceLanguage,
    required int lineCount,
    required int durationMs,
    @Default(<SubtitleLine>[]) List<SubtitleLine> lines,
    String? originalPath,
  }) = _SubtitleFile;

  factory SubtitleFile.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFileFromJson(json);
}
