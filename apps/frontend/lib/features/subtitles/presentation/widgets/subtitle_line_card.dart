import 'package:flutter/material.dart';

import 'package:subflix/core/extensions/duration_extensions.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

enum PreviewMode {
  original('Original'),
  translated('Translated'),
  bilingual('Bilingual');

  const PreviewMode(this.label);

  final String label;
}

class SubtitleLineCard extends StatelessWidget {
  const SubtitleLineCard({required this.line, required this.mode, super.key});

  final SubtitleLine line;
  final PreviewMode mode;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 10,
            children: <Widget>[
              Text(
                '#${line.index}',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.primary),
              ),
              Text(
                '${Duration(milliseconds: line.startMs).toClock()} - ${Duration(milliseconds: line.endMs).toClock()}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          if (mode != PreviewMode.translated)
            Text(
              line.originalText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          if (mode == PreviewMode.bilingual)
            Container(
              height: 1,
              color: AppColors.outline.withValues(alpha: 0.35),
            ),
          if (mode != PreviewMode.original)
            Text(
              line.translatedText ?? line.originalText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: mode == PreviewMode.bilingual
                    ? AppColors.emerald
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
        ],
      ),
    );
  }
}
