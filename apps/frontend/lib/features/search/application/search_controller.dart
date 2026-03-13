import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    return const SearchState.initial();
  }

  void onQueryChanged(String query) {
    _debounce?.cancel();
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

    _debounce = Timer(const Duration(milliseconds: 320), () async {
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
    });
  }

  void retry() {
    onQueryChanged(state.query);
  }
}
