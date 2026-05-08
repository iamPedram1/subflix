import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/padding.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/catalog_media_details_provider.dart';
import 'package:subflix/features/search/domain/models/catalog_media_details.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/models/series_selection_args.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';

class SeriesSeasonsScreen extends ConsumerWidget {
  const SeriesSeasonsScreen({required this.item, super.key});

  final MovieSearchItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(catalogMediaDetailsProvider(item));

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: detailsAsync.when(
              data: (details) {
                if (details == null) {
                  return _DetailsState(
                    child: StatePanel(
                      icon: Icons.hide_source_rounded,
                      title: 'Media details not found',
                      message:
                          'We could not load extra details for this title. Please try another result.',
                      action: AppButton(
                        label: context.t.retry,
                        variant: AppButtonVariant.outlined,
                        leadingIcon: Icons.refresh_rounded,
                        onPressed: () =>
                            ref.invalidate(catalogMediaDetailsProvider(item)),
                      ),
                    ),
                  );
                }

                return _DetailsContent(details: details);
              },
              error: (error, stackTrace) => _DetailsState(
                child: StatePanel(
                  icon: Icons.error_outline_rounded,
                  title: 'Could not load media details',
                  message: '$error',
                  action: AppButton(
                    label: context.t.retry,
                    variant: AppButtonVariant.outlined,
                    leadingIcon: Icons.refresh_rounded,
                    onPressed: () =>
                        ref.invalidate(catalogMediaDetailsProvider(item)),
                  ),
                ),
              ),
              loading: () => _DetailsLoading(item: item),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.details});

  final CatalogMediaDetails details;

  @override
  Widget build(BuildContext context) {
    final seasons = details.seasons ?? const <CatalogSeasonDetails>[];

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _DetailsHero(details: details),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _OverviewCard(details: details),
              const SizedBox(height: 16),
              if (details.mediaType == SearchMediaType.movie)
                AppButton(
                  label: 'View subtitle sources',
                  variant: AppButtonVariant.gradient,
                  trailingIcon: Icons.arrow_forward_rounded,
                  fullWidth: true,
                  onPressed: () => context.push(
                    AppRoutes.subtitleSources,
                    extra: SubtitleSourcesArgs(item: details.toSearchItem()),
                  ),
                ),
              if (details.mediaType == SearchMediaType.series) ...<Widget>[
                _SeriesStats(details: details),
                const SizedBox(height: 18),
                AppText(
                  'Seasons',
                  variant: AppTextVariant.titleLarge,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 6),
                AppText(
                  'Browse available seasons and continue into episode-level subtitle selection.',
                  variant: AppTextVariant.bodyMedium,
                  color: AppColors.textSecondaryFor(context),
                ),
                const SizedBox(height: 16),
                if (seasons.isEmpty)
                  StatePanel(
                    icon: Icons.tv_off_rounded,
                    title: 'No season metadata available',
                    message:
                        'This series does not currently include season details from the backend.',
                  )
                else
                  ...seasons.map(
                    (season) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SeasonCard(
                        season: season,
                        onTap: season.episodeCount <= 0
                            ? null
                            : () => context.push(
                                AppRoutes.seriesEpisodes,
                                extra: SeriesEpisodesArgs(
                                  media: details,
                                  seasonNumber: season.seasonNumber,
                                  seasonName: season.name,
                                  episodeCount: season.episodeCount,
                                  seasonYear: _tryParseYear(season.airDate),
                                ),
                              ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailsHero extends StatelessWidget {
  const _DetailsHero({required this.details});

  final CatalogMediaDetails details;

  @override
  Widget build(BuildContext context) {
    final posterUrl = details.posterUrl?.trim();
    final hasPoster = posterUrl != null && posterUrl.isNotEmpty;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            AppColors.primary.withValues(alpha: 0.18),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => context.pop(),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.90),
            ),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: SizedBox(
                  width: 140,
                  height: 208,
                  child: hasPoster
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const _HeroPosterFallback(),
                        )
                      : const _HeroPosterFallback(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _HeroChip(
                      label:
                          '${details.mediaType.label(context)} \u2022 ${details.year}',
                    ),
                    const SizedBox(height: 10),
                    AppText(
                      details.title,
                      variant: AppTextVariant.headlineMedium,
                      fontWeight: FontWeight.w700,
                    ),
                    if (_showOriginalTitle(details)) ...<Widget>[
                      const SizedBox(height: 8),
                      AppText(
                        details.originalTitle!,
                        variant: AppTextVariant.bodyMedium,
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ],
                    const SizedBox(height: 10),
                    AppText(
                      'Popularity ${details.popularity.toStringAsFixed(1)}',
                      variant: AppTextVariant.bodyMedium,
                      color: AppColors.textSecondaryFor(context),
                    ),
                    if (details.imdbId != null && details.imdbId!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _HeroChip(label: 'IMDb ${details.imdbId!}'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.details});

  final CatalogMediaDetails details;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ...details.genres.take(3).map(_MetaChip.new),
              _MetaChip('${details.runtimeMinutes}m'),
              _MetaChip(details.providerMediaType.name.toUpperCase()),
            ],
          ),
          const SizedBox(height: 16),
          AppText(
            'Synopsis',
            variant: AppTextVariant.titleMedium,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 8),
          AppText(
            details.synopsis,
            variant: AppTextVariant.bodyMedium,
            color: AppColors.textSecondaryFor(context),
          ),
          if (details.tmdbId != null ||
              (details.imdbId != null && details.imdbId!.isNotEmpty)) ...<Widget>[
            const SizedBox(height: 16),
            Divider(color: AppColors.outlineSoftFor(context)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                if (details.tmdbId != null) _MetaChip('TMDB ${details.tmdbId}'),
                if (details.imdbId != null && details.imdbId!.isNotEmpty)
                  _MetaChip('IMDb ${details.imdbId}'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SeriesStats extends StatelessWidget {
  const _SeriesStats({required this.details});

  final CatalogMediaDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _StatCard(
            label: 'Seasons',
            value: '${details.seasonsCount ?? details.seasons?.length ?? 0}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Episodes',
            value: '${details.episodesCount ?? 0}',
          ),
        ),
      ],
    );
  }
}

class _SeasonCard extends StatelessWidget {
  const _SeasonCard({required this.season, required this.onTap});

  final CatalogSeasonDetails season;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final posterUrl = season.posterUrl?.trim();
    final hasPoster = posterUrl != null && posterUrl.isNotEmpty;

    return AppSurfaceCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 86,
              height: 118,
              child: hasPoster
                  ? Image.network(
                      posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _SeasonPosterFallback(season: season),
                    )
                  : _SeasonPosterFallback(season: season),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  season.name,
                  variant: AppTextVariant.titleLarge,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 6),
                AppText(
                  '${season.episodeCount} episodes${_buildAirDateSuffix(season.airDate)}',
                  variant: AppTextVariant.bodyMedium,
                  color: AppColors.textSecondaryFor(context),
                ),
                if (season.overview != null && season.overview!.trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AppText(
                      season.overview!,
                      variant: AppTextVariant.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.textSecondaryFor(context),
                    ),
                  ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    AppText(
                      onTap == null ? 'Unavailable' : 'Browse episodes',
                      variant: AppTextVariant.labelLarge,
                      color: onTap == null
                          ? AppColors.textMutedFor(context)
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: onTap == null
                          ? AppColors.textMutedFor(context)
                          : AppColors.primary,
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

class _DetailsLoading extends StatelessWidget {
  const _DetailsLoading({required this.item});

  final MovieSearchItem item;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  LoadingSkeleton(
                    width: 140,
                    height: 208,
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LoadingSkeleton(
                          width: 120,
                          height: 26,
                          borderRadius: BorderRadius.all(Radius.circular(999)),
                        ),
                        SizedBox(height: 14),
                        LoadingSkeleton(height: 28),
                        SizedBox(height: 10),
                        LoadingSkeleton(width: 180, height: 20),
                        SizedBox(height: 10),
                        LoadingSkeleton(width: 120, height: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: AppPadding.page,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText(item.title, variant: AppTextVariant.titleLarge),
              const SizedBox(height: 16),
              const LoadingSkeleton(height: 190),
              const SizedBox(height: 16),
              const LoadingSkeleton(height: 92),
              const SizedBox(height: 12),
              const LoadingSkeleton(height: 92),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailsState extends StatelessWidget {
  const _DetailsState({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPadding.pageComfort,
      children: <Widget>[child],
    );
  }
}

class _HeroPosterFallback extends StatelessWidget {
  const _HeroPosterFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: const Center(
        child: Icon(Icons.local_movies_rounded, color: Colors.white, size: 54),
      ),
    );
  }
}

class _SeasonPosterFallback extends StatelessWidget {
  const _SeasonPosterFallback({required this.season});

  final CatalogSeasonDetails season;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF4338CA), Color(0xFFEC4899)],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Spacer(),
          AppText(
            'S${season.seasonNumber}',
            variant: AppTextVariant.headlineMedium,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 6),
          AppText(
            '${season.episodeCount} eps',
            variant: AppTextVariant.labelLarge,
            color: Colors.white.withValues(alpha: 0.86),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.bodyMedium,
            color: AppColors.textSecondaryFor(context),
          ),
          const SizedBox(height: 8),
          AppText(
            value,
            variant: AppTextVariant.headlineMedium,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: AppInsets.chip,
        child: AppText(
          label,
          variant: AppTextVariant.labelMedium,
          color: AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: AppText(label, variant: AppTextVariant.labelMedium),
      ),
    );
  }
}

bool _showOriginalTitle(CatalogMediaDetails details) {
  final original = details.originalTitle?.trim();
  if (original == null || original.isEmpty) {
    return false;
  }
  return original.toLowerCase() != details.title.trim().toLowerCase();
}

String _buildAirDateSuffix(String? airDate) {
  final year = _tryParseYear(airDate);
  return year == null ? '' : ' \u2022 $year';
}

int? _tryParseYear(String? airDate) {
  if (airDate == null || airDate.trim().length < 4) {
    return null;
  }
  return int.tryParse(airDate.trim().substring(0, 4));
}
