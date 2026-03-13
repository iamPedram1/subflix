import 'dart:convert';

import 'package:path/path.dart' as path;

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

class SubtitleParser {
  SubtitleFile parse({
    required String fileName,
    required String content,
    String? originalPath,
  }) {
    final normalizedContent = content.replaceAll('\r\n', '\n').trim();
    final format = _formatFromFileName(fileName);
    final lines = switch (format) {
      SubtitleFormat.srt => _parseSrt(normalizedContent),
      SubtitleFormat.vtt => _parseVtt(normalizedContent),
    };

    if (lines.isEmpty) {
      throw const FormatException('No subtitle cues were found in this file.');
    }

    final safeName = path.basename(fileName);
    return SubtitleFile(
      id: '${safeName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}_${DateTime.now().millisecondsSinceEpoch}',
      name: safeName,
      format: format,
      sourceLanguage: AppLanguage.english,
      lines: lines,
      originalPath: originalPath,
    );
  }

  SubtitleFile parseDemoSample() {
    return parse(
      fileName: 'subflix_demo.srt',
      content: utf8.decode(_demoSample),
    );
  }

  SubtitleFormat _formatFromFileName(String fileName) {
    return switch (path.extension(fileName).toLowerCase()) {
      '.srt' => SubtitleFormat.srt,
      '.vtt' => SubtitleFormat.vtt,
      _ => throw const FormatException(
        'Unsupported subtitle format. Please choose an .srt or .vtt file.',
      ),
    };
  }

  List<SubtitleLine> _parseSrt(String content) {
    final blocks = content.split(RegExp(r'\n\s*\n'));
    final lines = <SubtitleLine>[];

    for (final block in blocks) {
      final rows = block
          .split('\n')
          .map((row) => row.trim())
          .where((row) => row.isNotEmpty)
          .toList(growable: false);

      if (rows.length < 3) {
        continue;
      }

      final timeLine = rows[1];
      final cueText = rows.skip(2).join(' ');
      final timeParts = timeLine.split(' --> ');
      if (timeParts.length != 2) {
        continue;
      }

      lines.add(
        SubtitleLine(
          index: int.tryParse(rows.first) ?? (lines.length + 1),
          startMs: _parseTimestamp(timeParts.first),
          endMs: _parseTimestamp(timeParts.last),
          originalText: cueText,
        ),
      );
    }

    return lines;
  }

  List<SubtitleLine> _parseVtt(String content) {
    final sanitized = content.replaceFirst(RegExp(r'^WEBVTT\s*'), '').trim();
    final blocks = sanitized.split(RegExp(r'\n\s*\n'));
    final lines = <SubtitleLine>[];

    for (final block in blocks) {
      final rows = block
          .split('\n')
          .map((row) => row.trim())
          .where((row) => row.isNotEmpty)
          .toList(growable: false);

      if (rows.length < 2) {
        continue;
      }

      final timeIndex = rows.indexWhere((row) => row.contains('-->'));
      if (timeIndex == -1 || timeIndex == rows.length - 1) {
        continue;
      }

      final timeParts = rows[timeIndex].split(' --> ');
      if (timeParts.length != 2) {
        continue;
      }

      lines.add(
        SubtitleLine(
          index: lines.length + 1,
          startMs: _parseTimestamp(timeParts.first),
          endMs: _parseTimestamp(timeParts.last),
          originalText: rows.skip(timeIndex + 1).join(' '),
        ),
      );
    }

    return lines;
  }

  int _parseTimestamp(String raw) {
    final normalized = raw.split(' ').first.replaceAll(',', '.');
    final pieces = normalized.split(':');
    if (pieces.length != 3) {
      throw FormatException('Unsupported timestamp: $raw');
    }

    final hour = int.parse(pieces[0]);
    final minute = int.parse(pieces[1]);
    final secondParts = pieces[2].split('.');
    final second = int.parse(secondParts[0]);
    final millisecond = int.parse(secondParts[1].padRight(3, '0'));

    return (((hour * 60) + minute) * 60 + second) * 1000 + millisecond;
  }
}

const List<int> _demoSample = <int>[
  49,
  10,
  48,
  48,
  58,
  48,
  48,
  58,
  48,
  49,
  44,
  48,
  48,
  48,
  32,
  45,
  45,
  62,
  32,
  48,
  48,
  58,
  48,
  48,
  58,
  48,
  52,
  44,
  50,
  48,
  48,
  10,
  84,
  104,
  101,
  32,
  102,
  105,
  114,
  115,
  116,
  32,
  100,
  114,
  97,
  102,
  116,
  32,
  119,
  97,
  115,
  32,
  99,
  104,
  97,
  111,
  115,
  44,
  32,
  98,
  117,
  116,
  32,
  116,
  104,
  101,
  32,
  102,
  105,
  110,
  97,
  108,
  32,
  99,
  117,
  116,
  32,
  102,
  101,
  101,
  108,
  115,
  32,
  105,
  110,
  101,
  118,
  105,
  116,
  97,
  98,
  108,
  101,
  46,
  10,
  10,
  50,
  10,
  48,
  48,
  58,
  48,
  48,
  58,
  48,
  54,
  44,
  48,
  48,
  48,
  32,
  45,
  45,
  62,
  32,
  48,
  48,
  58,
  48,
  48,
  58,
  48,
  57,
  44,
  57,
  48,
  48,
  10,
  84,
  114,
  117,
  115,
  116,
  32,
  116,
  104,
  101,
  32,
  115,
  117,
  98,
  116,
  105,
  116,
  108,
  101,
  115,
  46,
  32,
  84,
  104,
  101,
  121,
  32,
  99,
  97,
  114,
  114,
  121,
  32,
  109,
  111,
  114,
  101,
  32,
  116,
  104,
  97,
  110,
  32,
  100,
  105,
  97,
  108,
  111,
  103,
  117,
  101,
  32,
  116,
  111,
  110,
  105,
  103,
  104,
  116,
  46,
  10,
  10,
  51,
  10,
  48,
  48,
  58,
  48,
  48,
  58,
  49,
  49,
  44,
  48,
  48,
  48,
  32,
  45,
  45,
  62,
  32,
  48,
  48,
  58,
  48,
  48,
  58,
  49,
  52,
  44,
  54,
  48,
  48,
  10,
  84,
  104,
  105,
  115,
  32,
  105,
  115,
  32,
  116,
  104,
  101,
  32,
  112,
  97,
  114,
  116,
  32,
  119,
  104,
  101,
  114,
  101,
  32,
  116,
  104,
  101,
  32,
  105,
  109,
  112,
  111,
  115,
  115,
  105,
  98,
  108,
  101,
  32,
  115,
  116,
  97,
  114,
  116,
  115,
  32,
  115,
  111,
  117,
  110,
  100,
  105,
  110,
  103,
  32,
  112,
  114,
  97,
  99,
  116,
  105,
  99,
  97,
  108,
  46,
];
