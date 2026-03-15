import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';

enum ThemePreference { system, dark, light }

extension ThemePreferenceLabel on ThemePreference {
  String label(BuildContext context) => switch (this) {
    ThemePreference.system => context.t.themeSystem,
    ThemePreference.dark => context.t.themeDark,
    ThemePreference.light => context.t.themeLight,
  };
}

extension ThemePreferenceMode on ThemePreference {
  ThemeMode toThemeMode() {
    return switch (this) {
      ThemePreference.system => ThemeMode.system,
      ThemePreference.dark => ThemeMode.dark,
      ThemePreference.light => ThemeMode.light,
    };
  }
}
