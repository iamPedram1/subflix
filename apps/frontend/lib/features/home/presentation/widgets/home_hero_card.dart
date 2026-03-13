import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';

class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({
    required this.onSearchTap,
    required this.onUploadTap,
    super.key,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onUploadTap;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        spacing: 22,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Premium subtitle workflow',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.primary),
            ),
          ),
          Text(
            'Translate movie and series subtitles with a studio-grade flow.',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Choose between a searchable title catalog or direct file upload, then preview and export polished subtitles in minutes.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          Row(
            spacing: 12,
            children: <Widget>[
              Expanded(
                child: AppGradientButton(
                  label: 'Search movie / series',
                  icon: Iconsax.searchNormal,
                  onPressed: onSearchTap,
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onUploadTap,
                  icon: const Icon(Iconsax.documentUpload),
                  label: const Text('Upload subtitle'),
                ),
              ),
            ],
          ),
          const _HeroStatStrip(),
        ],
      ),
    );
  }
}

class _HeroStatStrip extends StatelessWidget {
  const _HeroStatStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: const <Widget>[
        Expanded(
          child: _HeroStat(title: '2 paths', value: 'Search or upload'),
        ),
        Expanded(
          child: _HeroStat(title: '10 languages', value: 'Ready for preview'),
        ),
        Expanded(
          child: _HeroStat(title: 'Mock APIs', value: 'Backend-ready seam'),
        ),
      ],
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
            ),
            Text(value, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
