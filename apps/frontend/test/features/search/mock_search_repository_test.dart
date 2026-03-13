import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/features/search/data/apis/mock_search_api.dart';
import 'package:subflix/features/search/data/repositories/mock_search_repository.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';

void main() {
  test('returns deterministic search matches and subtitle sources', () async {
    final repository = MockSearchRepository(MockSearchApi());

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
