import 'package:flutter/material.dart';

enum AppTextVariant {
  displayLarge,
  displayMedium,
  headlineLarge,
  headlineMedium,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.decoration,
  });

  final String data;
  final AppTextVariant variant;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextDecoration? decoration;

  TextStyle _resolveBaseStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return switch (variant) {
          AppTextVariant.displayLarge => textTheme.displayLarge,
          AppTextVariant.displayMedium => textTheme.displayMedium,
          AppTextVariant.headlineLarge => textTheme.headlineLarge,
          AppTextVariant.headlineMedium => textTheme.headlineMedium,
          AppTextVariant.titleLarge => textTheme.titleLarge,
          AppTextVariant.titleMedium => textTheme.titleMedium,
          AppTextVariant.titleSmall => textTheme.titleSmall,
          AppTextVariant.bodyLarge => textTheme.bodyLarge,
          AppTextVariant.bodyMedium => textTheme.bodyMedium,
          AppTextVariant.bodySmall => textTheme.bodySmall,
          AppTextVariant.labelLarge => textTheme.labelLarge,
          AppTextVariant.labelMedium => textTheme.labelMedium,
          AppTextVariant.labelSmall => textTheme.labelSmall,
        } ??
        const TextStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style: _resolveBaseStyle(context)
          .copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            height: height,
            decoration: decoration,
          )
          .merge(style),
    );
  }
}
