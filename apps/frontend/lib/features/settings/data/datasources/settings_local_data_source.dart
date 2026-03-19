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
      return _defaultPreference;
    }

    try {
      return UserPreference.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await _sharedPreferences.remove(_preferencesKey);
      return _defaultPreference;
    }
  }

  Future<UserPreference> write(UserPreference preference) async {
    await _sharedPreferences.setString(
      _preferencesKey,
      jsonEncode(preference.toJson()),
    );
    return preference;
  }

  UserPreference get _defaultPreference => const UserPreference(
    hasSeenOnboarding: false,
    preferredTargetLanguage: AppLanguage.spanish,
    themePreference: ThemePreference.system,
  );
}
