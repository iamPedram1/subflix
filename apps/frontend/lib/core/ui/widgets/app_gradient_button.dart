import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.mirrorIconInRtl = false,
    this.padding,
    this.minimumHeight,
    this.borderRadius,
    this.gradient,
    this.shadow,
    this.labelStyle,
    this.iconSize,
    this.iconColor,
    this.fullWidth = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool mirrorIconInRtl;
  final EdgeInsetsGeometry? padding;
  final double? minimumHeight;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final BoxShadow? shadow;
  final TextStyle? labelStyle;
  final double? iconSize;
  final Color? iconColor;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final iconWidget = icon == null
        ? const SizedBox.shrink()
        : (mirrorIconInRtl && isRtl)
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.1415926535897932),
            child: Icon(icon, size: iconSize, color: iconColor),
          )
        : Icon(icon, size: iconSize, color: iconColor);
    final resolvedPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 18);
    final resolvedMinHeight = minimumHeight ?? 54;
    final resolvedRadius = borderRadius ?? AppRadii.medium;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: onPressed == null
            ? LinearGradient(
                colors: <Color>[
                  AppColors.outlineDark.withValues(alpha: 0.5),
                  AppColors.outlineDark.withValues(alpha: 0.4),
                ],
              )
            : (gradient ?? AppColors.accentGradient),
        borderRadius: resolvedRadius,
        boxShadow: <BoxShadow>[
          if (onPressed != null)
            shadow ??
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.32),
                  blurRadius: 26,
                  offset: const Offset(0, 14),
                ),
        ],
      ),
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: iconWidget,
          label: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: labelStyle,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: resolvedPadding,
            minimumSize: Size(0, resolvedMinHeight),
            shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
          ),
        ),
      ),
    );
  }
}
