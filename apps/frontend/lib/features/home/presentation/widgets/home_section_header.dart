import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    required this.title,
    super.key,
    this.actionLabel,
    this.onTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppText(
            title,
            variant: AppTextVariant.titleLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (actionLabel != null && onTap != null)
          AppButton(
            label: actionLabel!,
            onPressed: onTap,
            variant: AppButtonVariant.text,
            minimumHeight: 32,
            padding: EdgeInsets.zero,
          ),
      ],
    );
  }
}
