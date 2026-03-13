import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';

class StatePanel extends StatelessWidget {
  const StatePanel({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: AppRadii.large,
        border: Border.all(
          color: AppColors.outlineSoft.withValues(alpha: 0.85),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 14,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: AppColors.primary),
            ),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            ?action,
          ],
        ),
      ),
    );
  }
}
