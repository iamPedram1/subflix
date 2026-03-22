import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/features/history/data/datasources/history_local_data_source.dart';
import 'package:subflix/features/subtitles/data/services/mock_translation_composer.dart';

import '../../core/shared/test_helpers.dart';

void main() {
  test('does not reseed demo jobs after history has been cleared', () async {
    final sharedPreferences = await createMockSharedPreferences();
    final dataSource = HistoryLocalDataSource(
      sharedPreferences,
      MockTranslationComposer(),
    );

    final seededJobs = await dataSource.readJobs();
    expect(seededJobs, isNotEmpty);

    await dataSource.writeJobs(const []);

    final clearedJobs = await dataSource.readJobs();
    expect(clearedJobs, isEmpty);
  });
}
