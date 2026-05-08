import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

void main() {
  test(
    'falls back to defaults when cached preferences are malformed',
    () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'subflix.preferences': '{"hasSeenOnboarding":',
      });
      final sharedPreferences = await SharedPreferences.getInstance();
      final dataSource = SettingsLocalDataSource(sharedPreferences);

      final preference = await dataSource.read();

      expect(preference.hasSeenOnboarding, isFalse);
      expect(preference.preferredTargetLanguage, AppLanguage.english);
      expect(preference.themePreference, ThemePreference.system);
      expect(sharedPreferences.getString('subflix.preferences'), isNull);
    },
  );
}
