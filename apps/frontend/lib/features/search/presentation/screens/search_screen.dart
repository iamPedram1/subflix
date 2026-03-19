import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/search_controller.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _searchDebounce;
  String _query = '';

  static const List<String> _suggestions = <String>[
    'The Dark Knight',
    'Game of Thrones',
    'The Shawshank Redemption',
    'Better Call Saul',
    'The Matrix',
  ];

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
                _SearchTopBar(
                  controller: _controller,
                  query: _query,
                  onChanged: _onQueryChanged,
                  onClear: () {
                    _controller.clear();
                    _onQueryChanged('');
                  },
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: _SearchBody(
                      key: ValueKey<String>(
                        '${state.query}_${state.isLoading}_${state.results.length}_${state.errorMessage}',
                      ),
                      state: state,
                      suggestions: _suggestions,
                      onSuggestionTap: (value) {
                        _controller.text = value;
                        _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: value.length),
                        );
                        _onQueryChanged(value);
                      },
                      onRetry: ref
                          .read(searchControllerProvider.notifier)
                          .retry,
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
                ),
              ],
            ),
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

class _SearchTopBar extends StatelessWidget {
  const _SearchTopBar({
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).scaffoldBackgroundColor.withValues(alpha: 0.94),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => context.go(AppRoutes.home),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              autofocus: true,
              decoration: InputDecoration(
                hintText: context.t.searchHintText,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.surfaceMutedFor(context),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondaryLight,
                ),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: onClear,
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody({
    required this.state,
    required this.suggestions,
    required this.onSuggestionTap,
    required this.onRetry,
    required this.onTapItem,
    super.key,
  });

  final SearchState state;
  final List<String> suggestions;
  final ValueChanged<String> onSuggestionTap;
  final VoidCallback onRetry;
  final ValueChanged<MovieSearchItem> onTapItem;

  @override
  Widget build(BuildContext context) {
    if (state.query.trim().isEmpty) {
      return ListView(
        padding: AppInsets.page,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.trending_up_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                context.t.searchTrendingTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions
                .map(
                  (suggestion) => ActionChip(
                    label: Text(suggestion),
                    onPressed: () => onSuggestionTap(suggestion),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      );
    }

    if (state.isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 46,
              height: 46,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            const SizedBox(height: 16),
            Text(
              context.t.searchLoadingLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryFor(context),
              ),
            ),
          ],
        ),
      );
    }

    if (state.errorMessage != null) {
      return ListView(
        padding: AppInsets.page,
        children: <Widget>[
          StatePanel(
            icon: Icons.error_outline_rounded,
            title: context.t.searchFailedTitle,
            message: state.errorMessage!,
            action: OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.t.retry),
            ),
          ),
        ],
      );
    }

    if (state.showEmpty) {
      return ListView(
        padding: AppInsets.page,
        children: <Widget>[
          const SizedBox(height: 56),
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.textMutedFor(context).withValues(alpha: 0.36),
          ),
          const SizedBox(height: 16),
          Text(
            context.t.searchNoResultsFor(state.query),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            context.t.searchTryDifferentKeywords,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryFor(context),
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: AppInsets.page,
      children: <Widget>[
        Text(
          context.t.searchFoundResults(state.results.length, state.query),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondaryFor(context),
          ),
        ),
        const SizedBox(height: 12),
        ...state.results.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SearchResultCard(item: item, onTap: () => onTapItem(item)),
          ),
        ),
      ],
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.item, required this.onTap});

  final MovieSearchItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isMovie = item.mediaType == SearchMediaType.movie;

    return AppSurfaceCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 84,
            height: 116,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isMovie
                    ? const <Color>[Color(0xFF1D4ED8), Color(0xFF7C3AED)]
                    : const <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -6,
                  top: 10,
                  child: Icon(
                    isMovie ? Icons.movie_filter_outlined : Icons.tv_rounded,
                    size: 54,
                    color: Colors.white.withValues(alpha: 0.20),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Text(
                    '${item.year}',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _MetaChip(
                      label: item.mediaType.label(context),
                      textColor: isMovie
                          ? AppColors.primary
                          : AppColors.secondary,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: AppColors.textSecondaryFor(context),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.runtimeMinutes}m',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.synopsis,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    ...item.genres
                        .take(2)
                        .map(
                          (genre) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _MetaChip(label: genre),
                          ),
                        ),
                    const Spacer(),
                    Text(
                      item.popularity.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label, this.textColor});

  final String label;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: textColor ?? AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}
