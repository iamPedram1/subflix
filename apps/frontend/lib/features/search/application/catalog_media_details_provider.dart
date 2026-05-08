import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';

part 'catalog_media_details_provider.g.dart';

@riverpod
Future<CatalogMediaDetails?> catalogMediaDetails(
  Ref ref,
  MovieSearchItem item,
) {
  return ref.watch(searchRepositoryProvider).fetchMediaDetails(item.id);
}
