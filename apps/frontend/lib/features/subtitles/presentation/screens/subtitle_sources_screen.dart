import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/search/application/subtitle_sources_provider.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';
import 'package:subflix/features/subtitles/presentation/widgets/subtitle_source_card.dart';

class SubtitleSourcesScreen extends ConsumerWidget {
  const SubtitleSourcesScreen({required this.item, super.key});

  final MovieSearchItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sources = ref.watch(subtitleSourcesProvider(item));

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              SectionHeader(
                title: 'English subtitle sources',
                subtitle:
                    'Pick a subtitle source for ${item.title}, then choose the target language in the next step.',
              ),
              const SizedBox(height: 16),
              _TitleSummary(item: item),
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
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
                error: (error, stackTrace) => StatePanel(
                  icon: Iconsax.warning2,
                  title: 'Could not load subtitle sources',
                  message: error.toString().replaceFirst('Exception: ', ''),
                  action: OutlinedButton.icon(
                    onPressed: () =>
                        ref.invalidate(subtitleSourcesProvider(item)),
                    icon: const Icon(Iconsax.refresh),
                    label: const Text('Retry'),
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
    );
  }
}

class _TitleSummary extends StatelessWidget {
  const _TitleSummary({required this.item});

  final MovieSearchItem item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
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
                    '${item.mediaType.label} • ${item.year} • ${item.runtimeMinutes}m',
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
