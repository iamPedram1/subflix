import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

import 'shared/test_helpers.dart';

void main() {
  test(
    'default repositories provide local settings/history and backend search',
    () async {
      final sharedPreferences = await createMockSharedPreferences();
      final catalogApi = _FakeCatalogApi();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          catalogApiProvider.overrideWithValue(catalogApi),
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
        synopsis: 'Mock backend result.',
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
