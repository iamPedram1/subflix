import 'package:flutter/material.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/padding.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/search_state.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
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
        padding: AppPadding.page,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.trending_up_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              AppText(
                context.t.searchTrendingTitle,
                variant: AppTextVariant.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: suggestions
                .map(
                  (suggestion) => ActionChip(
                    label: AppText(
                      suggestion,
                      variant: AppTextVariant.labelMedium,
                    ),
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
            const SizedBox(height: AppSpacing.md),
            AppText(
              context.t.searchLoadingLabel,
              variant: AppTextVariant.bodyMedium,
              color: AppColors.textSecondaryFor(context),
            ),
          ],
        ),
      );
    }

    if (state.errorMessage != null) {
      return ListView(
        padding: AppPadding.page,
        children: <Widget>[
          StatePanel(
            icon: Icons.error_outline_rounded,
            title: context.t.searchFailedTitle,
            message: state.errorMessage!,
            action: AppButton(
              label: context.t.retry,
              onPressed: onRetry,
              variant: AppButtonVariant.outlined,
              leadingIcon: Icons.refresh_rounded,
            ),
          ),
        ],
      );
    }

    if (state.showEmpty) {
      return ListView(
        padding: AppPadding.page,
        children: <Widget>[
          const SizedBox(height: 56),
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.textMutedFor(context).withValues(alpha: 0.36),
          ),
          const SizedBox(height: AppSpacing.md),
          AppText(
            context.t.searchNoResultsFor(state.query),
            variant: AppTextVariant.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppText(
            context.t.searchTryDifferentKeywords,
            variant: AppTextVariant.bodyMedium,
            textAlign: TextAlign.center,
            color: AppColors.textSecondaryFor(context),
          ),
        ],
      );
    }

    return ListView(
      padding: AppPadding.page,
      children: <Widget>[
        AppText(
          context.t.searchFoundResults(state.results.length, state.query),
          variant: AppTextVariant.bodyMedium,
          color: AppColors.textSecondaryFor(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...state.results.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: SearchResultCard(item: item, onTap: () => onTapItem(item)),
          ),
        ),
      ],
    );
  }
}

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({required this.item, required this.onTap, super.key});

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
          _PosterCard(item: item, isMovie: isMovie),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(item.title, variant: AppTextVariant.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: <Widget>[
                    _MetaChip(
                      label: item.mediaType.label(context),
                      textColor: isMovie
                          ? AppColors.primary
                          : AppColors.secondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: AppColors.textSecondaryFor(context),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      '${item.runtimeMinutes}m',
                      variant: AppTextVariant.bodySmall,
                      color: AppColors.textSecondaryFor(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AppText(
                  item.synopsis,
                  variant: AppTextVariant.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.textSecondaryFor(context),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    ...item.genres
                        .take(2)
                        .map(
                          (genre) => Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.xs,
                            ),
                            child: _MetaChip(label: genre),
                          ),
                        ),
                    const Spacer(),
                    AppText(
                      item.popularity.toStringAsFixed(1),
                      variant: AppTextVariant.labelMedium,
                      color: AppColors.textSecondaryFor(context),
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

class _PosterCard extends StatelessWidget {
  const _PosterCard({required this.item, required this.isMovie});

  final MovieSearchItem item;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    final posterUrl = item.posterUrl?.trim();
    final hasPoster = posterUrl != null && posterUrl.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 84,
        height: 116,
        child: hasPoster
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    posterUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _PosterFallback(item: item, isMovie: isMovie),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return _PosterFallback(item: item, isMovie: isMovie);
                    },
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.58),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: AppText(
                          '${item.year}',
                          variant: AppTextVariant.labelMedium,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _PosterFallback(item: item, isMovie: isMovie),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  const _PosterFallback({required this.item, required this.isMovie});

  final MovieSearchItem item;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isMovie
              ? const <Color>[Color(0xFF1D4ED8), Color(0xFF7C3AED)]
              : const <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
        ),
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
            child: AppText(
              '${item.year}',
              variant: AppTextVariant.labelLarge,
              color: Colors.white,
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
      child: AppText(
        label,
        variant: AppTextVariant.labelMedium,
        color: textColor ?? AppColors.textSecondaryFor(context),
      ),
    );
  }
}
