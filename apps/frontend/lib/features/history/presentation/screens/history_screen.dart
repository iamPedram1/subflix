import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  _HistoryFilter _filter = _HistoryFilter.all;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyControllerProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: ref.read(historyControllerProvider.notifier).refresh,
            child: ResponsiveCenter(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => context.go(AppRoutes.home),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: history.maybeWhen(
                          data: (jobs) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                context.t.historyTitle,
                                variant: AppTextVariant.headlineMedium,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 2),
                              AppText(
                                context.t.historyCountLabel(jobs.length),
                                variant: AppTextVariant.bodyMedium,
                                color: AppColors.textSecondaryFor(context),
                              ),
                            ],
                          ),
                          orElse: () => AppText(
                            context.t.historyTitle,
                            variant: AppTextVariant.headlineMedium,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _FilterRow(
                    filter: _filter,
                    onChanged: (filter) => setState(() => _filter = filter),
                  ),
                  const SizedBox(height: 16),
                  history.when(
                    data: (jobs) {
                      final filtered = _applyFilter(jobs, _filter);
                      if (filtered.isEmpty) {
                        return StatePanel(
                          icon: Icons.history_toggle_off_rounded,
                          title: context.t.historyEmptyTitle,
                          message: context.t.historyEmptyMessage,
                        );
                      }

                      return Column(
                        children: filtered
                            .map(
                              (job) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _HistoryCard(job: job),
                              ),
                            )
                            .toList(growable: false),
                      );
                    },
                    error: (error, stackTrace) => StatePanel(
                      icon: Icons.error_outline_rounded,
                      title: context.t.historyFailedTitle,
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
                    loading: () => Column(
                      children: const <Widget>[
                        LoadingSkeleton(height: 132),
                        SizedBox(height: 12),
                        LoadingSkeleton(height: 132),
                        SizedBox(height: 12),
                        LoadingSkeleton(height: 132),
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

  List<TranslationJob> _applyFilter(
    List<TranslationJob> jobs,
    _HistoryFilter filter,
  ) {
    return switch (filter) {
      _HistoryFilter.all => jobs,
      _HistoryFilter.completed =>
        jobs
            .where((job) => job.status == TranslationJobStatus.completed)
            .toList(),
      _HistoryFilter.failed =>
        jobs.where((job) => job.status == TranslationJobStatus.failed).toList(),
      _HistoryFilter.reused =>
        jobs
            .where(
              (job) =>
                  job.translationReuse == true ||
                  job.reusedExistingSubtitle == true,
            )
            .toList(),
      _HistoryFilter.ai =>
        jobs.where((job) => job.translationReuse != true).toList(),
    };
  }
}

enum _HistoryFilter { all, completed, failed, reused, ai }

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.filter, required this.onChanged});

  final _HistoryFilter filter;
  final ValueChanged<_HistoryFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final labels = <_HistoryFilter, String>{
      _HistoryFilter.all: context.t.historyFilterAll,
      _HistoryFilter.completed: context.t.historyFilterCompleted,
      _HistoryFilter.failed: context.t.historyFilterFailed,
      _HistoryFilter.reused: context.t.historyFilterReused,
      _HistoryFilter.ai: context.t.historyFilterAiTranslated,
    };

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final value = labels.keys.elementAt(index);
          final selected = value == filter;
          return ChoiceChip(
            selected: selected,
            label: AppText(labels[value]!, variant: AppTextVariant.labelLarge),
            onSelected: (_) => onChanged(value),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    final isCompleted = job.status == TranslationJobStatus.completed;
    final isFailed = job.status == TranslationJobStatus.failed;
    final statusColor = isCompleted
        ? AppColors.emerald
        : isFailed
        ? AppColors.danger
        : AppColors.primary;

    return AppSurfaceCard(
      onTap: () {
        if (isCompleted) {
          context.push(
            AppRoutes.translationResult.replaceFirst(':jobId', job.id),
          );
          return;
        }
        context.push(
          AppRoutes.translationPreview.replaceFirst(':jobId', job.id),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : isFailed
                      ? Icons.error_outline_rounded
                      : Icons.autorenew_rounded,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(job.title, variant: AppTextVariant.titleMedium),
                    const SizedBox(height: 4),
                    AppText(
                      '${job.sourceLanguage.label} -> ${job.targetLanguage.label}',
                      variant: AppTextVariant.bodyMedium,
                      color: AppColors.textSecondaryFor(context),
                    ),
                  ],
                ),
              ),
              _StatusPill(label: job.status.label, color: statusColor),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _DetailPill(label: job.format.label),
              if (job.translationReuse == true)
                _DetailPill(label: context.t.historyFilterReused),
              if (job.subtitleConfidenceScore != null)
                _DetailPill(label: '${job.subtitleConfidenceScore}%'),
            ],
          ),
          if (isFailed) ...<Widget>[
            const SizedBox(height: 12),
            AppText(
              context.t.historyFailedItemMessage,
              variant: AppTextVariant.bodySmall,
              color: AppColors.danger,
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText(label, variant: AppTextVariant.labelMedium, color: color),
    );
  }
}

class _DetailPill extends StatelessWidget {
  const _DetailPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText(
        label,
        variant: AppTextVariant.labelMedium,
        color: AppColors.textSecondaryFor(context),
      ),
    );
  }
}
