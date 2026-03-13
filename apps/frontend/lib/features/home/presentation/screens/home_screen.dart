import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/core/ui/widgets/subflix_wordmark.dart';
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
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
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
                    const SectionHeader(
                      title: 'Recent jobs',
                      subtitle:
                          'Reopen your latest subtitle sessions without starting over.',
                    ),
                    const SizedBox(height: 16),
                    recentJobs.when(
                      data: (jobs) {
                        if (jobs.isEmpty) {
                          return const StatePanel(
                            icon: Iconsax.archive,
                            title: 'No recent jobs yet',
                            message:
                                'Start with a movie search or upload a subtitle file and your recent translations will appear here.',
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
                        title: 'Could not load recent jobs',
                        message: error.toString(),
                        action: OutlinedButton.icon(
                          onPressed: () => ref
                              .read(historyControllerProvider.notifier)
                              .refresh(),
                          icon: const Icon(Iconsax.refresh),
                          label: const Text('Retry'),
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
                    const SectionHeader(
                      title: 'Why teams trust it',
                      subtitle:
                          'Mocked today, but structured like a product that can ship for real.',
                    ),
                    const SizedBox(height: 16),
                    const TrustSignalTile(
                      icon: Iconsax.shieldTick,
                      title: 'Future-ready repositories',
                      subtitle:
                          'Swappable mock repositories keep UI code insulated from backend changes.',
                    ),
                    const SizedBox(height: 12),
                    const TrustSignalTile(
                      icon: Iconsax.magicStar,
                      title: 'Preview-first translation flow',
                      subtitle:
                          'Inspect results before export with original, translated, or bilingual views.',
                    ),
                    const SizedBox(height: 12),
                    const TrustSignalTile(
                      icon: Iconsax.wifiSquare,
                      title: 'Graceful states included',
                      subtitle:
                          'Loading, empty, retry, validation, and mock offline scenarios are part of the UX from day one.',
                    ),
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
