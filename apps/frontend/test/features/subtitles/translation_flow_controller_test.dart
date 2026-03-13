import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/subtitles/application/translation_flow_controller.dart';
import 'package:subflix/features/subtitles/application/translation_flow_state.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

import '../../core/shared/test_helpers.dart';

void main() {
  test('runs a translation job and stores it in history', () async {
    final sharedPreferences = await createMockSharedPreferences();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
    );
    addTearDown(container.dispose);

    final request = TranslationRequest.catalog(
      item: const MovieSearchItem(
        id: 'dune_part_two',
        title: 'Dune: Part Two',
        year: 2024,
        mediaType: SearchMediaType.movie,
        synopsis: 'Epic science-fiction drama.',
        genres: <String>['Sci-Fi'],
        runtimeMinutes: 166,
        popularity: 9.6,
      ),
      source: const SubtitleSource(
        id: 'dune_part_two-webdl',
        label: 'English WEB-DL 1080p',
        releaseGroup: 'SubFlix Studio',
        format: SubtitleFormat.srt,
        hearingImpaired: false,
        lineCount: 612,
        downloads: 24870,
        rating: 4.9,
      ),
      targetLanguage: AppLanguage.french,
    );

    await container
        .read(translationFlowControllerProvider.notifier)
        .start(request);
    await Future<void>.delayed(const Duration(seconds: 3));

    final flowState = container.read(translationFlowControllerProvider);
    expect(flowState.status, TranslationFlowStatus.completed);
    expect(flowState.job, isNotNull);
    expect(flowState.job!.lines.first.translatedText, isNotEmpty);

    final history = await container.read(historyControllerProvider.future);
    expect(history.any((job) => job.id == flowState.job!.id), isTrue);
  });
}
