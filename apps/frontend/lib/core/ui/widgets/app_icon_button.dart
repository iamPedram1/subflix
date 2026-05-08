import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';

enum AppIconButtonVariant { filled, tonal, outlined, ghost }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.variant = AppIconButtonVariant.tonal,
    this.size = 48,
    this.iconSize = 22,
    this.foregroundColor,
    this.backgroundColor,
    this.borderSide,
    this.borderRadius,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final double iconSize;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final resolvedRadius = borderRadius ?? AppRadii.medium;
    final resolvedForeground =
        foregroundColor ??
        switch (variant) {
          AppIconButtonVariant.filled => scheme.onPrimary,
          AppIconButtonVariant.tonal => scheme.onSurface,
          AppIconButtonVariant.outlined => scheme.onSurface,
          AppIconButtonVariant.ghost => scheme.onSurface,
        };
    final resolvedBackground =
        backgroundColor ??
        switch (variant) {
          AppIconButtonVariant.filled => scheme.primary,
          AppIconButtonVariant.tonal => AppColors.surfaceMutedFor(context),
          AppIconButtonVariant.outlined => Colors.transparent,
          AppIconButtonVariant.ghost => Colors.transparent,
        };

    final child = SizedBox(
      width: size,
      height: size,
      child: Icon(icon, size: iconSize, color: resolvedForeground),
    );

    return Material(
      color: resolvedBackground,
      shape: RoundedRectangleBorder(
        borderRadius: resolvedRadius,
        side:
            borderSide ??
            (variant == AppIconButtonVariant.outlined
                ? BorderSide(color: scheme.outline.withValues(alpha: 0.9))
                : BorderSide.none),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: resolvedRadius,
        child: tooltip == null
            ? child
            : Tooltip(message: tooltip!, child: child),
      ),
    );
  }
}
