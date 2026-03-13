import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

class SubtitleFormatter {
  String formatJob(TranslationJob job) {
    return switch (job.format) {
      SubtitleFormat.srt => _formatSrt(job),
      SubtitleFormat.vtt => _formatVtt(job),
    };
  }

  String _formatSrt(TranslationJob job) {
    final buffer = StringBuffer();
    for (final line in job.lines) {
      buffer
        ..writeln(line.index)
        ..writeln(
          '${_formatTime(line.startMs, decimalSeparator: ',')} --> ${_formatTime(line.endMs, decimalSeparator: ',')}',
        )
        ..writeln(line.translatedText ?? line.originalText)
        ..writeln();
    }
    return buffer.toString().trimRight();
  }

  String _formatVtt(TranslationJob job) {
    final buffer = StringBuffer('WEBVTT\n\n');
    for (final line in job.lines) {
      buffer
        ..writeln(
          '${_formatTime(line.startMs, decimalSeparator: '.')} --> ${_formatTime(line.endMs, decimalSeparator: '.')}',
        )
        ..writeln(line.translatedText ?? line.originalText)
        ..writeln();
    }
    return buffer.toString().trimRight();
  }

  String _formatTime(int milliseconds, {required String decimalSeparator}) {
    final totalSeconds = milliseconds ~/ 1000;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    final millis = milliseconds % 1000;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}'
        '$decimalSeparator'
        '${millis.toString().padLeft(3, '0')}';
  }
}
