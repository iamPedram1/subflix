import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

part 'subtitle_sources_provider.g.dart';

@riverpod
Future<List<SubtitleSource>> subtitleSources(Ref ref, MovieSearchItem item) {
  return ref
      .watch(searchRepositoryProvider)
      .fetchSubtitleSources(item.id, preferredLanguage: 'en');
}

@immutable
class SubtitleSourcesRequest {
  const SubtitleSourcesRequest({
    required this.item,
    this.preferredLanguage = 'en',
    this.seasonNumber,
    this.episodeNumber,
    this.releaseHint,
  });

  final MovieSearchItem item;
  final String preferredLanguage;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? releaseHint;

  @override
  bool operator ==(Object other) {
    return other is SubtitleSourcesRequest &&
        other.item == item &&
        other.preferredLanguage == preferredLanguage &&
        other.seasonNumber == seasonNumber &&
        other.episodeNumber == episodeNumber &&
        other.releaseHint == releaseHint;
  }

  @override
  int get hashCode => Object.hash(
    item,
    preferredLanguage,
    seasonNumber,
    episodeNumber,
    releaseHint,
  );
}

final subtitleSourcesSelectionProvider =
    rp.FutureProvider.family<List<SubtitleSource>, SubtitleSourcesRequest>((
      ref,
      request,
    ) {
      return ref
          .watch(searchRepositoryProvider)
          .fetchSubtitleSources(
            request.item.id,
            preferredLanguage: request.preferredLanguage,
            seasonNumber: request.seasonNumber,
            episodeNumber: request.episodeNumber,
            releaseHint: request.releaseHint,
          );
    });
