import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/extensions/date_time_extensions.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/shared/domain/models/translation_job_status.dart';
import 'package:subflix/features/shared/domain/models/translation_source_type.dart';

class RecentTranslationCard extends StatelessWidget {
  const RecentTranslationCard({required this.job, super.key});

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
                      child: AppText(
                        job.title,
                        variant: AppTextVariant.titleMedium,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                    AppText(
                      job.targetLanguage.label,
                      variant: AppTextVariant.bodySmall,
                      color: AppColors.textSecondaryFor(context),
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
                        child: const AppText(
                          'Reused',
                          variant: AppTextVariant.labelSmall,
                          color: AppColors.emerald,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    AppText(
                      job.updatedAt.toJobTimestamp(),
                      variant: AppTextVariant.bodySmall,
                      color: AppColors.textSecondaryFor(context),
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
                          AppText(
                            '$confidence%',
                            variant: AppTextVariant.labelSmall,
                            color: AppColors.textSecondaryFor(context),
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
