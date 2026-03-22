import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/search_media_type.dart';

part 'movie_search_item.freezed.dart';
part 'movie_search_item.g.dart';

@freezed
abstract class MovieSearchItem with _$MovieSearchItem {
  const factory MovieSearchItem({
    required String id,
    required String title,
    required int year,
    required SearchMediaType mediaType,
    String? posterUrl,
    required String synopsis,
    required List<String> genres,
    required int runtimeMinutes,
    required double popularity,
  }) = _MovieSearchItem;

  factory MovieSearchItem.fromJson(Map<String, dynamic> json) =>
      _$MovieSearchItemFromJson(json);
}
