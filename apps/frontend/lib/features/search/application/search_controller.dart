import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  SearchState build() {
    return const SearchState.initial();
  }

  Future<void> onQueryChanged(String query) async {
    final normalized = query.trim();

    if (normalized.isEmpty) {
      state = const SearchState.initial();
      return;
    }

    state = state.copyWith(
      query: query,
      isLoading: true,
      hasSearched: true,
      clearError: true,
    );

    final requestQuery = normalized;

    try {
      final results = await ref
          .read(searchRepositoryProvider)
          .searchTitles(requestQuery);
      if (state.query.trim() != requestQuery) {
        return;
      }

      state = state.copyWith(
        isLoading: false,
        results: results,
        clearError: true,
      );
    } catch (error) {
      if (state.query.trim() != requestQuery) {
        return;
      }

      state = state.copyWith(
        isLoading: false,
        results: const <MovieSearchItem>[],
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void retry() {
    onQueryChanged(state.query);
  }
}
