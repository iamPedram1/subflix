import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/theme.dart';
import 'package:subflix/features/auth/domain/models/auth_forgot_password_result.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/auth/domain/models/auth_signup_result.dart';
import 'package:subflix/features/auth/domain/models/auth_user.dart';
import 'package:subflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:subflix/features/history/domain/repositories/history_repository.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/domain/repositories/search_repository.dart';
import 'package:subflix/features/search/presentation/screens/search_screen.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/domain/repositories/settings_repository.dart';
import 'package:subflix/features/settings/presentation/screens/settings_screen.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/search_media_type.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/repositories/subtitle_import_repository.dart';
import 'package:subflix/features/subtitles/presentation/screens/upload_screen.dart';

void main() {
  group('redesigned screens', () {
    testWidgets('search screen shows suggestions then results', (tester) async {
      await tester.pumpWidget(
        _TestApp(
          overrides: <Object>[
            searchRepositoryProvider.overrideWithValue(
              _FakeSearchRepository(
                results: <MovieSearchItem>[
                  MovieSearchItem(
                    id: 'inception',
                    title: 'Inception',
                    year: 2010,
                    mediaType: SearchMediaType.movie,
                    synopsis: 'Dreams inside dreams.',
                    genres: const <String>['Sci-Fi', 'Thriller'],
                    runtimeMinutes: 148,
                    popularity: 9.4,
                  ),
                ],
              ),
            ),
          ],
          child: const SearchScreen(),
        ),
      );

      expect(find.text('Trending searches'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Inception');
      await tester.pump(const Duration(milliseconds: 450));
      await tester.pumpAndSettle();

      expect(find.text('Inception'), findsWidgets);
      expect(find.textContaining('Found 1 results'), findsOneWidget);
    });

    testWidgets('settings screen renders profile and theme controls', (
      tester,
    ) async {
      final repository = _FakeSettingsRepository();

      await tester.pumpWidget(
        _TestApp(
          overrides: <Object>[
            authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
            settingsRepositoryProvider.overrideWithValue(repository),
            historyRepositoryProvider.overrideWithValue(
              _FakeHistoryRepository(),
            ),
          ],
          child: const SettingsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Sign in to SubFlix'), findsOneWidget);
      expect(find.text('Sign in'), findsWidgets);
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('App Language'), findsOneWidget);
    });

    testWidgets('upload screen shows ready state after loading demo file', (
      tester,
    ) async {
      await tester.pumpWidget(
        _TestApp(
          overrides: <Object>[
            subtitleImportRepositoryProvider.overrideWithValue(
              _FakeSubtitleImportRepository(file: _demoFile()),
            ),
          ],
          child: const UploadScreen(),
        ),
      );

      await tester.tap(find.text('Use demo file'));
      await tester.pumpAndSettle();

      expect(find.text('demo.srt'), findsOneWidget);
      expect(find.text('Ready to translate'), findsOneWidget);
    });

    testWidgets('upload screen shows error state when import fails', (
      tester,
    ) async {
      await tester.pumpWidget(
        _TestApp(
          overrides: <Object>[
            subtitleImportRepositoryProvider.overrideWithValue(
              _FakeSubtitleImportRepository(error: Exception('Boom')),
            ),
          ],
          child: const UploadScreen(),
        ),
      );

      await tester.tap(find.text('Use demo file'));
      await tester.pumpAndSettle();

      expect(find.text('File import failed'), findsOneWidget);
      expect(find.textContaining('Boom'), findsOneWidget);
    });
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child, this.overrides = const <Object>[]});

  final Widget child;
  final List<Object> overrides;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }
}

class _FakeSearchRepository implements SearchRepository {
  _FakeSearchRepository({required this.results});

  final List<MovieSearchItem> results;

  @override
  Future<List<SubtitleSource>> fetchSubtitleSources(
    String mediaId, {
    String preferredLanguage = 'en',
    int? seasonNumber,
    int? episodeNumber,
    String? releaseHint,
  }) async {
    return const <SubtitleSource>[];
  }

  @override
  Future<List<MovieSearchItem>> searchTitles(String query) async {
    return results;
  }
}

class _FakeHistoryRepository implements HistoryRepository {
  @override
  Future<void> clear() async {}

  @override
  Future<List<TranslationJob>> fetchJobs() async => const <TranslationJob>[];

  @override
  Future<TranslationJob?> getJobById(String id) async => null;
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<bool> confirmEmail(String token) async => true;

  @override
  Future<AuthForgotPasswordResult> forgotPassword(String email) async =>
      const AuthForgotPasswordResult(sent: true);

  @override
  Future<AuthUser> getProfile() async => _fakeUser();

  @override
  Future<AuthSession?> restoreSession() async => null;

  @override
  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async => true;

  @override
  Future<AuthSession> refreshSession({String? refreshToken}) async =>
      _fakeSession();

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async => _fakeSession(email: email);

  @override
  Future<AuthSession> signInWithFirebase(String idToken) async => _fakeSession();

  @override
  Future<bool> signOut() async => true;

  @override
  Future<AuthSignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async => AuthSignUpResult(
    user: _fakeUser(email: email, displayName: displayName),
    verificationRequired: true,
  );
}

class _FakeSettingsRepository implements SettingsRepository {
  UserPreference preference = const UserPreference(
    hasSeenOnboarding: true,
    preferredTargetLanguage: AppLanguage.english,
    themePreference: ThemePreference.dark,
  );

  @override
  Future<UserPreference> loadPreferences() async => preference;

  @override
  Future<UserPreference> markOnboardingSeen() async {
    preference = preference.copyWith(hasSeenOnboarding: true);
    return preference;
  }

  @override
  Future<UserPreference> setPreferredTargetLanguage(
    AppLanguage language,
  ) async {
    preference = preference.copyWith(preferredTargetLanguage: language);
    return preference;
  }

  @override
  Future<UserPreference> setThemePreference(
    ThemePreference themePreference,
  ) async {
    preference = preference.copyWith(themePreference: themePreference);
    return preference;
  }
}

class _FakeSubtitleImportRepository implements SubtitleImportRepository {
  _FakeSubtitleImportRepository({this.file, this.error});

  final SubtitleFile? file;
  final Exception? error;

  @override
  Future<SubtitleFile> loadDemoFile() async {
    if (error != null) {
      throw error!;
    }
    return file!;
  }

  @override
  Future<SubtitleFile> pickSubtitleFile() async {
    if (error != null) {
      throw error!;
    }
    return file!;
  }
}

SubtitleFile _demoFile() {
  return SubtitleFile(
    id: 'demo',
    name: 'demo.srt',
    format: SubtitleFormat.srt,
    sourceLanguage: AppLanguage.english,
    lineCount: 2,
    durationMs: 4000,
    lines: const <SubtitleLine>[
      SubtitleLine(index: 1, startMs: 0, endMs: 2000, originalText: 'Hello'),
      SubtitleLine(index: 2, startMs: 2000, endMs: 4000, originalText: 'World'),
    ],
  );
}

AuthSession _fakeSession({String email = 'user@example.com'}) {
  return AuthSession(
    user: _fakeUser(email: email),
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    expiresIn: 3600,
    tokenType: 'Bearer',
  );
}

AuthUser _fakeUser({
  String email = 'user@example.com',
  String? displayName,
}) {
  return AuthUser(
    id: 'user-id',
    email: email,
    displayName: displayName,
    photoUrl: null,
    emailVerified: false,
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 1, 1),
  );
}
