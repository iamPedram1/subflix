import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/extensions/duration_extensions.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/translation_job_provider.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

class TranslationResultScreen extends ConsumerStatefulWidget {
  const TranslationResultScreen({required this.jobId, super.key});

  final String jobId;

  @override
  ConsumerState<TranslationResultScreen> createState() =>
      _TranslationResultScreenState();
}

class _TranslationResultScreenState
    extends ConsumerState<TranslationResultScreen> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final jobAsync = ref.watch(translationJobProvider(widget.jobId));

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: jobAsync.when(
              data: (job) {
                if (job == null) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                    children: <Widget>[
                      const SizedBox(height: 40),
                      StatePanel(
                        icon: Icons.warning_amber_rounded,
                        title: context.t.previewNotReadyTitle,
                        message: context.t.previewNotReadyMessage,
                      ),
                    ],
                  );
                }

                return ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _ResultHero(job: job),
                    Transform.translate(
                      offset: const Offset(0, -76),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            _DetailsCard(job: job)
                                .animate()
                                .fadeIn(delay: 250.ms, duration: 300.ms)
                                .moveY(begin: 24, end: 0),
                            const SizedBox(height: 16),
                            _MetricsCard(job: job)
                                .animate()
                                .fadeIn(delay: 360.ms, duration: 300.ms)
                                .moveY(begin: 24, end: 0),
                            const SizedBox(height: 16),
                            _NoticeCard(message: _warningText(context, job))
                                .animate()
                                .fadeIn(delay: 470.ms, duration: 300.ms)
                                .moveY(begin: 24, end: 0),
                            const SizedBox(height: 16),
                            _ActionSection(
                                  isExporting: _isExporting,
                                  onPreview: () => context.push(
                                    AppRoutes.translationPreview.replaceFirst(
                                      ':jobId',
                                      job.id,
                                    ),
                                  ),
                                  onExport: () => _exportJob(context, job),
                                  onHome: () => context.go(AppRoutes.home),
                                )
                                .animate()
                                .fadeIn(delay: 580.ms, duration: 300.ms)
                                .moveY(begin: 24, end: 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                children: <Widget>[
                  const SizedBox(height: 40),
                  StatePanel(
                    icon: Icons.warning_amber_rounded,
                    title: context.t.previewFailedTitle,
                    message: '$error',
                    action: OutlinedButton.icon(
                      onPressed: () =>
                          ref.invalidate(translationJobProvider(widget.jobId)),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(context.t.retry),
                    ),
                  ),
                ],
              ),
              loading: () => ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                children: const <Widget>[
                  LoadingSkeleton(height: 280),
                  SizedBox(height: 16),
                  LoadingSkeleton(height: 220),
                  SizedBox(height: 16),
                  LoadingSkeleton(height: 220),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _warningText(BuildContext context, TranslationJob job) {
    if (job.subtitleWarnings.isNotEmpty) {
      return job.subtitleWarnings.first;
    }
    return context.t.translationResultWarning;
  }

  Future<void> _exportJob(BuildContext context, TranslationJob job) async {
    setState(() => _isExporting = true);
    try {
      final result = await ref
          .read(subtitleExportRepositoryProvider)
          .exportJob(job);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.t.exportedSnack(result.fileName, result.path)),
        ),
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.exportFailedSnack('$error'))),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}

