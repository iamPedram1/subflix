import 'package:flutter/material.dart';

/// Central color tokens for the SubFlix design system.
abstract final class AppColors {
  static const Color midnight = Color(0xFF07111F);
  static const Color abyss = Color(0xFF0B1630);
  static const Color surface = Color(0xFF101D36);
  static const Color surfaceElevated = Color(0xFF162747);
  static const Color surfaceMuted = Color(0xFF1A2D4F);
  static const Color outline = Color(0xFF2A4169);
  static const Color outlineSoft = Color(0xFF223555);
  static const Color textPrimary = Color(0xFFF4F7FF);
  static const Color textSecondary = Color(0xFFB9C5DD);
  static const Color textMuted = Color(0xFF8B9AB8);
  static const Color primary = Color(0xFF5D8BFF);
  static const Color secondary = Color(0xFF8A6BFF);
  static const Color emerald = Color(0xFF15C998);
  static const Color warning = Color(0xFFF6B84B);
  static const Color danger = Color(0xFFFF6B7A);
  static const Color info = Color(0xFF53C4FF);

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
        ? textSecondary
        : scheme.onSurface.withValues(alpha: 0.68);
  }

  static Color textMutedForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? textMuted
        : scheme.onSurface.withValues(alpha: 0.5);
  }

  static Color surfaceMutedForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? surfaceMuted
        : scheme.surface.withValues(alpha: 0.78);
  }

  static Color outlineSoftForScheme(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? outlineSoft
        : scheme.outline.withValues(alpha: 0.5);
  }

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF12244A), Color(0xFF1C235A), Color(0xFF0D5A72)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, secondary, emerald],
  );
}
