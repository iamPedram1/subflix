import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

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
      padding: AppInsets.cardLarge,
      child: Column(
        spacing: AppSpacing.xxl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: AppInsets.chip,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: AppText(
              context.t.heroBadge,
              variant: AppTextVariant.labelLarge,
              color: AppColors.primary,
            ),
          ),
          AppText(
            context.t.heroHeadline,
            variant: AppTextVariant.headlineMedium,
          ),
          AppText(
            context.t.heroBody,
            variant: AppTextVariant.bodyLarge,
            color: AppColors.textSecondaryFor(context),
          ),
          Column(
            spacing: AppSpacing.sm,
            children: <Widget>[
              AppGradientButton(
                fullWidth: true,
                label: context.t.heroSearchCta,
                icon: Iconsax.searchNormal,
                onPressed: onSearchTap,
              ),
              OutlinedButton.icon(
                onPressed: onUploadTap,
                icon: const Icon(Iconsax.documentUpload),
                label: AppText(
                  context.t.heroUploadCta,
                  variant: AppTextVariant.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;
        final itemHeight = isCompact ? 74.0 : 80.0;
        final itemSpacing = isCompact ? AppSpacing.xs : AppSpacing.sm;

        if (isCompact) {
          return Column(
            spacing: itemSpacing,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatPathsTitle,
                  value: context.t.heroStatPathsValue,
                ),
              ),
              SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatLanguagesTitle,
                  value: context.t.heroStatLanguagesValue,
                ),
              ),
              SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatMockTitle,
                  value: context.t.heroStatMockValue,
                ),
              ),
            ],
          );
        }

        return Row(
          spacing: itemSpacing,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatPathsTitle,
                  value: context.t.heroStatPathsValue,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatLanguagesTitle,
                  value: context.t.heroStatLanguagesValue,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: itemHeight,
                child: _HeroStat(
                  title: context.t.heroStatMockTitle,
                  value: context.t.heroStatMockValue,
                ),
              ),
            ),
          ],
        );
      },
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
        color: AppColors.surfaceMutedFor(context).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          spacing: AppSpacing.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText(
              title,
              variant: AppTextVariant.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: AppColors.textMutedFor(context),
            ),
            AppText(
              value,
              variant: AppTextVariant.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
