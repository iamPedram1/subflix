import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

part 'subtitle_source.freezed.dart';
part 'subtitle_source.g.dart';

@freezed
abstract class SubtitleSource with _$SubtitleSource {
  const factory SubtitleSource({
    required String id,
    required String label,
    String? languageCode,
    String? languageName,
    required String releaseGroup,
    required SubtitleFormat format,
    required bool hearingImpaired,
    required int lineCount,
    required int downloads,
    required double rating,
  }) = _SubtitleSource;

  factory SubtitleSource.fromJson(Map<String, dynamic> json) =>
      _$SubtitleSourceFromJson(json);
}
