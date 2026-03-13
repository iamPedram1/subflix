import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

class SettingsLocalDataSource {
  SettingsLocalDataSource(this._sharedPreferences);

  static const String _preferencesKey = 'subflix.preferences';

  final SharedPreferences _sharedPreferences;

  Future<UserPreference> read() async {
    final raw = _sharedPreferences.getString(_preferencesKey);
    if (raw == null) {
      return const UserPreference(
        hasSeenOnboarding: false,
        preferredTargetLanguage: AppLanguage.spanish,
        themePreference: ThemePreference.system,
      );
    }

    return UserPreference.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<UserPreference> write(UserPreference preference) async {
    await _sharedPreferences.setString(
      _preferencesKey,
      jsonEncode(preference.toJson()),
    );
    return preference;
  }
}
