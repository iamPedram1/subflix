import 'package:subflix/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

class LocalSettingsRepository implements SettingsRepository {
  LocalSettingsRepository(this._dataSource);

  final SettingsLocalDataSource _dataSource;

  @override
  Future<UserPreference> loadPreferences() {
    return _dataSource.read();
  }

  @override
  Future<UserPreference> markOnboardingSeen() async {
    final current = await _dataSource.read();
    return _dataSource.write(current.copyWith(hasSeenOnboarding: true));
  }

  @override
  Future<UserPreference> setPreferredTargetLanguage(
    AppLanguage language,
  ) async {
    final current = await _dataSource.read();
    return _dataSource.write(
      current.copyWith(preferredTargetLanguage: language),
    );
  }

  @override
  Future<UserPreference> setThemePreference(
    ThemePreference themePreference,
  ) async {
    final current = await _dataSource.read();
    return _dataSource.write(
      current.copyWith(themePreference: themePreference),
    );
  }
}
