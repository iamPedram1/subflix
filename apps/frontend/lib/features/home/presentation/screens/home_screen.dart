import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/core/ui/widgets/subflix_wordmark.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/home/application/home_providers.dart';
import 'package:subflix/features/home/presentation/widgets/home_hero_card.dart';
import 'package:subflix/features/home/presentation/widgets/trust_signal_tile.dart';
import 'package:subflix/features/shared/presentation/widgets/job_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentJobs = ref.watch(recentJobsProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: AppInsets.pageWithNav,
                  sliver: SliverList.list(
                    children: <Widget>[
                      const SubflixWordmark(compact: true),
                      const SizedBox(height: 24),
                      HomeHeroCard(
                            onSearchTap: () => context.push(AppRoutes.search),
                            onUploadTap: () => context.push(AppRoutes.upload),
                          )
                          .animate()
                          .fadeIn(duration: 350.ms)
                          .moveY(begin: 8, end: 0),
                      const SizedBox(height: 28),
                      SectionHeader(
                        title: context.t.homeRecentJobsTitle,
                        subtitle: context.t.homeRecentJobsSubtitle,
                      ),
                      const SizedBox(height: 16),
                      recentJobs.when(
                        data: (jobs) {
                          if (jobs.isEmpty) {
                            return StatePanel(
                              icon: Iconsax.archive,
                              title: context.t.homeNoRecentTitle,
                              message: context.t.homeNoRecentMessage,
                            );
                          }

                          return Column(
                            spacing: 14,
                            children: jobs
                                .map(
                                  (job) => JobCard(
                                    job: job,
                                    onTap: () => context.push(
                                      AppRoutes.translationPreview.replaceFirst(
                                        ':jobId',
                                        job.id,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(growable: false),
                          );
                        },
                        error: (error, stackTrace) => StatePanel(
                          icon: Iconsax.warning2,
                          title: context.t.homeFailedRecentTitle,
                          message: error.toString(),
                          action: OutlinedButton.icon(
                            onPressed: () => ref
                                .read(historyControllerProvider.notifier)
                                .refresh(),
                            icon: const Icon(Iconsax.refresh),
                            label: Text(context.t.retry),
                          ),
                        ),
                        loading: () => Column(
                          spacing: 14,
                          children: const <Widget>[
                            LoadingSkeleton(height: 130),
                            LoadingSkeleton(height: 130),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      SectionHeader(
                        title: context.t.homeTrustTitle,
                        subtitle: context.t.homeTrustSubtitle,
                      ),
                      const SizedBox(height: 16),
                      TrustSignalTile(
                        icon: Iconsax.shieldTick,
                        title: context.t.homeFutureTitle,
                        subtitle: context.t.homeFutureSubtitle,
                      ),
                      const SizedBox(height: 12),
                      TrustSignalTile(
                        icon: Iconsax.magicStar,
                        title: context.t.homePreviewTitle,
                        subtitle: context.t.homePreviewSubtitle,
                      ),
                      const SizedBox(height: 12),
                      TrustSignalTile(
                        icon: Iconsax.wifiSquare,
                        title: context.t.homeStatesTitle,
                        subtitle: context.t.homeStatesSubtitle,
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
