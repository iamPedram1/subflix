import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/features/history/data/datasources/history_local_data_source.dart';
import 'package:subflix/features/history/data/repositories/local_history_repository.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/search/data/apis/mock_search_api.dart';
import 'package:subflix/features/search/data/repositories/mock_search_repository.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:subflix/features/settings/data/repositories/local_settings_repository.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/subtitles/data/apis/mock_translation_api.dart';
import 'package:subflix/features/subtitles/data/repositories/mock_translation_repository.dart';
import 'package:subflix/features/subtitles/data/services/mock_translation_composer.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.',
  );
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://mock.subflix.local',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}

@Riverpod(keepAlive: true)
MockTranslationComposer mockTranslationComposer(Ref ref) {
  return MockTranslationComposer();
}

@Riverpod(keepAlive: true)
MockSearchApi mockSearchApi(Ref ref) {
  return MockSearchApi();
}

@Riverpod(keepAlive: true)
MockTranslationApi mockTranslationApi(Ref ref) {
  return MockTranslationApi(ref.watch(mockTranslationComposerProvider));
}

@Riverpod(keepAlive: true)
SettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  return SettingsLocalDataSource(ref.watch(sharedPreferencesProvider));
}

@Riverpod(keepAlive: true)
HistoryLocalDataSource historyLocalDataSource(Ref ref) {
  return HistoryLocalDataSource(
    ref.watch(sharedPreferencesProvider),
    ref.watch(mockTranslationComposerProvider),
  );
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return LocalSettingsRepository(ref.watch(settingsLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return LocalHistoryRepository(ref.watch(historyLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  return MockSearchRepository(ref.watch(mockSearchApiProvider));
}

@Riverpod(keepAlive: true)
TranslationRepository translationRepository(Ref ref) {
  return MockTranslationRepository(ref.watch(mockTranslationApiProvider));
}
