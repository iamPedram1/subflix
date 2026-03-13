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
    state = await AsyncValue.guard(
      ref.watch(settingsRepositoryProvider).markOnboardingSeen,
    );
  }

  Future<void> setPreferredTargetLanguage(AppLanguage language) async {
    state = await AsyncValue.guard(
      () => ref
          .watch(settingsRepositoryProvider)
          .setPreferredTargetLanguage(language),
    );
  }

  Future<void> setThemePreference(ThemePreference themePreference) async {
    state = await AsyncValue.guard(
      () => ref
          .watch(settingsRepositoryProvider)
          .setThemePreference(themePreference),
    );
  }
}
