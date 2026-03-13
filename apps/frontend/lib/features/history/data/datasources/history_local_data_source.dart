import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/subtitles/data/services/mock_translation_composer.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

class HistoryLocalDataSource {
  HistoryLocalDataSource(this._sharedPreferences, this._composer);

  static const String _jobsKey = 'subflix.translation_jobs';

  final SharedPreferences _sharedPreferences;
  final MockTranslationComposer _composer;

  Future<List<TranslationJob>> readJobs() async {
    final values = _sharedPreferences.getStringList(_jobsKey);
    if (values == null || values.isEmpty) {
      final seededJobs = _seedJobs();
      await writeJobs(seededJobs);
      return seededJobs;
    }

    return values
        .map(
          (value) => TranslationJob.fromJson(
            jsonDecode(value) as Map<String, dynamic>,
          ),
        )
        .toList(growable: false);
  }

  Future<void> writeJobs(List<TranslationJob> jobs) async {
    final encoded = jobs
        .map((job) => jsonEncode(job.toJson()))
        .toList(growable: false);
    await _sharedPreferences.setStringList(_jobsKey, encoded);
  }

  List<TranslationJob> _seedJobs() {
    final duneLines = _composer.buildCatalogLines(
      title: 'Dune: Part Two',
      targetLanguage: AppLanguage.arabic,
    );
    final bearLines = _composer.buildCatalogLines(
      title: 'The Bear',
      targetLanguage: AppLanguage.spanish,
    );
    final now = DateTime.now();

    return <TranslationJob>[
      TranslationJob(
        id: 'seed_dune_ar',
        title: 'Dune: Part Two',
        sourceName: 'English WEB-DL 1080p',
        sourceType: TranslationSourceType.catalog,
        status: TranslationJobStatus.completed,
        sourceLanguage: AppLanguage.english,
        targetLanguage: AppLanguage.arabic,
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
        format: SubtitleFormat.srt,
        lines: duneLines,
        progress: 1,
      ),
      TranslationJob(
        id: 'seed_bear_es',
        title: 'The Bear - Episode 2',
        sourceName: 'Retail Dialogue Match',
        sourceType: TranslationSourceType.catalog,
        status: TranslationJobStatus.completed,
        sourceLanguage: AppLanguage.english,
        targetLanguage: AppLanguage.spanish,
        createdAt: now.subtract(const Duration(days: 1, hours: 3)),
        updatedAt: now.subtract(const Duration(days: 1, hours: 3)),
        format: SubtitleFormat.vtt,
        lines: bearLines,
        progress: 1,
      ),
    ];
  }
}
