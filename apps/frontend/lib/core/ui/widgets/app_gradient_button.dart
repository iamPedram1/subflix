import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_button.dart';

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
    final leading = icon == null
        ? null
        : (mirrorIconInRtl && isRtl)
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.1415926535897932),
            child: Icon(icon, size: iconSize, color: iconColor ?? Colors.white),
          )
        : Icon(icon, size: iconSize, color: iconColor ?? Colors.white);

    return AppButton(
      label: label,
      onPressed: onPressed,
      variant: AppButtonVariant.gradient,
      leading: leading,
      fullWidth: fullWidth,
      padding: padding,
      minimumHeight: minimumHeight ?? 54,
      borderRadius: borderRadius,
      gradient: gradient,
      shadow: shadow,
      labelStyle: labelStyle,
      foregroundColor: Colors.white,
    );
  }
}
