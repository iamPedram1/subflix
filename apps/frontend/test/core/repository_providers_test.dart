import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/settings/data/apis/preferences_api.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

import 'shared/test_helpers.dart';

void main() {
  test(
    'default repositories provide API settings/history/search',
    () async {
      final sharedPreferences = await createMockSharedPreferences();
      final catalogApi = _FakeCatalogApi();
      final preferencesApi = _FakePreferencesApi();
      final translationJobsApi = _FakeTranslationJobsApi();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          catalogApiProvider.overrideWithValue(catalogApi),
          preferencesApiProvider.overrideWithValue(preferencesApi),
          translationJobsApiProvider.overrideWithValue(translationJobsApi),
        ],
      );
      addTearDown(container.dispose);

      final preferences = await container
          .read(settingsRepositoryProvider)
          .loadPreferences();
      expect(preferences.hasSeenOnboarding, isFalse);
      expect(preferences.preferredTargetLanguage, AppLanguage.english);

      final searchResults = await container
          .read(searchRepositoryProvider)
          .searchTitles('dune');
      expect(catalogApi.queries, <String>['dune']);
      expect(searchResults.map((item) => item.title), contains('Dune: Part Two'));

      final history = await container
          .read(historyRepositoryProvider)
          .fetchJobs();
      expect(preferencesApi.getPreferencesCalls, 1);
      expect(translationJobsApi.listJobsCalls, 1);
      expect(history, isNotEmpty);
    },
  );
}

class _FakeCatalogApi extends CatalogApi {
  _FakeCatalogApi() : super(Dio());

  final List<String> queries = <String>[];

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) async {
    queries.add(query);
    return <MovieSearchItem>[
      const MovieSearchItem(
        id: 'dune_part_two',
        title: 'Dune: Part Two',
        year: 2024,
        mediaType: SearchMediaType.movie,
        synopsis: 'API result.',
        genres: <String>['Sci-Fi'],
        runtimeMinutes: 166,
        popularity: 9.6,
      ),
    ];
  }

  @override
  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) async {
    return const <SubtitleSource>[];
  }
}

class _FakePreferencesApi extends PreferencesApi {
  _FakePreferencesApi() : super(Dio());

  int getPreferencesCalls = 0;

  @override
  Future<UserPreference> getPreferences() async {
    getPreferencesCalls += 1;
    return const UserPreference(
      hasSeenOnboarding: false,
      preferredTargetLanguage: AppLanguage.english,
      themePreference: ThemePreference.system,
    );
  }
}

class _FakeTranslationJobsApi extends TranslationJobsApi {
  _FakeTranslationJobsApi() : super(Dio());

  int listJobsCalls = 0;

  @override
  Future<List<TranslationJob>> listJobs({int page = 1, int limit = 100}) async {
    listJobsCalls += 1;
    return <TranslationJob>[
      TranslationJob(
        id: 'job-1',
        title: 'Dune: Part Two',
        sourceName: 'OpenSubtitles',
        sourceType: TranslationSourceType.catalog,
        status: TranslationJobStatus.completed,
        stageLabel: 'Completed',
        sourceLanguage: AppLanguage.english,
        targetLanguage: AppLanguage.arabic,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 1, 0, 5),
        format: SubtitleFormat.srt,
        lineCount: 42,
        durationMs: 120000,
        progress: 1,
      ),
    ];
  }
}
