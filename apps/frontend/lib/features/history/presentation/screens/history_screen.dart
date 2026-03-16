import 'package:flutter/material.dart';
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
import 'package:subflix/core/styles/spacing.dart';
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
            child: ResponsiveCenter(
              child: ListView(
                padding: AppInsets.pageWithNavComfort,
                children: <Widget>[
                  SectionHeader(
                    title: context.t.historyTitle,
                    subtitle: context.t.historySubtitle,
                  ),
                  const SizedBox(height: 16),
                  history.when(
                    data: (jobs) {
                      if (jobs.isEmpty) {
                        return StatePanel(
                          icon: Iconsax.archive,
                          title: context.t.historyEmptyTitle,
                          message: context.t.historyEmptyMessage,
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
                      title: context.t.historyFailedTitle,
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
      ),
    );
  }
}
