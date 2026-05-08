import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/padding.dart';
import 'package:subflix/core/styles/radii.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

enum AppButtonVariant { filled, outlined, text, tonal, gradient }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    super.key,
    this.variant = AppButtonVariant.filled,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
    this.padding,
    this.minimumHeight = 54,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.borderSide,
    this.gradient,
    this.shadow,
    this.labelStyle,
    this.iconSize,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final double minimumHeight;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final BorderSide? borderSide;
  final Gradient? gradient;
  final BoxShadow? shadow;
  final TextStyle? labelStyle;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = borderRadius ?? AppRadii.medium;
    final scheme = Theme.of(context).colorScheme;
    final resolvedForeground =
        foregroundColor ?? _foregroundForVariant(context);
    final child = _ButtonChild(
      label: label,
      leading: leading,
      trailing: trailing,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      foregroundColor: resolvedForeground,
      labelStyle: labelStyle,
      iconSize: iconSize,
    );

    final button = switch (variant) {
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: resolvedForeground,
          minimumSize: Size(0, minimumHeight),
          padding: padding ?? AppPadding.button,
          side:
              borderSide ??
              BorderSide(color: scheme.outline.withValues(alpha: 0.9)),
          shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
        ),
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: resolvedForeground,
          minimumSize: Size(0, minimumHeight),
          padding: padding ?? AppPadding.button,
          shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
        ),
        child: child,
      ),
      AppButtonVariant.tonal => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          foregroundColor: resolvedForeground,
          backgroundColor:
              backgroundColor ?? AppColors.surfaceMutedFor(context),
          disabledBackgroundColor:
              disabledColor ?? scheme.outline.withValues(alpha: 0.2),
          minimumSize: Size(0, minimumHeight),
          padding: padding ?? AppPadding.button,
          shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
        ),
        child: child,
      ),
      AppButtonVariant.gradient => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: resolvedRadius,
          gradient: onPressed == null
              ? LinearGradient(
                  colors: <Color>[
                    (disabledColor ?? scheme.outline).withValues(alpha: 0.6),
                    (disabledColor ?? scheme.outline).withValues(alpha: 0.4),
                  ],
                )
              : (gradient ?? AppColors.accentGradient),
          boxShadow: <BoxShadow>[
            if (onPressed != null)
              shadow ??
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.30),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: resolvedForeground,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: Size(0, minimumHeight),
            padding: padding ?? AppPadding.button,
            shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
          ),
          child: child,
        ),
      ),
      _ => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: resolvedForeground,
          backgroundColor: backgroundColor ?? scheme.primary,
          disabledBackgroundColor:
              disabledColor ?? scheme.outline.withValues(alpha: 0.2),
          minimumSize: Size(0, minimumHeight),
          padding: padding ?? AppPadding.button,
          shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
        ),
        child: child,
      ),
    };

    return SizedBox(width: fullWidth ? double.infinity : null, child: button);
  }

  Color _foregroundForVariant(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (variant) {
      AppButtonVariant.filled => scheme.onPrimary,
      AppButtonVariant.gradient => Colors.white,
      AppButtonVariant.outlined => scheme.onSurface,
      AppButtonVariant.text => scheme.primary,
      AppButtonVariant.tonal => AppColors.textPrimaryForScheme(scheme),
    };
  }
}

class _ButtonChild extends StatelessWidget {
  const _ButtonChild({
    required this.label,
    required this.foregroundColor,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.trailingIcon,
    this.labelStyle,
    this.iconSize,
  });

  final String label;
  final Widget? leading;
  final Widget? trailing;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color foregroundColor;
  final TextStyle? labelStyle;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final leadingWidget =
        leading ??
        (leadingIcon == null
            ? null
            : Icon(leadingIcon, size: iconSize, color: foregroundColor));
    final trailingWidget =
        trailing ??
        (trailingIcon == null
            ? null
            : Icon(trailingIcon, size: iconSize, color: foregroundColor));
    final hasLeading = leadingWidget != null;
    final hasTrailing = trailingWidget != null;

    if (!hasLeading && !hasTrailing) {
      return AppText(
        label,
        variant: AppTextVariant.labelLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        color: foregroundColor,
        style: labelStyle,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (hasLeading) ...<Widget>[leadingWidget, const SizedBox(width: 10)],
        Flexible(
          child: AppText(
            label,
            variant: AppTextVariant.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            color: foregroundColor,
            style: labelStyle,
          ),
        ),
        if (hasTrailing) ...<Widget>[const SizedBox(width: 10), trailingWidget],
      ],
    );
  }
}
