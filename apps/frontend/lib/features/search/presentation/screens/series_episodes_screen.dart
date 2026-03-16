import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
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
      appBar: AppBar(title: Text(args.item.title)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: AppInsets.page,
            children: <Widget>[
              SectionHeader(
                title: context.t.seriesEpisodesTitle(args.seasonNumber),
                subtitle: _seasonSubtitle(context),
              ),
              const SizedBox(height: 16),
              Column(
                spacing: 12,
                children: episodes
                    .map(
                      (episode) => AppSurfaceCard(
                        onTap: () => context.push(
                          AppRoutes.subtitleSources,
                          extra: SubtitleSourcesArgs(
                            item: args.item,
                            seasonNumber: args.seasonNumber,
                            episodeNumber: episode,
                          ),
                        ),
                        child: Row(
                          spacing: 12,
                          children: <Widget>[
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Iconsax.monitor,
                                color: AppColors.primary,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    context.t.seriesEpisodeLabel(episode),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  Text(
                                    _episodeSubtitle(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Iconsax.arrowRight,
                              color: AppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _seasonSubtitle(BuildContext context) {
    final year = args.seasonYear == null ? '' : ' \u2022 ${args.seasonYear}';
    return context.t.seriesEpisodesSubtitle(args.episodeCount, year);
  }

  String _episodeSubtitle(BuildContext context) {
    return context.t.seriesEpisodeMeta(args.item.runtimeMinutes);
  }
}
