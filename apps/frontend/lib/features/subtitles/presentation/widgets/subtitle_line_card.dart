import 'package:flutter/material.dart';

import 'package:subflix/core/extensions/duration_extensions.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

enum PreviewMode { original, translated, bilingual }

extension PreviewModeLabels on PreviewMode {
  String label(BuildContext context) => switch (this) {
    PreviewMode.original => context.t.previewModeOriginal,
    PreviewMode.translated => context.t.previewModeTranslated,
    PreviewMode.bilingual => context.t.previewModeBilingual,
  };
}

class SubtitleLineCard extends StatelessWidget {
  const SubtitleLineCard({required this.line, required this.mode, super.key});

  final SubtitleLine line;
  final PreviewMode mode;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: AppInsets.cardCompact,
      borderRadius: BorderRadius.circular(22),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 10,
            children: <Widget>[
              AppText(
                '#${line.index}',
                variant: AppTextVariant.labelLarge,
                color: AppColors.primary,
              ),
              AppText(
                '${Duration(milliseconds: line.startMs).toClock()} - ${Duration(milliseconds: line.endMs).toClock()}',
                variant: AppTextVariant.bodySmall,
                color: AppColors.textMutedFor(context),
              ),
            ],
          ),
          if (mode != PreviewMode.translated)
            AppText(line.originalText, variant: AppTextVariant.bodyLarge),
          if (mode == PreviewMode.bilingual)
            Container(
              height: 1,
              color: AppColors.outline.withValues(alpha: 0.35),
            ),
          if (mode != PreviewMode.original)
            AppText(
              line.translatedText ?? line.originalText,
              variant: AppTextVariant.bodyLarge,
              color: mode == PreviewMode.bilingual
                  ? AppColors.emerald
                  : Theme.of(context).colorScheme.onSurface,
            ),
        ],
      ),
    );
  }
}
