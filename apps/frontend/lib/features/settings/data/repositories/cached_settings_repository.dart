import 'package:subflix/core/utils/async_cache.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

class CachedSettingsRepository implements SettingsRepository {
  CachedSettingsRepository(
    this._inner, {
    Duration ttl = const Duration(minutes: 10),
  }) : _cache = AsyncCache<UserPreference>(ttl: ttl);

  final SettingsRepository _inner;
  final AsyncCache<UserPreference> _cache;

  @override
  Future<UserPreference> loadPreferences() {
    return _cache.get('preferences', _inner.loadPreferences);
  }

  @override
  Future<UserPreference> markOnboardingSeen() async {
    final updated = await _inner.markOnboardingSeen();
    _cache.set('preferences', updated);
    return updated;
  }

  @override
  Future<UserPreference> setPreferredTargetLanguage(
    AppLanguage language,
  ) async {
    final updated = await _inner.setPreferredTargetLanguage(language);
    _cache.set('preferences', updated);
    return updated;
  }

  @override
  Future<UserPreference> setThemePreference(
    ThemePreference themePreference,
  ) async {
    final updated = await _inner.setThemePreference(themePreference);
    _cache.set('preferences', updated);
    return updated;
  }
}
