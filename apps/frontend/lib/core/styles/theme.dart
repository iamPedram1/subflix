import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:subflix/core/styles/colors.dart';

abstract final class AppTheme {
  static ThemeData light({Locale? locale}) {
    final colorScheme =
        ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: Colors.white,
          error: AppColors.danger,
          onError: Colors.white,
          surface: AppColors.surfaceLight,
          onSurface: AppColors.textPrimaryLight,
        ).copyWith(
          outline: AppColors.outlineLight,
          surfaceContainerHighest: AppColors.surfaceMutedLight,
        );

    return _themeFromScheme(
      colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.surfaceLight,
      locale: locale,
    );
  }

  static ThemeData dark({Locale? locale}) {
    final colorScheme =
        ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryDark,
          onPrimary: AppColors.backgroundDark,
          secondary: AppColors.secondary,
          onSecondary: Colors.white,
          error: AppColors.danger,
          onError: Colors.white,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.textPrimaryDark,
        ).copyWith(
          outline: AppColors.outlineDark,
          surfaceContainerHighest: AppColors.surfaceMutedDark,
        );

    return _themeFromScheme(
      colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.surfaceDark,
      locale: locale,
    );
  }

  static ThemeData _themeFromScheme(
    ColorScheme colorScheme, {
    required Color scaffoldBackgroundColor,
    required Color cardColor,
    Locale? locale,
  }) {
    final languageCode = locale?.languageCode;
    final useArabicFont = languageCode == 'ar' || languageCode == 'fa';

    final baseTextTheme =
        (useArabicFont
                ? GoogleFonts.notoSansArabicTextTheme()
                : GoogleFonts.interTextTheme())
            .apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            );

    final displayTextTheme = useArabicFont
        ? GoogleFonts.notoSansArabicTextTheme(baseTextTheme)
        : GoogleFonts.interTextTheme(baseTextTheme);

    final textTheme = baseTextTheme.copyWith(
      displayLarge: displayTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.9,
      ),
      displayMedium: displayTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.7,
      ),
      headlineLarge: displayTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineMedium: displayTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(height: 1.5),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(height: 1.5),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,
      textTheme: textTheme,
      fontFamilyFallback: const <String>[
        'Noto Sans Arabic',
        'Noto Sans',
        'Noto Sans SC',
        'Noto Sans JP',
        'Noto Sans Devanagari',
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.brightness == Brightness.light
            ? AppColors.backgroundLight
            : AppColors.backgroundDark,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
      ),
      chipTheme: ChipThemeData(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? AppColors.surfaceMutedDark
            : AppColors.surfaceMutedLight,
        selectedColor: colorScheme.primary,
        disabledColor: colorScheme.outline.withValues(alpha: 0.2),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.brightness == Brightness.dark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.outline.withValues(alpha: 0.2),
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.brightness == Brightness.dark
            ? AppColors.surfaceMutedDark
            : AppColors.surfaceMutedLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textMutedForScheme(colorScheme),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),
      dividerTheme: DividerThemeData(color: colorScheme.outline, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
