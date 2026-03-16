import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_directional_icon.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';

class SubtitleSourceCard extends StatelessWidget {
  const SubtitleSourceCard({
    required this.source,
    required this.onTap,
    super.key,
  });

  final SubtitleSource source;
  final VoidCallback onTap;

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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Iconsax.documentText,
                  color: AppColors.secondary,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      source.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      source.releaseGroup,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                  ],
                ),
              ),
          AppDirectionalIcon(
            icon: Iconsax.arrowRight,
            color: AppColors.textMutedFor(context),
          ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _SourceChip(label: source.format.label),
              _SourceChip(
                label: context.t.subtitleSourceLines('${source.lineCount}'),
              ),
              _SourceChip(
                label: context.t.subtitleSourceDownloads('${source.downloads}'),
              ),
              _SourceChip(
                label: context.t.subtitleSourceRating(
                  source.rating.toStringAsFixed(1),
                ),
              ),
              if (source.hearingImpaired)
                _SourceChip(label: context.t.subtitleSourceHiLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _SourceChip extends StatelessWidget {
  const _SourceChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: AppInsets.chip,
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondaryFor(context)),
        ),
      ),
    );
  }
}
