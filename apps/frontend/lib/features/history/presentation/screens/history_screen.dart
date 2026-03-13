import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/shared/presentation/widgets/job_card.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyControllerProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: ref.read(historyControllerProvider.notifier).refresh,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              children: <Widget>[
                const SectionHeader(
                  title: 'Translation history',
                  subtitle:
                      'Reopen previous subtitle jobs, inspect the preview again, or export them later.',
                ),
                const SizedBox(height: 16),
                history.when(
                  data: (jobs) {
                    if (jobs.isEmpty) {
                      return const StatePanel(
                        icon: Iconsax.archive,
                        title: 'History is empty',
                        message:
                            'Your translated subtitle jobs will appear here after you complete a search or upload workflow.',
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
                    title: 'Could not load history',
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
                      LoadingSkeleton(height: 128),
                      LoadingSkeleton(height: 128),
                      LoadingSkeleton(height: 128),
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
