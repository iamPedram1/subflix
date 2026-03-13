import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

void main() {
  test('loads backend-backed preferences and persists updates', () async {
    final repository = _FakeSettingsRepository();
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(settingsControllerProvider.future);
    expect(initial.hasSeenOnboarding, isFalse);
    expect(initial.preferredTargetLanguage, AppLanguage.spanish);
    expect(initial.themePreference, ThemePreference.system);

    await container
        .read(settingsControllerProvider.notifier)
        .setPreferredTargetLanguage(AppLanguage.arabic);
    await container
        .read(settingsControllerProvider.notifier)
        .setThemePreference(ThemePreference.dark);
    await container
        .read(settingsControllerProvider.notifier)
        .markOnboardingSeen();

    final updated = container.read(settingsControllerProvider).asData!.value;
    expect(updated.hasSeenOnboarding, isTrue);
    expect(updated.preferredTargetLanguage, AppLanguage.arabic);
    expect(updated.themePreference, ThemePreference.dark);
  });
}

class _FakeSettingsRepository implements SettingsRepository {
  UserPreference _preference = const UserPreference(
    hasSeenOnboarding: false,
    preferredTargetLanguage: AppLanguage.spanish,
    themePreference: ThemePreference.system,
  );

  @override
  Future<UserPreference> loadPreferences() async => _preference;

  @override
  Future<UserPreference> markOnboardingSeen() async {
    _preference = _preference.copyWith(hasSeenOnboarding: true);
    return _preference;
  }

  @override
  Future<UserPreference> setPreferredTargetLanguage(
    AppLanguage language,
  ) async {
    _preference = _preference.copyWith(preferredTargetLanguage: language);
    return _preference;
  }

  @override
  Future<UserPreference> setThemePreference(
    ThemePreference themePreference,
  ) async {
    _preference = _preference.copyWith(themePreference: themePreference);
    return _preference;
  }
}
