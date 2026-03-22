import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/core/app/app_config.dart';
import 'package:subflix/core/app/firebase_options.dart';
import 'package:subflix/core/network/accept_language.dart';
import 'package:subflix/core/network/auth_session_interceptor.dart';
import 'package:subflix/core/network/request_identity.dart';
import 'package:subflix/core/utils/subtitle_formatter.dart';
import 'package:subflix/core/utils/subtitle_parser.dart';
import 'package:subflix/features/auth/data/apis/auth_api.dart';
import 'package:subflix/features/auth/data/repositories/backend_auth_repository.dart';
import 'package:subflix/features/auth/data/session/auth_session_store.dart';
import 'package:subflix/features/auth/data/services/firebase_oauth_service.dart';
import 'package:subflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:subflix/features/health/data/apis/health_api.dart';
import 'package:subflix/features/history/data/datasources/history_local_data_source.dart';
import 'package:subflix/features/history/data/repositories/cached_history_repository.dart';
import 'package:subflix/features/history/data/repositories/local_history_repository.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/search/data/apis/catalog_api.dart';
import 'package:subflix/features/search/data/apis/mock_search_api.dart';
import 'package:subflix/features/search/data/repositories/cached_search_repository.dart';
import 'package:subflix/features/search/data/repositories/mock_search_repository.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/settings/data/apis/preferences_api.dart';
import 'package:subflix/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:subflix/features/settings/data/repositories/cached_settings_repository.dart';
import 'package:subflix/features/settings/data/repositories/local_settings_repository.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/shared/data/apis/translation_jobs_api.dart';
import 'package:subflix/features/subtitles/data/apis/mock_translation_api.dart';
import 'package:subflix/features/subtitles/data/apis/subtitles_api.dart';
import 'package:subflix/features/subtitles/data/repositories/cached_translation_repository.dart';
import 'package:subflix/features/subtitles/data/repositories/local_subtitle_export_repository.dart';
import 'package:subflix/features/subtitles/data/repositories/local_subtitle_import_repository.dart';
import 'package:subflix/features/subtitles/data/repositories/mock_translation_repository.dart';
import 'package:subflix/features/subtitles/data/services/mock_translation_composer.dart';
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

BaseOptions _buildBaseOptions(String baseUrl) {
  return BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    headers: const <String, dynamic>{Headers.acceptHeader: 'application/json'},
  );
}

void _attachDefaultHeadersInterceptor(Dio dio, String deviceId) {
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
AuthSessionStore authSessionStore(Ref ref) {
  return AuthSessionStore(ref.watch(sharedPreferencesProvider));
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
GoogleSignIn googleSignIn(Ref ref) {
  return GoogleSignIn.instance;
}

@Riverpod(keepAlive: true)
FirebaseOAuthService firebaseOAuthService(Ref ref) {
  return FirebaseOAuthService(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
    initializeFirebase: () async {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (options == null) {
        throw StateError(
          'Firebase runtime options are missing. Provide the FIREBASE_* and GOOGLE_* dart-defines documented in README.md.',
        );
      }
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(options: options);
      }
    },
  );
}

@Riverpod(keepAlive: true)
Dio refreshDio(Ref ref) {
  final dio = Dio(_buildBaseOptions(ref.watch(apiBaseUrlProvider)));
  _attachDefaultHeadersInterceptor(dio, ref.watch(deviceIdProvider));
  return dio;
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(_buildBaseOptions(ref.watch(apiBaseUrlProvider)));
  _attachDefaultHeadersInterceptor(dio, ref.watch(deviceIdProvider));
  dio.interceptors.add(
    AuthSessionInterceptor(
      refreshDio: ref.watch(refreshDioProvider),
      sessionStore: ref.watch(authSessionStoreProvider),
    ),
  );
  return dio;
}

@Riverpod(keepAlive: true)
SubtitleParser subtitleParser(Ref ref) {
  return SubtitleParser();
}

@Riverpod(keepAlive: true)
SubtitleFormatter subtitleFormatter(Ref ref) {
  return SubtitleFormatter();
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
CatalogApi catalogApi(Ref ref) {
  return CatalogApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
HealthApi healthApi(Ref ref) {
  return HealthApi(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(dioProvider));
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
AuthRepository authRepository(Ref ref) {
  return BackendAuthRepository(
    ref.watch(authApiProvider),
    ref.watch(authSessionStoreProvider),
  );
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return CachedSettingsRepository(
    LocalSettingsRepository(ref.watch(settingsLocalDataSourceProvider)),
  );
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return CachedHistoryRepository(
    LocalHistoryRepository(ref.watch(historyLocalDataSourceProvider)),
  );
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  return CachedSearchRepository(
    MockSearchRepository(ref.watch(mockSearchApiProvider)),
  );
}

@Riverpod(keepAlive: true)
SubtitleImportRepository subtitleImportRepository(Ref ref) {
  return LocalSubtitleImportRepository(ref.watch(subtitleParserProvider));
}

@Riverpod(keepAlive: true)
SubtitleExportRepository subtitleExportRepository(Ref ref) {
  return LocalSubtitleExportRepository(ref.watch(subtitleFormatterProvider));
}

@Riverpod(keepAlive: true)
TranslationRepository translationRepository(Ref ref) {
  return CachedTranslationRepository(
    MockTranslationRepository(
      ref.watch(mockTranslationApiProvider),
      ref.watch(historyLocalDataSourceProvider),
    ),
  );
}
