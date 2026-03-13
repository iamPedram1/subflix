import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

part 'subtitle_sources_provider.g.dart';

@riverpod
Future<List<SubtitleSource>> subtitleSources(Ref ref, MovieSearchItem item) {
  return ref.watch(searchRepositoryProvider).fetchSubtitleSources(item.id);
}
