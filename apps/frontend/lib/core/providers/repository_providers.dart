import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/core/app/app_config.dart';
import 'package:subflix/core/network/accept_language.dart';
import 'package:subflix/core/network/request_identity.dart';
import 'package:subflix/core/utils/subtitle_parser.dart';
import 'package:subflix/features/history/data/repositories/backend_history_repository.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/data/repositories/backend_search_repository.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/settings/data/apis/preferences_api.dart';
import 'package:subflix/features/settings/data/repositories/backend_settings_repository.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/subtitles/data/apis/subtitles_api.dart';
import 'package:subflix/features/subtitles/data/repositories/backend_subtitle_export_repository.dart';
import 'package:subflix/features/subtitles/data/repositories/backend_subtitle_import_repository.dart';
import 'package:subflix/features/subtitles/data/repositories/backend_translation_repository.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_export_repository.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_import_repository.dart';
import 'package:subflix/features/subtitles/domain/repositories/translation_repository.dart';

part 'repository_providers.g.dart';

const String _deviceIdPreferenceKey = 'subflix.device_id';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.',
  );
}

@Riverpod(keepAlive: true)
String apiBaseUrl(Ref ref) {
  return AppConfig.apiBaseUrl;
}

@Riverpod(keepAlive: true)
String deviceId(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final existing = sharedPreferences.getString(_deviceIdPreferenceKey);
  if (existing != null && existing.isNotEmpty) {
    return existing;
  }

  final generated = createDeviceId();
  unawaited(sharedPreferences.setString(_deviceIdPreferenceKey, generated));
  return generated;
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ref.watch(apiBaseUrlProvider),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: const <String, dynamic>{
        Headers.acceptHeader: 'application/json',
      },
    ),
  );

  final deviceId = ref.watch(deviceIdProvider);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.putIfAbsent('x-device-id', () => deviceId);
        options.headers.putIfAbsent('x-request-id', createRequestId);
        options.headers['accept-language'] = resolveAcceptLanguageHeader();
        handler.next(options);
      },
    ),
  );
  return dio;
}

@Riverpod(keepAlive: true)
SubtitleParser subtitleParser(Ref ref) {
  return SubtitleParser();
}

@Riverpod(keepAlive: true)
CatalogApi catalogApi(Ref ref) {
  return CatalogApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
PreferencesApi preferencesApi(Ref ref) {
  return PreferencesApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
TranslationJobsApi translationJobsApi(Ref ref) {
  return TranslationJobsApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
SubtitlesApi subtitlesApi(Ref ref) {
  return SubtitlesApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return BackendSettingsRepository(ref.watch(preferencesApiProvider));
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return BackendHistoryRepository(ref.watch(translationJobsApiProvider));
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  return BackendSearchRepository(ref.watch(catalogApiProvider));
}

@Riverpod(keepAlive: true)
SubtitleImportRepository subtitleImportRepository(Ref ref) {
  return BackendSubtitleImportRepository(
    ref.watch(subtitlesApiProvider),
    ref.watch(subtitleParserProvider),
  );
}

@Riverpod(keepAlive: true)
SubtitleExportRepository subtitleExportRepository(Ref ref) {
  return BackendSubtitleExportRepository(ref.watch(translationJobsApiProvider));
}

@Riverpod(keepAlive: true)
TranslationRepository translationRepository(Ref ref) {
  return BackendTranslationRepository(ref.watch(translationJobsApiProvider));
}
