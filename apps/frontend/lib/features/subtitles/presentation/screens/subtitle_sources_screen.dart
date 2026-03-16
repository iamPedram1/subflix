import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/subtitle_sources_provider.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';
import 'package:subflix/features/subtitles/presentation/widgets/subtitle_source_card.dart';

class SubtitleSourcesScreen extends ConsumerWidget {
  const SubtitleSourcesScreen({required this.args, super.key});

  final SubtitleSourcesArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = args.item;
    final request = SubtitleSourcesRequest(
      item: item,
      seasonNumber: args.seasonNumber,
      episodeNumber: args.episodeNumber,
      releaseHint: args.releaseHint,
    );
    final sources = ref.watch(subtitleSourcesSelectionProvider(request));
    final subtitleTarget = _buildSubtitleTarget(context, args);

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: AppInsets.page,
              children: <Widget>[
                SectionHeader(
                  title: context.t.subtitleSourcesTitle,
                  subtitle: context.t.subtitleSourcesSubtitle(
                    item.title,
                    subtitleTarget,
                  ),
                ),
                const SizedBox(height: 16),
                _TitleSummary(item: item, args: args),
                const SizedBox(height: 18),
                sources.when(
                  data: (items) => Column(
                    spacing: 14,
                    children: items
                        .map(
                          (source) => SubtitleSourceCard(
                            source: source,
                            onTap: () => context.push(
                              AppRoutes.translateSetup,
                              extra: TranslationSetupArgs.catalog(
                                item: item,
                                source: source,
                                seasonNumber: args.seasonNumber,
                                episodeNumber: args.episodeNumber,
                                releaseHint: args.releaseHint,
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                  error: (error, stackTrace) => StatePanel(
                    icon: Iconsax.warning2,
                    title: context.t.subtitleSourcesFailedTitle,
                    message: error.toString().replaceFirst('Exception: ', ''),
                    action: OutlinedButton.icon(
                      onPressed: () => ref.invalidate(
                        subtitleSourcesSelectionProvider(request),
                      ),
                      icon: const Icon(Iconsax.refresh),
                      label: Text(context.t.retry),
                    ),
                  ),
                  loading: () => Column(
                    spacing: 14,
                    children: const <Widget>[
                      LoadingSkeleton(height: 132),
                      LoadingSkeleton(height: 132),
                      LoadingSkeleton(height: 132),
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

class _TitleSummary extends StatelessWidget {
  const _TitleSummary({required this.item, required this.args});

  final MovieSearchItem item;
  final SubtitleSourcesArgs args;

  @override
  Widget build(BuildContext context) {
    final seasonLabel = _buildSeasonLabel(context, args);
    final metadata = [
      item.mediaType.label(context),
      '${item.year}',
      ?seasonLabel,
      '${item.runtimeMinutes}m',
    ].join(' \u2022 ');

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: AppInsets.cardCompact,
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
              child: const Icon(Iconsax.video, color: AppColors.primary),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    metadata,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      : ' \u2022 ${context.t.seriesEpisodeLabel(args.episodeNumber!)}';
  return ' \u2022 $seasonLabel$episodeLabel';
}

String? _buildSeasonLabel(BuildContext context, SubtitleSourcesArgs args) {
  if (args.seasonNumber == null) {
    return null;
  }

  if (args.episodeNumber == null) {
    return context.t.seriesSeasonLabel(args.seasonNumber!);
  }

  return '${context.t.seriesSeasonLabel(args.seasonNumber!)}'
      ', ${context.t.seriesEpisodeLabel(args.episodeNumber!)}';
}
