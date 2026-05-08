import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    required this.subtitle,
    super.key,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText(title, variant: AppTextVariant.titleLarge),
              AppText(
                subtitle,
                variant: AppTextVariant.bodyMedium,
                color: AppColors.textSecondaryFor(context),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
