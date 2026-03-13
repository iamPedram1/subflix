import 'package:subflix/core/utils/fake_latency.dart';
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

  Future<List<SubtitleSource>> fetchSubtitleSources(String mediaId) async {
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
