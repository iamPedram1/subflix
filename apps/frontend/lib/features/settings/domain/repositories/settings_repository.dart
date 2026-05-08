import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';

abstract interface class SettingsRepository {
  Future<UserPreference> loadPreferences();

  Future<UserPreference> markOnboardingSeen();

  Future<UserPreference> setPreferredTargetLanguage(AppLanguage language);

  Future<UserPreference> setThemePreference(ThemePreference themePreference);
}
