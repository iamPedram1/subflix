import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/app/router/app_routes_data.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/features/health/application/backend_health_provider.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/home/application/home_providers.dart';
import 'package:subflix/features/home/presentation/widgets/home_header_block.dart';
import 'package:subflix/features/home/presentation/widgets/home_section_header.dart';
import 'package:subflix/features/home/presentation/widgets/home_trending_section.dart';
import 'package:subflix/features/home/presentation/widgets/recent_translation_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentJobs = ref.watch(recentJobsProvider);
    final backendHealth = ref.watch(backendHealthProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                HomeHeaderBlock(backendHealth: backendHealth),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.xl,
                    AppSpacing.md,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HomeSectionHeader(
                        title: context.t.homeRecentJobsTitle,
                        actionLabel: context.t.homeViewAll,
                        onTap: () => const HistoryRoute().go(context),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      recentJobs.when(
                        data: (jobs) {
                          if (jobs.isEmpty) {
                            return StatePanel(
                              icon: Icons.history_rounded,
                              title: context.t.homeNoRecentTitle,
                              message: context.t.homeNoRecentMessage,
                            );
                          }
                          return Column(
                            children: jobs
                                .map(
                                  (job) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.sm,
                                    ),
                                    child: RecentTranslationCard(job: job),
                                  ),
                                )
                                .toList(growable: false),
                          );
                        },
                        error: (error, stackTrace) => StatePanel(
                          icon: Icons.error_outline_rounded,
                          title: context.t.homeFailedRecentTitle,
                          message: '$error',
                          action: OutlinedButton.icon(
                            onPressed: () => ref
                                .read(historyControllerProvider.notifier)
                                .refresh(),
                            icon: const Icon(Icons.refresh_rounded),
                            label: AppText(
                              context.t.retry,
                              variant: AppTextVariant.labelLarge,
                            ),
                          ),
                        ),
                        loading: () => const Column(
                          children: <Widget>[
                            LoadingSkeleton(height: 118),
                            SizedBox(height: AppSpacing.sm),
                            LoadingSkeleton(height: 118),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const HomeTrendingSection(),
                      const SizedBox(height: AppSpacing.pageBottom),
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
