import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/home/application/home_providers.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentJobs = ref.watch(recentJobsProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _HeroSection(),
                Transform.translate(
                  offset: const Offset(0, -72),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        _QuickActions(),
                        const SizedBox(height: 20),
                        _SectionHeader(
                          title: context.t.homeRecentJobsTitle,
                          actionLabel: context.t.homeViewAll,
                          onTap: () => context.push(AppRoutes.history),
                        ),
                        const SizedBox(height: 12),
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
                                        bottom: 12,
                                      ),
                                      child: _RecentJobCard(job: job),
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
                              label: Text(context.t.retry),
                            ),
                          ),
                          loading: () => Column(
                            children: const <Widget>[
                              LoadingSkeleton(height: 120),
                              SizedBox(height: 12),
                              LoadingSkeleton(height: 120),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        _SectionHeader(title: context.t.homeTrendingNow),
                        const SizedBox(height: 12),
                        const _TrendingRow(),
                      ],
                    ),
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

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.t.homeWelcomeTitle,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.t.homeWelcomeSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.80),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.push(AppRoutes.settings),
                style: IconButton.styleFrom(backgroundColor: Colors.white24),
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 28),
          InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => context.push(AppRoutes.search),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(22),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondaryLight,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.t.homeSearchPlaceholder,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = <_QuickActionModel>[
      _QuickActionModel(
        label: context.t.homeQuickSearch,
        icon: Icons.search_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.primary, AppColors.secondary],
        ),
        onTap: () => context.push(AppRoutes.search),
      ),
      _QuickActionModel(
        label: context.t.homeQuickHistory,
        icon: Icons.history_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.secondary, AppColors.tertiary],
        ),
        onTap: () => context.push(AppRoutes.history),
      ),
      _QuickActionModel(
        label: context.t.homeQuickUpload,
        icon: Icons.upload_file_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.tertiary, Color(0xFFF43F5E)],
        ),
        onTap: () => context.push(AppRoutes.upload),
      ),
    ];

    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: item == items.last ? 0 : 12),
                child: AppSurfaceCard(
                  onTap: item.onTap,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: item.gradient,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(item.icon, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _RecentJobCard extends StatelessWidget {
  const _RecentJobCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    final isComplete = job.status == TranslationJobStatus.completed;
    final isRunning = job.status == TranslationJobStatus.translating;

    return AppSurfaceCard(
      onTap: () {
        if (job.status == TranslationJobStatus.completed) {
          context.push(
            AppRoutes.translationResult.replaceFirst(':jobId', job.id),
          );
          return;
        }
        if (job.status == TranslationJobStatus.translating) {
          context.push(
            AppRoutes.translationPreview.replaceFirst(':jobId', job.id),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: job.sourceType.name == 'upload'
                  ? AppColors.tertiary.withValues(alpha: 0.12)
                  : AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              job.sourceType.name == 'upload'
                  ? Icons.upload_file_rounded
                  : Icons.movie_outlined,
              color: job.sourceType.name == 'upload'
                  ? AppColors.tertiary
                  : AppColors.primary,
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
                        job.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isComplete
                          ? Icons.check_circle_rounded
                          : isRunning
                          ? Icons.autorenew_rounded
                          : Icons.error_outline_rounded,
                      color: isComplete
                          ? AppColors.emerald
                          : isRunning
                          ? AppColors.primary
                          : AppColors.danger,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${job.sourceLanguage.label} -> ${job.targetLanguage.label}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: isComplete ? 1 : job.progress,
                          minHeight: 8,
                          backgroundColor: AppColors.surfaceMutedFor(context),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isComplete ? AppColors.emerald : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${((isComplete ? 1 : job.progress) * 100).round()}%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
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

class _TrendingRow extends StatelessWidget {
  const _TrendingRow();

  @override
  Widget build(BuildContext context) {
    const items = <_TrendingItem>[
      _TrendingItem(
        title: 'Oppenheimer',
        subtitle: 'Movie',
        icon: Icons.movie_filter_outlined,
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF1D4ED8), Color(0xFF7C3AED)],
        ),
      ),
      _TrendingItem(
        title: 'The Last of Us',
        subtitle: 'Series',
        icon: Icons.tv_rounded,
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
        ),
      ),
      _TrendingItem(
        title: 'Dune: Part Two',
        subtitle: 'Movie',
        icon: Icons.local_movies_outlined,
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFF59E0B), Color(0xFFEF4444)],
        ),
      ),
    ];

    return SizedBox(
      height: 194,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => context.push(AppRoutes.search),
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              width: 140,
              decoration: BoxDecoration(
                gradient: item.gradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: -14,
                    top: 18,
                    child: Icon(
                      item.icon,
                      size: 76,
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.72),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onTap});

  final String title;
  final String? actionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (actionLabel != null && onTap != null)
          TextButton(onPressed: onTap, child: Text(actionLabel!)),
      ],
    );
  }
}

class _QuickActionModel {
  const _QuickActionModel({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
}

class _TrendingItem {
  const _TrendingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
}
