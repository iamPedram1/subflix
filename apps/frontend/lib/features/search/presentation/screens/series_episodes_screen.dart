import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/features/search/presentation/models/series_selection_args.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';

class SeriesEpisodesScreen extends StatelessWidget {
  const SeriesEpisodesScreen({required this.args, super.key});

  final SeriesEpisodesArgs args;

  @override
  Widget build(BuildContext context) {
    final episodes = List<int>.generate(
      args.episodeCount,
      (index) => index + 1,
    );

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _EpisodesHeader(args: args),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        context.t.seriesEpisodesTitle(args.seasonNumber),
                        variant: AppTextVariant.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        context.t.seriesEpisodesSubtitle(
                          args.episodeCount,
                          args.seasonYear == null
                              ? ''
                              : ' • ${args.seasonYear}',
                        ),
                        variant: AppTextVariant.bodyMedium,
                        color: AppColors.textSecondaryFor(context),
                      ),
                      const SizedBox(height: 18),
                      ...episodes.map(
                        (episode) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _EpisodeCard(
                            title: context.t.seriesEpisodeLabel(episode),
                            runtime: context.t.seriesEpisodeMeta(
                              args.item.runtimeMinutes,
                            ),
                            description:
                                '${args.item.title} • ${context.t.seriesSeasonLabel(args.seasonNumber)}',
                            onTap: () => context.push(
                              AppRoutes.subtitleSources,
                              extra: SubtitleSourcesArgs(
                                item: args.item,
                                seasonNumber: args.seasonNumber,
                                episodeNumber: episode,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EpisodesHeader extends StatelessWidget {
  const _EpisodesHeader({required this.args});

  final SeriesEpisodesArgs args;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => context.pop(),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.88),
            ),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  args.item.title,
                  variant: AppTextVariant.titleLarge,
                ),
                const SizedBox(height: 2),
                AppText(
                  context.t.seriesSeasonLabel(args.seasonNumber),
                  variant: AppTextVariant.bodyMedium,
                  color: AppColors.textSecondaryFor(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({
    required this.title,
    required this.runtime,
    required this.description,
    required this.onTap,
  });

  final String title;
  final String runtime;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 168,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF312E81), Color(0xFF7C3AED)],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 18,
                  top: 18,
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    size: 72,
                    color: Colors.white.withValues(alpha: 0.20),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppText(
                      runtime,
                      variant: AppTextVariant.labelLarge,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppInsets.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  title,
                  variant: AppTextVariant.titleMedium,
                ),
                const SizedBox(height: 8),
                AppText(
                  description,
                  variant: AppTextVariant.bodyMedium,
                  color: AppColors.textSecondaryFor(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
