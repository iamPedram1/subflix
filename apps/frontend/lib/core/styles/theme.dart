import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:subflix/core/styles/colors.dart';

abstract final class AppTheme {
  static ThemeData light({Locale? locale}) {
    final colorScheme =
        ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: const Color(0xFFF6F8FC),
        ).copyWith(
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF111827),
          error: AppColors.danger,
          onError: Colors.white,
          outline: const Color(0xFFD5DEEF),
        );

    return _themeFromScheme(
      colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF3F6FC),
      cardColor: Colors.white,
      locale: locale,
    );
  }

  static ThemeData dark({Locale? locale}) {
    final colorScheme =
        ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
        ).copyWith(
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.textPrimary,
          error: AppColors.danger,
          onError: Colors.white,
          outline: AppColors.outline,
        );

    return _themeFromScheme(
      colorScheme,
      scaffoldBackgroundColor: AppColors.midnight,
      cardColor: AppColors.surface,
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
                : GoogleFonts.plusJakartaSansTextTheme())
            .apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            );

    final displayTextTheme = useArabicFont
        ? GoogleFonts.notoSansArabicTextTheme(baseTextTheme)
        : GoogleFonts.spaceGroteskTextTheme(baseTextTheme);
    final textTheme = baseTextTheme.copyWith(
      displayLarge: displayTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -1.4,
      ),
      displayMedium: displayTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
      ),
      headlineLarge: displayTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
      ),
      headlineMedium: displayTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(height: 1.45),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(height: 1.45),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
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
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.brightness == Brightness.light
            ? Colors.white
            : colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        shape: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: colorScheme.surface.withValues(alpha: 0.9),
        selectedColor: colorScheme.primary.withValues(alpha: 0.18),
        disabledColor: colorScheme.outline.withValues(alpha: 0.2),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.35)),
        shape: const StadiumBorder(),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface.withValues(alpha: 0.96),
        indicatorColor: colorScheme.primary.withValues(alpha: 0.16),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : AppColors.textMutedForScheme(colorScheme),
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? colorScheme.onSurface
                : AppColors.textMutedForScheme(colorScheme),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.outline.withValues(alpha: 0.2),
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          textStyle: textTheme.labelLarge,
          side: BorderSide(
            color: colorScheme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface.withValues(alpha: 0.92),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textMutedForScheme(colorScheme),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withValues(alpha: 0.3),
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
