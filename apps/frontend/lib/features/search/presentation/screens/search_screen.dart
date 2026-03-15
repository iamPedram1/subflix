import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/search_controller.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/widgets/search_result_card.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  Timer? _searchDebounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.searchTitles)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              SectionHeader(
                title: context.t.searchMovieOrSeriesTitle,
                subtitle: context.t.searchMovieOrSeriesSubtitle,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: _onQueryChanged,
                decoration: InputDecoration(
                  hintText: context.t.searchHintText,
                  prefixIcon: const Icon(Iconsax.searchNormal),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            _onQueryChanged('');
                          },
                          icon: const Icon(Iconsax.closeCircle),
                        ),
                ),
              ),
              const SizedBox(height: 18),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _SearchBody(
                  key: ValueKey<String>(
                    '${searchState.query}_${searchState.isLoading}_${searchState.results.length}_${searchState.errorMessage}',
                  ),
                  state: searchState,
                  onRetry: ref.read(searchControllerProvider.notifier).retry,
                  onTapItem: (item) {
                    if (item.mediaType == SearchMediaType.series) {
                      context.push(AppRoutes.seriesSeasons, extra: item);
                      return;
                    }

                    context.push(
                      AppRoutes.subtitleSources,
                      extra: SubtitleSourcesArgs(item: item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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

class _SearchBody extends StatelessWidget {
  const _SearchBody({
    required this.state,
    required this.onRetry,
    required this.onTapItem,
    super.key,
  });

  final SearchState state;
  final VoidCallback onRetry;
  final ValueChanged<MovieSearchItem> onTapItem;

  @override
  Widget build(BuildContext context) {
    if (state.query.trim().isEmpty) {
      return StatePanel(
        icon: Iconsax.magicStar,
        title: context.t.searchMockTitle,
        message: context.t.searchMockMessage,
      );
    }

    if (state.isLoading) {
      return Column(
        spacing: 14,
        children: const <Widget>[
          LoadingSkeleton(height: 132),
          LoadingSkeleton(height: 132),
          LoadingSkeleton(height: 132),
        ],
      );
    }

    if (state.errorMessage != null) {
      return StatePanel(
        icon: Iconsax.warning2,
        title: context.t.searchFailedTitle,
        message: state.errorMessage!,
        action: OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Iconsax.refresh),
          label: Text(context.t.retry),
        ),
      );
    }

    if (state.showEmpty) {
      return StatePanel(
        icon: Iconsax.searchNormal,
        title: context.t.noTitlesMatchedTitle,
        message: context.t.noTitlesMatchedMessage,
      );
    }

    return Column(
      spacing: 14,
      children: state.results
          .map(
            (item) =>
                SearchResultCard(item: item, onTap: () => onTapItem(item)),
          )
          .toList(growable: false),
    );
  }
}
