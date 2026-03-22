import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/data/repositories/catalog_search_repository.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

void main() {
  test('returns deterministic search matches and subtitle sources', () async {
    final repository = CatalogSearchRepository(_FakeCatalogApi());

    final results = await repository.searchTitles('dune');
    expect(results, isNotEmpty);
    expect(results.first.title, 'Dune: Part Two');

    final sources = await repository.fetchSubtitleSources(results.first.id);
    expect(sources.length, 3);
    expect(
      sources.map((source) => source.format),
      containsAll(<SubtitleFormat>[SubtitleFormat.srt, SubtitleFormat.vtt]),
    );
  });
}

class _FakeCatalogApi extends CatalogApi {
  _FakeCatalogApi() : super(Dio());

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) async {
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
    return <SubtitleSource>[
      const SubtitleSource(
        id: 'dune-webdl',
        label: 'English WEB-DL 1080p',
        releaseGroup: 'SubFlix Studio',
        format: SubtitleFormat.srt,
        hearingImpaired: false,
        lineCount: 612,
        downloads: 24870,
        rating: 4.9,
      ),
      const SubtitleSource(
        id: 'dune-retail',
        label: 'Retail Dialogue Match',
        releaseGroup: 'PrimeFrame',
        format: SubtitleFormat.vtt,
        hearingImpaired: true,
        lineCount: 628,
        downloads: 18420,
        rating: 4.7,
      ),
      const SubtitleSource(
        id: 'dune-bluray',
        label: 'BluRay Scene Sync',
        releaseGroup: 'Cinema Core',
        format: SubtitleFormat.srt,
        hearingImpaired: false,
        lineCount: 598,
        downloads: 12670,
        rating: 4.6,
      ),
    ];
  }
}
