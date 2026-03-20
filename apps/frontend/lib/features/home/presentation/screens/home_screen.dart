import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/app/router/app_routes_data.dart';
import 'package:subflix/core/extensions/date_time_extensions.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/health/application/backend_health_provider.dart';
import 'package:subflix/features/health/domain/models/backend_health.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/home/application/home_providers.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';

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
                _HeroHeaderBlock(backendHealth: backendHealth),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _SectionHeader(
                        title: 'Recent Translations',
                        actionLabel: context.t.homeViewAll,
                        onTap: () => const HistoryRoute().go(context),
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
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _RecentTranslationCard(job: job),
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
                            LoadingSkeleton(height: 118),
                            SizedBox(height: 12),
                            LoadingSkeleton(height: 118),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _TrendingHeader(),
                      const SizedBox(height: 12),
                      const _TrendingRow(),
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

class _HeroHeaderBlock extends StatelessWidget {
  const _HeroHeaderBlock({required this.backendHealth});

  static const double _quickActionsOverlap = 76;

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: _quickActionsOverlap),
          child: _HeroSection(backendHealth: backendHealth),
        ),
        const Positioned(
          left: 16,
          right: 16,
          bottom: 0,
          child: _QuickActions(),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.backendHealth});

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 64),
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
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _BackendStatusPill(backendHealth: backendHealth),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.push(AppRoutes.settings),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.20),
                  minimumSize: const Size(48, 48),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 28),
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => context.push(AppRoutes.search),
            child: Material(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFFD4D4D8)
                      : const Color(0xFFE5E7EB),
                  width: 1.2,
                ),
              ),
              shadowColor: Colors.black.withValues(alpha: isDark ? 0.18 : 0.10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.18 : 0.10,
                      ),
                      blurRadius: isDark ? 28 : 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textPrimaryLight,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.t.homeSearchPlaceholder,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textPrimaryLight.withValues(
                            alpha: 0.78,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackendStatusPill extends StatelessWidget {
  const _BackendStatusPill({required this.backendHealth});

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    final (icon, label, color) = backendHealth.when(
      data: (_) => (
        Icons.cloud_done_rounded,
        'Backend online',
        const Color(0xFF22C55E),
      ),
      error: (_, _) => (
        Icons.cloud_off_rounded,
        'Backend unavailable',
        const Color(0xFFF97316),
      ),
      loading: () => (
        Icons.sync_rounded,
        'Checking backend',
        const Color(0xFFEAB308),
      ),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

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
        onTap: () => const HistoryRoute().go(context),
      ),
      _QuickActionModel(
        label: context.t.homeQuickUpload,
        icon: Icons.file_upload_outlined,
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
                          borderRadius: BorderRadius.circular(14),
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

class _RecentTranslationCard extends StatelessWidget {
  const _RecentTranslationCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    final mediaType = _inferMediaType(job);
    final statusIcon = _statusIcon(job.status);
    final statusColor = _statusColor(job.status);
    final isCompleted = job.status == TranslationJobStatus.completed;
    final confidence = (job.subtitleConfidenceScore ?? 96).clamp(0, 100);
    final showsReuse =
        job.translationReuse == true || job.reusedExistingSubtitle == true;

    return AppSurfaceCard(
      onTap: () {
        if (job.status == TranslationJobStatus.completed) {
          context.push(
            AppRoutes.translationResult.replaceFirst(':jobId', job.id),
          );
        } else {
          context.push(
            AppRoutes.translationPreview.replaceFirst(':jobId', job.id),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: mediaType == _RecentMediaType.movie
                  ? AppColors.primary.withValues(alpha: 0.10)
                  : AppColors.secondary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              mediaType == _RecentMediaType.movie
                  ? Icons.movie_outlined
                  : Icons.tv_rounded,
              color: mediaType == _RecentMediaType.movie
                  ? AppColors.primary
                  : AppColors.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        job.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (job.status == TranslationJobStatus.translating)
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            statusColor,
                          ),
                        ),
                      )
                    else
                      Icon(statusIcon, color: statusColor, size: 20),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language_rounded,
                      size: 16,
                      color: AppColors.textSecondaryFor(context),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      job.targetLanguage.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                    if (showsReuse) ...<Widget>[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.emerald.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Reused',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.emerald,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      job.updatedAt.toJobTimestamp(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                    const Spacer(),
                    if (isCompleted)
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 80,
                              height: 6,
                              color: AppColors.surfaceMutedFor(context),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 80 * (confidence / 100),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        AppColors.emerald,
                                        Color(0xFF10B981),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$confidence%',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.textSecondaryFor(context),
                                ),
                          ),
                        ],
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

class _TrendingHeader extends StatelessWidget {
  const _TrendingHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.trending_up_rounded, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          context.t.homeTrendingNow,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
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
        subtitle: 'movie',
        image:
            'https://images.unsplash.com/photo-1756412955475-7e1ed16869af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb3ZpZSUyMHBvc3RlciUyMGNvbGxlY3Rpb258ZW58MXx8fHwxNzczNjkwNzc1fDA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
      _TrendingItem(
        title: 'The Last of Us',
        subtitle: 'series',
        image:
            'https://images.unsplash.com/photo-1705123898140-11c516829f4c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0diUyMHNlcmllcyUyMHNjcmVlbnxlbnwxfHx8fDE3NzM2ODQyMDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
      _TrendingItem(
        title: 'Dune: Part Two',
        subtitle: 'movie',
        image:
            'https://images.unsplash.com/photo-1659497379075-a807be116f74?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmaWxtJTIwcmVlbCUyMGNpbmVtYXxlbnwxfHx8fDE3NzM2OTA3NzV8MA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
    ];

    return SizedBox(
      height: 198,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => context.push(AppRoutes.search),
            borderRadius: BorderRadius.circular(18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 128,
                height: 192,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.surfaceMutedFor(context)),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Color(0x26000000),
                            Color(0xCC000000),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.66),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        if (actionLabel != null && onTap != null)
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel!),
          ),
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
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;
}

enum _RecentMediaType { movie, series }

_RecentMediaType _inferMediaType(TranslationJob job) {
  final title = job.title.toLowerCase();
  if (title.contains('episode') ||
      title.contains('season') ||
      title.contains('s0')) {
    return _RecentMediaType.series;
  }
  if (job.sourceType == TranslationSourceType.upload) {
    return _RecentMediaType.movie;
  }
  return _RecentMediaType.movie;
}

IconData _statusIcon(TranslationJobStatus status) {
  return switch (status) {
    TranslationJobStatus.completed => Icons.check_circle_rounded,
    TranslationJobStatus.failed => Icons.error_outline_rounded,
    _ => Icons.autorenew_rounded,
  };
}

Color _statusColor(TranslationJobStatus status) {
  return switch (status) {
    TranslationJobStatus.completed => AppColors.emerald,
    TranslationJobStatus.failed => AppColors.danger,
    _ => AppColors.primary,
  };
}
