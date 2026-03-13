import 'package:flutter/material.dart';

enum ThemePreference {
  system('System'),
  dark('Dark'),
  light('Light');

  const ThemePreference(this.label);

  final String label;

  ThemeMode toThemeMode() {
    return switch (this) {
      ThemePreference.system => ThemeMode.system,
      ThemePreference.dark => ThemeMode.dark,
      ThemePreference.light => ThemeMode.light,
    };
  }
}
