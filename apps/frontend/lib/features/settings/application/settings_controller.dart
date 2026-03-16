import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  Future<UserPreference> build() {
    return ref.watch(settingsRepositoryProvider).loadPreferences();
  }

  Future<void> markOnboardingSeen() async {
    final previous = state;
    final current = state.asData?.value;
    if (current != null) {
      state = AsyncValue.data(
        current.copyWith(hasSeenOnboarding: true),
      );
    }
    try {
      final updated = await ref
          .watch(settingsRepositoryProvider)
          .markOnboardingSeen();
      state = AsyncValue.data(updated);
    } catch (_) {
      state = previous;
    }
  }

  Future<void> setPreferredTargetLanguage(AppLanguage language) async {
    final previous = state;
    final current = state.asData?.value;
    if (current != null) {
      state = AsyncValue.data(
        current.copyWith(preferredTargetLanguage: language),
      );
    }
    try {
      final updated = await ref
          .watch(settingsRepositoryProvider)
          .setPreferredTargetLanguage(language);
      state = AsyncValue.data(updated);
    } catch (_) {
      state = previous;
    }
  }

  Future<void> setThemePreference(ThemePreference themePreference) async {
    final previous = state;
    final current = state.asData?.value;
    if (current != null) {
      state = AsyncValue.data(
        current.copyWith(themePreference: themePreference),
      );
    }
    try {
      final updated = await ref
          .watch(settingsRepositoryProvider)
          .setThemePreference(themePreference);
      state = AsyncValue.data(updated);
    } catch (_) {
      state = previous;
    }
  }
}
