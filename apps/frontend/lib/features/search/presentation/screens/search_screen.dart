import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/search_controller.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/widgets/search_result_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search titles')),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              const SectionHeader(
                title: 'Search movie or series',
                subtitle:
                    'Find a title, inspect subtitle sources, and launch a translation job with a few taps.',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: ref
                    .read(searchControllerProvider.notifier)
                    .onQueryChanged,
                decoration: InputDecoration(
                  hintText: 'Search for Dune, Breaking Bad, Severance...',
                  prefixIcon: const Icon(Iconsax.searchNormal),
                  suffixIcon: searchState.query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            ref
                                .read(searchControllerProvider.notifier)
                                .onQueryChanged('');
                          },
                          icon: const Icon(Icons.close_rounded),
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
                  onTapItem: (item) =>
                      context.push(AppRoutes.subtitleSources, extra: item),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      return const StatePanel(
        icon: Iconsax.magicStar,
        title: 'Search anything in the mock catalog',
        message:
            'Try titles like Inception, Dune, Breaking Bad, Severance, or The Last of Us to explore the subtitle source flow.',
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
        title: 'Search failed',
        message: state.errorMessage!,
        action: OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Iconsax.refresh),
          label: const Text('Retry'),
        ),
      );
    }

    if (state.showEmpty) {
      return const StatePanel(
        icon: Iconsax.searchNormal,
        title: 'No titles matched',
        message:
            'We could not find that title in the mock catalog. Try a broader search or one of the suggested shows.',
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
