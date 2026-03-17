import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/subtitle_sources_provider.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';

class SubtitleSourcesScreen extends ConsumerWidget {
  const SubtitleSourcesScreen({required this.args, super.key});

  final SubtitleSourcesArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = SubtitleSourcesRequest(
      item: args.item,
      seasonNumber: args.seasonNumber,
      episodeNumber: args.episodeNumber,
      releaseHint: args.releaseHint,
    );
    final sources = ref.watch(subtitleSourcesSelectionProvider(request));

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: <Widget>[
                _SourcesHeader(args: args),
                const SizedBox(height: 16),
                _InfoBanner(
                  title: context.t.subtitleSourcesBannerTitle,
                  message: context.t.subtitleSourcesBannerMessage,
                ),
                const SizedBox(height: 16),
                sources.when(
                  data: (items) => Column(
                    children: items
                        .map(
                          (source) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _SourceCard(
                              source: source,
                              onTap: () => context.push(
                                AppRoutes.translateSetup,
                                extra: TranslationSetupArgs.catalog(
                                  item: args.item,
                                  source: source,
                                  seasonNumber: args.seasonNumber,
                                  episodeNumber: args.episodeNumber,
                                  releaseHint: args.releaseHint,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                  error: (error, stackTrace) => StatePanel(
                    icon: Icons.error_outline_rounded,
                    title: context.t.subtitleSourcesFailedTitle,
                    message: '$error',
                    action: OutlinedButton.icon(
                      onPressed: () => ref.invalidate(
                        subtitleSourcesSelectionProvider(request),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(context.t.retry),
                    ),
                  ),
                  loading: () => Column(
                    children: const <Widget>[
                      LoadingSkeleton(height: 138),
                      SizedBox(height: 12),
                      LoadingSkeleton(height: 138),
                      SizedBox(height: 12),
                      LoadingSkeleton(height: 138),
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

class _SourcesHeader extends StatelessWidget {
  const _SourcesHeader({required this.args});

  final SubtitleSourcesArgs args;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          args.item.title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          context.t.subtitleSourcesSubtitle(
            args.item.title,
            _buildSubtitleTarget(context, args),
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondaryFor(context),
          ),
        ),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.card,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.secondary.withValues(alpha: 0.10),
          ],
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.source, required this.onTap});

  final SubtitleSource source;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final confidence = (source.rating * 20).clamp(0, 100).round();
    return AppSurfaceCard(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: confidence / 100,
              minHeight: 6,
              backgroundColor: AppColors.surfaceMutedFor(context),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.emerald,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'EN',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            source.label,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _MiniPill(label: source.format.label),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      source.releaseGroup,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _MiniPill(
                          label: context.t.subtitleSourceDownloads(
                            source.downloads.toString(),
                          ),
                        ),
                        _MiniPill(
                          label: context.t.subtitleSourceLines(
                            source.lineCount.toString(),
                          ),
                        ),
                        _MiniPill(label: '$confidence% match'),
                        if (source.hearingImpaired)
                          _MiniPill(label: context.t.subtitleSourceHiLabel),
                      ],
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

class _MiniPill extends StatelessWidget {
  const _MiniPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}

String _buildSubtitleTarget(BuildContext context, SubtitleSourcesArgs args) {
  if (args.seasonNumber == null) {
    return '';
  }

  final seasonLabel = context.t.seriesSeasonLabel(args.seasonNumber!);
  final episodeLabel = args.episodeNumber == null
      ? ''
      : ' • ${context.t.seriesEpisodeLabel(args.episodeNumber!)}';
  return ' • $seasonLabel$episodeLabel';
}
