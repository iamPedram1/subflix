import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

class OnboardingPageCard extends StatelessWidget {
  const OnboardingPageCard({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.icon,
    required this.highlights,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String description;
  final IconData icon;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: AppRadii.card,
        border: Border.all(
          color: AppColors.outlineSoftFor(context).withValues(alpha: 0.85),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 34),
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  eyebrow,
                  variant: AppTextVariant.labelLarge,
                  color: AppColors.info,
                ),
                AppText(
                  title,
                  variant: AppTextVariant.headlineMedium,
                  color: Colors.white,
                ),
                AppText(
                  description,
                  variant: AppTextVariant.bodyLarge,
                  color: AppColors.textPrimary.withValues(alpha: 0.92),
                ),
              ],
            ),
            Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: highlights
                  .map(
                    (highlight) => Row(
                      spacing: 10,
                      children: <Widget>[
                        const Icon(
                          Iconsax.tickCircle,
                          color: Colors.white,
                          size: 20,
                        ),
                        Expanded(
                          child: AppText(
                            highlight,
                            variant: AppTextVariant.bodyMedium,
                            color: AppColors.textPrimary.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
        ),
      ),
    );
  }
}
