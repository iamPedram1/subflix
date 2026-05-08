import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/utils/subtitle_formatter.dart';
import 'package:subflix/core/utils/subtitle_parser.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

void main() {
  test('parses demo subtitles and formats translated output as srt', () {
    final parser = SubtitleParser();
    final formatter = SubtitleFormatter();

    final file = parser.parseDemoSample();
    expect(file.format, SubtitleFormat.srt);
    expect(file.lines, isNotEmpty);

    final translatedJob = TranslationJob(
      id: 'demo',
      title: 'Demo',
      sourceName: file.name,
      sourceType: TranslationSourceType.upload,
      status: TranslationJobStatus.completed,
      stageLabel: 'Translation ready',
      sourceLanguage: AppLanguage.english,
      targetLanguage: AppLanguage.spanish,
      createdAt: DateTime(2026, 3, 13),
      updatedAt: DateTime(2026, 3, 13),
      format: file.format,
      lineCount: file.lineCount,
      durationMs: file.durationMs,
      lines: file.lines
          .map(
            (line) => line.copyWith(translatedText: 'ES: ${line.originalText}'),
          )
          .toList(growable: false),
      progress: 1,
    );

    final output = formatter.formatJob(translatedJob);
    expect(output, contains('1'));
    expect(output, contains('-->'));
    expect(output, contains('ES:'));
  });
}
