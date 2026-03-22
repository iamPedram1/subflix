import 'package:subflix/core/utils/fake_latency.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

class MockSearchApi {
  static const List<MovieSearchItem> _catalog = <MovieSearchItem>[
    MovieSearchItem(
      id: 'inception',
      title: 'Inception',
      year: 2010,
      mediaType: SearchMediaType.movie,
      posterUrl: 'https://image.tmdb.org/t/p/w342/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg',
      synopsis:
          'A dream-hacking team tries to plant an idea before time runs out.',
      genres: <String>['Sci-Fi', 'Thriller'],
      runtimeMinutes: 148,
      popularity: 9.4,
    ),
    MovieSearchItem(
      id: 'dune_part_two',
      title: 'Dune: Part Two',
      year: 2024,
      mediaType: SearchMediaType.movie,
      posterUrl: 'https://image.tmdb.org/t/p/w342/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
      synopsis:
          'Paul embraces destiny while balancing prophecy, power, and survival.',
      genres: <String>['Sci-Fi', 'Epic'],
      runtimeMinutes: 166,
      popularity: 9.6,
    ),
    MovieSearchItem(
      id: 'breaking_bad',
      title: 'Breaking Bad',
      year: 2008,
      mediaType: SearchMediaType.series,
      posterUrl: 'https://image.tmdb.org/t/p/w342/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg',
      synopsis:
          'A chemistry teacher remakes himself through crime and consequence.',
      genres: <String>['Crime', 'Drama'],
      runtimeMinutes: 49,
      popularity: 9.7,
    ),
    MovieSearchItem(
      id: 'severance',
      title: 'Severance',
      year: 2022,
      mediaType: SearchMediaType.series,
      posterUrl: 'https://image.tmdb.org/t/p/w342/7d6EY00g1c39SGZOoCJ5Py9nNth.jpg',
      synopsis:
          'Office workers split memory and identity in a meticulous corporate mystery.',
      genres: <String>['Sci-Fi', 'Drama'],
      runtimeMinutes: 54,
      popularity: 9.2,
    ),
    MovieSearchItem(
      id: 'interstellar',
      title: 'Interstellar',
      year: 2014,
      mediaType: SearchMediaType.movie,
      posterUrl: 'https://image.tmdb.org/t/p/w342/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      synopsis:
          'A desperate mission leaves Earth to find a future beyond collapse.',
      genres: <String>['Sci-Fi', 'Adventure'],
      runtimeMinutes: 169,
      popularity: 9.5,
    ),
    MovieSearchItem(
      id: 'the_bear',
      title: 'The Bear',
      year: 2022,
      mediaType: SearchMediaType.series,
      posterUrl: 'https://image.tmdb.org/t/p/w342/sHFlbKS3WLqMnp9t2ghADIJFnuQ.jpg',
      synopsis:
          'An ambitious chef inherits a chaotic kitchen and tries to rebuild it.',
      genres: <String>['Drama', 'Comedy'],
      runtimeMinutes: 31,
      popularity: 8.8,
    ),
    MovieSearchItem(
      id: 'blade_runner_2049',
      title: 'Blade Runner 2049',
      year: 2017,
      mediaType: SearchMediaType.movie,
      posterUrl: 'https://image.tmdb.org/t/p/w342/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
      synopsis:
          'A replicant hunter uncovers a buried secret that could rewrite the future.',
      genres: <String>['Sci-Fi', 'Noir'],
      runtimeMinutes: 164,
      popularity: 9.1,
    ),
    MovieSearchItem(
      id: 'the_last_of_us',
      title: 'The Last of Us',
      year: 2023,
      mediaType: SearchMediaType.series,
      posterUrl: 'https://image.tmdb.org/t/p/w342/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg',
      synopsis:
          'Two survivors cross a fractured world where every choice costs more.',
      genres: <String>['Drama', 'Adventure'],
      runtimeMinutes: 58,
      popularity: 9.3,
    ),
  ];

  Future<List<MovieSearchItem>> searchTitles(String query) async {
    await fakeDelay(Duration(milliseconds: query.trim().isEmpty ? 200 : 600));

    final normalized = query.trim().toLowerCase();
    if (normalized.contains('error')) {
      throw Exception('Mock search failed. Please try another title.');
    }

    if (normalized.isEmpty) {
      return const <MovieSearchItem>[];
    }

    return _catalog
        .where(
          (item) =>
              item.title.toLowerCase().contains(normalized) ||
              item.genres.any(
                (genre) => genre.toLowerCase().contains(normalized),
              ),
        )
        .toList(growable: false);
  }

