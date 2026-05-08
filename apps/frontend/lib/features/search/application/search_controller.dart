import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  final Map<String, List<MovieSearchItem>> _cache =
      <String, List<MovieSearchItem>>{};

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

    final cacheKey = normalized.toLowerCase();
    final cached = _cache[cacheKey];
    if (cached != null) {
      state = state.copyWith(
        query: query,
        isLoading: false,
        hasSearched: true,
        results: cached,
        clearError: true,
      );
      unawaited(_refreshSearch(cacheKey, query, showError: false));
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

      _cache[cacheKey] = results;
      _prefetchSources(results);
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

  Future<void> _refreshSearch(
    String cacheKey,
    String query, {
    required bool showError,
  }) async {
    try {
      final results = await ref
          .read(searchRepositoryProvider)
          .searchTitles(query);
      if (state.query.trim() != query.trim()) {
        return;
      }
      _cache[cacheKey] = results;
      _prefetchSources(results);
      state = state.copyWith(
        isLoading: false,
        results: results,
        clearError: true,
      );
    } catch (error) {
      if (!showError || state.query.trim() != query.trim()) {
        return;
      }
      state = state.copyWith(
        isLoading: false,
        results: const <MovieSearchItem>[],
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void _prefetchSources(List<MovieSearchItem> results) {
    final repository = ref.read(searchRepositoryProvider);
    for (final item in results.take(2)) {
      unawaited(
        repository.fetchSubtitleSources(item.id, preferredLanguage: 'en'),
      );
    }
  }
}
