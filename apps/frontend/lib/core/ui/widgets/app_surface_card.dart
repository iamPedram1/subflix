import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';
import 'package:subflix/core/styles/spacing.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    required this.child,
    super.key,
    this.padding = AppInsets.card,
    this.borderRadius = AppRadii.card,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withValues(alpha: 0.94)
            : AppColors.surfaceLight.withValues(alpha: 0.98),
        borderRadius: borderRadius,
        border: Border.all(color: AppColors.outlineSoftForScheme(scheme)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.26 : 0.08),
            blurRadius: isDark ? 24 : 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: borderRadius, onTap: onTap, child: card),
    );
  }
}
