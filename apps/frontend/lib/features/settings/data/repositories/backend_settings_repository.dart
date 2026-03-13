import 'package:subflix/features/settings/data/apis/preferences_api.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

/// Backend-backed implementation for persisted device preferences.
class BackendSettingsRepository implements SettingsRepository {
  BackendSettingsRepository(this._api);

  final PreferencesApi _api;

  @override
  Future<UserPreference> loadPreferences() {
    return _api.getPreferences();
  }

  @override
  Future<UserPreference> markOnboardingSeen() {
    return _api.patchPreferences(
      const <String, dynamic>{'hasSeenOnboarding': true},
    );
  }

  @override
  Future<UserPreference> setPreferredTargetLanguage(AppLanguage language) {
    return _api.patchPreferences(
      <String, dynamic>{'preferredTargetLanguage': language.code},
    );
  }

  @override
  Future<UserPreference> setThemePreference(
    ThemePreference themePreference,
  ) {
    return _api.patchPreferences(
      <String, dynamic>{'themePreference': themePreference.name},
    );
  }
}