  Future<CatalogMediaDetails?> fetchMediaDetails(String mediaId) async {
    await fakeDelay(const Duration(milliseconds: 700));

    MovieSearchItem? item;
    for (final entry in _catalog) {
      if (entry.id == mediaId) {
        item = entry;
        break;
      }
    }
    if (item == null) {
      return null;
    }

    return _detailsCatalog[mediaId] ??
        CatalogMediaDetails(
          id: item.id,
          title: item.title,
          year: item.year,
          mediaType: item.mediaType,
          posterUrl: item.posterUrl,
          synopsis: item.synopsis,
          genres: item.genres,
          runtimeMinutes: item.runtimeMinutes,
          popularity: item.popularity,
          providerMediaType: item.mediaType == SearchMediaType.movie
              ? CatalogProviderMediaType.movie
              : CatalogProviderMediaType.tv,
        );
  }

  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) async {
    await fakeDelay(const Duration(milliseconds: 900));

    if (mediaId.contains('error')) {
      throw Exception('Subtitles are temporarily unavailable for this title.');
    }

    return <SubtitleSource>[
      SubtitleSource(
        id: '$mediaId-webdl',
        label: 'English WEB-DL 1080p',
        releaseGroup: 'SubFlix Studio',
        format: SubtitleFormat.srt,
        hearingImpaired: false,
        lineCount: 612,
        downloads: 24870,
        rating: 4.9,
      ),
      SubtitleSource(
        id: '$mediaId-retail',
        label: 'Retail Dialogue Match',
        releaseGroup: 'PrimeFrame',
        format: SubtitleFormat.vtt,
        hearingImpaired: true,
        lineCount: 628,
        downloads: 18420,
        rating: 4.7,
      ),
      SubtitleSource(
        id: '$mediaId-bluray',
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

final Map<String, CatalogMediaDetails> _detailsCatalog =
    <String, CatalogMediaDetails>{
      'inception': CatalogMediaDetails(
        id: 'inception',
        title: 'Inception',
        year: 2010,
        mediaType: SearchMediaType.movie,
        posterUrl:
            'https://image.tmdb.org/t/p/w342/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg',
        synopsis:
            'A dream-hacking team tries to plant an idea before time runs out.',
        genres: <String>['Sci-Fi', 'Thriller'],
        runtimeMinutes: 148,
        popularity: 9.4,
        tmdbId: 27205,
        imdbId: 'tt1375666',
        originalTitle: 'Inception',
        providerMediaType: CatalogProviderMediaType.movie,
      ),
      'breaking_bad': CatalogMediaDetails(
        id: 'breaking_bad',
        title: 'Breaking Bad',
        year: 2008,
        mediaType: SearchMediaType.series,
        posterUrl:
            'https://image.tmdb.org/t/p/w342/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg',
        synopsis:
            'A chemistry teacher remakes himself through crime and consequence.',
        genres: <String>['Crime', 'Drama'],
        runtimeMinutes: 49,
        popularity: 9.7,
        tmdbId: 1396,
        imdbId: 'tt0903747',
        originalTitle: 'Breaking Bad',
        providerMediaType: CatalogProviderMediaType.tv,
        seasonsCount: 5,
        episodesCount: 62,
        seasons: const <CatalogSeasonDetails>[
          CatalogSeasonDetails(
            seasonNumber: 1,
            name: 'Season 1',
            episodeCount: 7,
            airDate: '2008-01-20',
          ),
          CatalogSeasonDetails(
            seasonNumber: 2,
            name: 'Season 2',
            episodeCount: 13,
            airDate: '2009-03-08',
          ),
          CatalogSeasonDetails(
            seasonNumber: 3,
            name: 'Season 3',
            episodeCount: 13,
            airDate: '2010-03-21',
          ),
          CatalogSeasonDetails(
            seasonNumber: 4,
            name: 'Season 4',
            episodeCount: 13,
            airDate: '2011-07-17',
          ),
          CatalogSeasonDetails(
            seasonNumber: 5,
            name: 'Season 5',
            episodeCount: 16,
            airDate: '2012-07-15',
          ),
        ],
      ),
      'severance': CatalogMediaDetails(
        id: 'severance',
        title: 'Severance',
        year: 2022,
        mediaType: SearchMediaType.series,
        posterUrl:
            'https://image.tmdb.org/t/p/w342/7d6EY00g1c39SGZOoCJ5Py9nNth.jpg',
        synopsis:
            'Office workers split memory and identity in a meticulous corporate mystery.',
        genres: <String>['Sci-Fi', 'Drama'],
        runtimeMinutes: 54,
        popularity: 9.2,
        tmdbId: 95396,
        imdbId: 'tt11280740',
        originalTitle: 'Severance',
        providerMediaType: CatalogProviderMediaType.tv,
        seasonsCount: 2,
        episodesCount: 19,
        seasons: const <CatalogSeasonDetails>[
          CatalogSeasonDetails(
            seasonNumber: 1,
            name: 'Season 1',
            episodeCount: 9,
            airDate: '2022-02-18',
          ),
          CatalogSeasonDetails(
            seasonNumber: 2,
            name: 'Season 2',
            episodeCount: 10,
            airDate: '2025-01-17',
          ),
        ],
      ),
    };
