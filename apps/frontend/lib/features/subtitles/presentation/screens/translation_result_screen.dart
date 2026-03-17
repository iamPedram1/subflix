import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/extensions/duration_extensions.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/translation_job_provider.dart';
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
                    padding: AppInsets.page,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      StatePanel(
                        icon: Iconsax.warning2,
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
                      offset: const Offset(0, -36),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            _DetailsCard(job: job),
                            const SizedBox(height: 16),
                            _MetricsCard(job: job),
                            const SizedBox(height: 16),
                            _NoticeCard(message: _warningText(context, job)),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => ListView(
                padding: AppInsets.page,
                children: <Widget>[
                  const SizedBox(height: 40),
                  StatePanel(
                    icon: Iconsax.warning2,
                    title: context.t.previewFailedTitle,
                    message: '$error',
                    action: OutlinedButton.icon(
                      onPressed: () =>
                          ref.invalidate(translationJobProvider(widget.jobId)),
                      icon: const Icon(Iconsax.refresh),
                      label: Text(context.t.retry),
                    ),
                  ),
                ],
              ),
              loading: () => ListView(
                padding: AppInsets.page,
                children: const <Widget>[
                  LoadingSkeleton(height: 280),
                  SizedBox(height: 16),
                  LoadingSkeleton(height: 180),
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 88),
      decoration: const BoxDecoration(
        gradient: AppColors.successGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () => context.pop(),
                style: IconButton.styleFrom(backgroundColor: Colors.white24),
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.tickCircle,
              size: 46,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            context.t.translationResultCompleteTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.t.translationResultCompleteSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _KeyRow(
            icon: Iconsax.video,
            label: context.t.translationResultMediaLabel,
            value: job.title,
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _LanguageTile(
                  label: context.t.translationResultSourceLabel,
                  value: job.sourceLanguage.label,
                  code: job.sourceLanguage.code.toUpperCase(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LanguageTile(
                  label: context.t.translationResultTargetLabel,
                  value: job.targetLanguage.label,
                  code: job.targetLanguage.code.toUpperCase(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _InfoPill(label: job.format.label),
              _InfoPill(
                label:
                    '${job.lineCount} ${context.t.metadataLines.toLowerCase()}',
              ),
              _InfoPill(
                label: job.translationReuse == true
                    ? context.t.jobReuseTranslation
                    : context.t.translationResultMethodAi,
              ),
            ],
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _ProgressMetric(
            label: context.t.translationResultConfidenceLabel,
            value: confidence.toDouble(),
            color: AppColors.emerald,
          ),
          const SizedBox(height: 14),
          _ProgressMetric(
            label: context.t.translationResultTimingLabel,
            value: timing.toDouble(),
            color: AppColors.info,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _InfoPill(label: context.t.translationResultTimingPreserved),
              _InfoPill(
                label: context.t.translationResultProcessedIn(
                  Duration(milliseconds: job.durationMs).toStatLabel(),
                ),
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
      padding: AppInsets.card,
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Iconsax.warning2, color: AppColors.warning),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
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
        OutlinedButton.icon(
          onPressed: onPreview,
          icon: const Icon(Icons.visibility_outlined),
          label: Text(context.t.translationResultPreviewCta),
        ),
        const SizedBox(height: 12),
        AppGradientButton(
          label: isExporting
              ? context.t.exportingLabel
              : context.t.translationResultDownloadCta,
          icon: Iconsax.export,
          onPressed: isExporting ? null : onExport,
          fullWidth: true,
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: onHome,
          icon: const Icon(Icons.home_outlined),
          label: Text(context.t.translationResultHomeCta),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _KeyRow extends StatelessWidget {
  const _KeyRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryFor(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.value,
    required this.code,
  });

  final String label;
  final String value;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardCompact,
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondaryFor(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
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
            Expanded(child: Text(label)),
            Text('${value.round()}%'),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 10,
            backgroundColor: AppColors.surfaceMutedFor(context),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}
