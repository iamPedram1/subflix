import 'package:subflix/features/search/domain/models/movie_search_item.dart';

class SearchState {
  const SearchState({
    required this.query,
    required this.isLoading,
    required this.hasSearched,
    required this.results,
    this.errorMessage,
  });

  const SearchState.initial()
    : query = '',
      isLoading = false,
      hasSearched = false,
      results = const <MovieSearchItem>[],
      errorMessage = null;

  final String query;
  final bool isLoading;
  final bool hasSearched;
  final List<MovieSearchItem> results;
  final String? errorMessage;

  bool get showEmpty =>
      hasSearched && !isLoading && errorMessage == null && results.isEmpty;

  SearchState copyWith({
    String? query,
    bool? isLoading,
    bool? hasSearched,
    List<MovieSearchItem>? results,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      results: results ?? this.results,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
