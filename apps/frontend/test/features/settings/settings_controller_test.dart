import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

import '../../core/shared/test_helpers.dart';

void main() {
  test('loads default preferences and persists updates', () async {
    final sharedPreferences = await createMockSharedPreferences();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
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