class _ResultHero extends StatelessWidget {
  const _ResultHero({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 136),
      decoration: const BoxDecoration(
        gradient: AppColors.successGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Stack(
        children: <Widget>[
          const Positioned.fill(child: _SuccessParticles()),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => context.pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.20),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Center(
                child:
                    Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        size: 58,
                        color: Colors.white,
                      ),
                    ).animate().scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1, 1),
                      duration: 500.ms,
                      curve: Curves.easeOutBack,
                    ),
              ),
              const SizedBox(height: 22),
              Text(
                    context.t.translationResultCompleteTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 120.ms, duration: 260.ms)
                  .moveY(begin: 16, end: 0),
              const SizedBox(height: 8),
              Text(
                    context.t.translationResultCompleteSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 260.ms)
                  .moveY(begin: 16, end: 0),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuccessParticles extends StatelessWidget {
  const _SuccessParticles();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: List<Widget>.generate(15, (index) {
          final top = (index * 27.0) % 260;
          final left = (index * 41.0) % 320;
          return Positioned(
            top: top,
            left: left,
            child:
                Container(
                      width: index.isEven ? 6 : 8,
                      height: index.isEven ? 6 : 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.28),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(
                      delay: Duration(milliseconds: index * 90),
                      onPlay: (controller) => controller.repeat(),
                    )
                    .moveY(begin: -20, end: 180, duration: 2400.ms)
                    .fadeIn(duration: 500.ms)
                    .fadeOut(delay: 1400.ms, duration: 900.ms),
          );
        }),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.t.translationResultDetailsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.45),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _GradientIconTile(icon: Icons.auto_awesome_rounded),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.t.translationResultMediaLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondaryFor(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.45),
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _LanguageInfo(
                    label: context.t.translationResultSourceLabel,
                    language: job.sourceLanguage,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _LanguageInfo(
                    label: context.t.translationResultTargetLabel,
                    language: job.targetLanguage,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.t.translationResultMethodAi,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondaryFor(context),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  job.translationReuse == true
                      ? context.t.jobReuseTranslation
                      : context.t.translationResultMethodAi,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsCard extends StatelessWidget {
  const _MetricsCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    final confidence = (job.subtitleConfidenceScore ?? 96).clamp(0, 100);
    final timing = (job.subtitleTimingConfidence ?? 100).clamp(0, 100);

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.t.translationResultMetricsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          _ProgressMetric(
            label: context.t.translationResultConfidenceLabel,
            value: confidence.toDouble(),
            color: AppColors.emerald,
          ),
          const SizedBox(height: 16),
          _ProgressMetric(
            label: context.t.translationResultTimingLabel,
            value: timing.toDouble(),
            color: AppColors.info,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _MetricBadge(
                icon: Icons.check_circle_rounded,
                label: context.t.translationResultTimingPreserved,
                color: AppColors.emerald,
              ),
              _MetricBadge(
                icon: Icons.schedule_rounded,
                label: context.t.translationResultProcessedIn(
                  Duration(milliseconds: job.durationMs).toStatLabel(),
                ),
                color: AppColors.info,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.warning.withValues(alpha: 0.10),
            const Color(0xFFFF8A00).withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Note',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({
    required this.isExporting,
    required this.onPreview,
    required this.onExport,
    required this.onHome,
  });

  final bool isExporting;
  final VoidCallback onPreview;
  final VoidCallback onExport;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onPreview,
            icon: const Icon(Icons.visibility_outlined),
            label: Text(context.t.translationResultPreviewCta),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AppGradientButton(
          label: isExporting
              ? context.t.exportingLabel
              : context.t.translationResultDownloadCta,
          icon: Icons.download_rounded,
          onPressed: isExporting ? null : onExport,
          fullWidth: true,
          borderRadius: BorderRadius.circular(18),
          shadow: BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.32),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: onHome,
            icon: const Icon(Icons.home_outlined),
            label: Text(context.t.translationResultHomeCta),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.surfaceMutedFor(context),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _GradientIconTile extends StatelessWidget {
  const _GradientIconTile({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class _LanguageInfo extends StatelessWidget {
  const _LanguageInfo({required this.label, required this.language});

  final String label;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondaryFor(context),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              _flagForLanguage(language),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                language.label,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressMetric extends StatelessWidget {
  const _ProgressMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryFor(context),
                ),
              ),
            ),
            Text(
              '${value.round()}%',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: AppColors.surfaceMutedFor(context),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

String _flagForLanguage(AppLanguage language) {
  return switch (language) {
    AppLanguage.english => '\u{1F1EC}\u{1F1E7}',
    AppLanguage.spanish => '\u{1F1EA}\u{1F1F8}',
    AppLanguage.french => '\u{1F1EB}\u{1F1F7}',
    AppLanguage.german => '\u{1F1E9}\u{1F1EA}',
    AppLanguage.portuguese => '\u{1F1F5}\u{1F1F9}',
    AppLanguage.arabic => '\u{1F1F8}\u{1F1E6}',
    AppLanguage.persian => '\u{1F1EE}\u{1F1F7}',
    AppLanguage.japanese => '\u{1F1EF}\u{1F1F5}',
    AppLanguage.chinese => '\u{1F1E8}\u{1F1F3}',
    AppLanguage.korean => '\u{1F1F0}\u{1F1F7}',
    AppLanguage.hindi => '\u{1F1EE}\u{1F1F3}',
    AppLanguage.turkish => '\u{1F1F9}\u{1F1F7}',
  };
}
