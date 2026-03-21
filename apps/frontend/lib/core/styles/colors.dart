import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color midnight = backgroundDark;
  static const Color abyss = Color(0xFF13131B);
  static const Color surface = surfaceDark;
  static const Color surfaceElevated = surfaceDark;
  static const Color surfaceMuted = surfaceMutedDark;
  static const Color outline = outlineDark;
  static const Color outlineSoft = outlineDark;
  static const Color textPrimary = textPrimaryDark;
  static const Color textSecondary = textSecondaryDark;
  static const Color textMuted = textSecondaryDark;
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF18181B);
  static const Color surfaceMutedLight = Color(0xFFF4F4F5);
  static const Color surfaceMutedDark = Color(0xFF27272A);
  static const Color outlineLight = Color(0xFFE5E7EB);
  static const Color outlineDark = Color(0xFF27272A);
  static const Color textPrimaryLight = Color(0xFF0A0A0A);
  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color tertiary = Color(0xFFEC4899);
  static const Color emerald = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF38BDF8);

  static Color textSecondaryFor(BuildContext context) {
    return textSecondaryForScheme(Theme.of(context).colorScheme);
  }

  static Color textMutedFor(BuildContext context) {
    return textMutedForScheme(Theme.of(context).colorScheme);
  }

  static Color surfaceMutedFor(BuildContext context) {
    return surfaceMutedForScheme(Theme.of(context).colorScheme);
  }

  static Color outlineSoftFor(BuildContext context) {
    return outlineSoftForScheme(Theme.of(context).colorScheme);
  }

  static Color textSecondaryForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? textSecondaryDark
        : scheme.onSurface.withValues(alpha: 0.68);
  }

  static Color textPrimaryForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? textPrimaryDark
        : textPrimaryLight;
  }

  static Color textMutedForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? textSecondaryDark.withValues(alpha: 0.72)
        : scheme.onSurface.withValues(alpha: 0.5);
  }

  static Color surfaceMutedForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? surfaceMutedDark
        : surfaceMutedLight;
  }

  static Color outlineSoftForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? outlineDark.withValues(alpha: 0.88)
        : scheme.outline.withValues(alpha: 0.5);
  }

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, secondary, tertiary],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, secondary],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[emerald, Color(0xFF059669)],
  );
}
