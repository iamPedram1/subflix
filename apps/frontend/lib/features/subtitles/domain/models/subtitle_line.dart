// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_line.freezed.dart';
part 'subtitle_line.g.dart';

@freezed
abstract class SubtitleLine with _$SubtitleLine {
  const factory SubtitleLine({
    @JsonKey(name: 'cueIndex') required int index,
    required int startMs,
    required int endMs,
    required String originalText,
    String? translatedText,
  }) = _SubtitleLine;

  factory SubtitleLine.fromJson(Map<String, dynamic> json) =>
      _$SubtitleLineFromJson(json);
}
