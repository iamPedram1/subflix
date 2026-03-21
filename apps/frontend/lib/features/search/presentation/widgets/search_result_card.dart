import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_directional_icon.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({required this.item, required this.onTap, super.key});

  final MovieSearchItem item;
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
            spacing: 14,
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: const Icon(Iconsax.video, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      item.title,
                      variant: AppTextVariant.titleLarge,
                    ),
                    AppText(
                      '${item.mediaType.label(context)} \u2022 ${item.year}',
                      variant: AppTextVariant.bodySmall,
                      color: AppColors.textSecondaryFor(context),
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
          AppText(
            item.synopsis,
            variant: AppTextVariant.bodyMedium,
            color: AppColors.textSecondaryFor(context),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _MiniChip(label: item.genres.first),
              _MiniChip(label: '${item.runtimeMinutes}m'),
              _MiniChip(
                label: context.t.searchResultPopularity(
                  item.popularity.toStringAsFixed(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context).withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: AppInsets.chip,
        child: AppText(
          label,
          variant: AppTextVariant.labelMedium,
          color: AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}
