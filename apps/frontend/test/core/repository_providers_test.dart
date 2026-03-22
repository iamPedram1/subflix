import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';

import 'shared/test_helpers.dart';

void main() {
  test(
    'default repositories provide the documented local and mock flows',
    () async {
      final sharedPreferences = await createMockSharedPreferences();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
      );
      addTearDown(container.dispose);

      final preferences = await container
          .read(settingsRepositoryProvider)
          .loadPreferences();
      expect(preferences.hasSeenOnboarding, isFalse);
      expect(preferences.preferredTargetLanguage, AppLanguage.english);

      final results = await container
          .read(searchRepositoryProvider)
          .searchTitles('dune');
      expect(results.any((item) => item.title == 'Dune: Part Two'), isTrue);

      final history = await container
          .read(historyRepositoryProvider)
          .fetchJobs();
      expect(history, isNotEmpty);
    },
  );
}
