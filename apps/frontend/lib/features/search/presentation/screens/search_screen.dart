import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/features/search/application/search_controller.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/widgets/search_body.dart';
import 'package:subflix/features/search/presentation/widgets/search_top_bar.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  static const List<String> _suggestions = <String>[
    'The Dark Knight',
    'Game of Thrones',
    'The Shawshank Redemption',
    'Better Call Saul',
    'The Matrix',
  ];

  final TextEditingController _controller = TextEditingController();
  Timer? _searchDebounce;
  String _query = '';

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: Column(
              children: <Widget>[
                SearchTopBar(
                  controller: _controller,
                  query: _query,
                  onChanged: _onQueryChanged,
                  onClear: _clearQuery,
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: SearchBody(
                      key: ValueKey<String>(
                        '${state.query}_${state.isLoading}_${state.results.length}_${state.errorMessage}',
                      ),
                      state: state,
                      suggestions: _suggestions,
                      onSuggestionTap: _applySuggestion,
                      onRetry: ref
                          .read(searchControllerProvider.notifier)
                          .retry,
                      onTapItem: _openResult,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearQuery() {
    _controller.clear();
    _onQueryChanged('');
  }

  void _applySuggestion(String value) {
    _controller.text = value;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
    _onQueryChanged(value);
  }

  void _openResult(MovieSearchItem item) {
    if (item.mediaType == SearchMediaType.series) {
      context.push(AppRoutes.seriesSeasons, extra: item);
      return;
    }
    context.push(
      AppRoutes.subtitleSources,
      extra: SubtitleSourcesArgs(item: item),
    );
  }

  void _onQueryChanged(String value) {
    _searchDebounce?.cancel();
    setState(() => _query = value);

    if (value.trim().isEmpty) {
      ref.read(searchControllerProvider.notifier).onQueryChanged('');
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 360), () {
      if (!mounted) {
        return;
      }
      ref.read(searchControllerProvider.notifier).onQueryChanged(value);
    });
  }
}
