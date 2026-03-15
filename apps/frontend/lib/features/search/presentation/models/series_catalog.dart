import 'package:subflix/features/search/domain/models/movie_search_item.dart';

class SeasonDetails {
  const SeasonDetails({
    required this.number,
    required this.episodeCount,
    this.year,
  });

  final int number;
  final int episodeCount;
  final int? year;
}

class SeriesDetails {
  const SeriesDetails({required this.seasons});

  final List<SeasonDetails> seasons;
}

SeriesDetails resolveSeriesDetails(MovieSearchItem item) {
  final details = _seriesCatalog[item.id];
  if (details != null) {
    return details;
  }

  return SeriesDetails(
    seasons: <SeasonDetails>[
      SeasonDetails(number: 1, episodeCount: 8, year: item.year),
    ],
  );
}

const Map<String, SeriesDetails> _seriesCatalog = <String, SeriesDetails>{
  'breaking_bad': SeriesDetails(
    seasons: <SeasonDetails>[
      SeasonDetails(number: 1, episodeCount: 7, year: 2008),
      SeasonDetails(number: 2, episodeCount: 13, year: 2009),
      SeasonDetails(number: 3, episodeCount: 13, year: 2010),
      SeasonDetails(number: 4, episodeCount: 13, year: 2011),
      SeasonDetails(number: 5, episodeCount: 16, year: 2012),
    ],
  ),
  'severance': SeriesDetails(
    seasons: <SeasonDetails>[
      SeasonDetails(number: 1, episodeCount: 9, year: 2022),
      SeasonDetails(number: 2, episodeCount: 10, year: 2024),
    ],
  ),
  'the_bear': SeriesDetails(
    seasons: <SeasonDetails>[
      SeasonDetails(number: 1, episodeCount: 8, year: 2022),
      SeasonDetails(number: 2, episodeCount: 10, year: 2023),
      SeasonDetails(number: 3, episodeCount: 10, year: 2024),
    ],
  ),
  'the_last_of_us': SeriesDetails(
    seasons: <SeasonDetails>[
      SeasonDetails(number: 1, episodeCount: 9, year: 2023),
    ],
  ),
};
