import 'package:flutter/material.dart';

import 'package:subflix/core/extensions/date_time_extensions.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

class JobCard extends StatelessWidget {
  const JobCard({required this.job, super.key, this.onTap});

  final TranslationJob job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      onTap: onTap,
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 12,
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Iconsax.subtitle, color: AppColors.primary),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      job.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      job.sourceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _InfoChip(
                label:
                    '${job.sourceLanguage.label} -> ${job.targetLanguage.label}',
              ),
              _InfoChip(label: job.format.label),
              _InfoChip(label: job.status.label),
              if (job.translationReuse == true)
                _InfoChip(label: context.t.jobReuseTranslation),
              if (job.reusedExistingSubtitle == true)
                _InfoChip(label: context.t.jobReuseSubtitle),
              if (job.subtitleConfidenceLevel != null)
                _InfoChip(
                  label: context.t.jobConfidence(
                    '${job.subtitleConfidenceLevel}',
                  ),
                ),
            ],
          ),
          Text(
            job.createdAt.toJobTimestamp(),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
