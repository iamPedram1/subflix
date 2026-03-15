import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/models/series_catalog.dart';
import 'package:subflix/features/search/presentation/models/series_selection_args.dart';

class SeriesSeasonsScreen extends StatelessWidget {
  const SeriesSeasonsScreen({required this.item, super.key});

  final MovieSearchItem item;

  @override
  Widget build(BuildContext context) {
    final details = resolveSeriesDetails(item);

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              SectionHeader(
                title: context.t.seriesSeasonsTitle,
                subtitle: context.t.seriesSeasonsSubtitle(item.title),
              ),
              const SizedBox(height: 16),
              Column(
                spacing: 12,
                children: details.seasons
                    .map(
                      (season) => AppSurfaceCard(
                        onTap: () => context.push(
                          AppRoutes.seriesEpisodes,
                          extra: SeriesEpisodesArgs(
                            item: item,
                            seasonNumber: season.number,
                            episodeCount: season.episodeCount,
                            seasonYear: season.year,
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
                                Iconsax.video,
                                color: AppColors.primary,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    context.t.seriesSeasonLabel(season.number),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  Text(
                                    _seasonSubtitle(context, season),
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

  String _seasonSubtitle(BuildContext context, SeasonDetails season) {
    final year = season.year == null ? '' : ' \u2022 ${season.year}';
    return context.t.seriesSeasonMeta(season.episodeCount, year);
  }
}
