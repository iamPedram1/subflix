import 'dart:async';

import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/auth/data/session/auth_session_store.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';

/// Adds bearer auth automatically and refreshes expired access tokens once.
class AuthSessionInterceptor extends QueuedInterceptor {
  AuthSessionInterceptor({
    required Dio refreshDio,
    required AuthSessionStore sessionStore,
  }) : _refreshDio = refreshDio,
       _sessionStore = sessionStore;

  static const String skipAuthenticationKey = 'skipAuthentication';
  static const String skipTokenRefreshKey = 'skipTokenRefresh';
  static const String retryAttemptedKey = 'authRetryAttempted';

  final Dio _refreshDio;
  final AuthSessionStore _sessionStore;

  Future<AuthSession>? _refreshOperation;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[skipAuthenticationKey] == true) {
      handler.next(options);
      return;
    }

    final session = await _sessionStore.read();
    final accessToken = session?.accessToken.trim();
    if (session != null && accessToken != null && accessToken.isNotEmpty) {
      options.headers.putIfAbsent(
        'Authorization',
        () => '${session.tokenType} $accessToken',
      );
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRefresh(err.requestOptions, err.response?.statusCode)) {
      handler.next(err);
      return;
    }

    final refreshToken = (await _sessionStore.read())?.refreshToken.trim();
    if (refreshToken == null || refreshToken.isEmpty) {
      handler.next(err);
      return;
    }

    try {
      final session = await (_refreshOperation ??= _refreshSession(
        refreshToken,
      ));
      _refreshOperation = null;

      final response = await _retryRequest(err.requestOptions, session);
      handler.resolve(response);
    } catch (_) {
      _refreshOperation = null;
      await _sessionStore.clear();
      handler.next(err);
    }
  }

  bool _shouldRefresh(RequestOptions options, int? statusCode) {
    if (statusCode != 401) {
      return false;
    }
    if (options.extra[skipTokenRefreshKey] == true ||
        options.extra[retryAttemptedKey] == true) {
      return false;
    }

    final normalizedPath = options.path.trim().toLowerCase();
    return !normalizedPath.endsWith(ApiPaths.authRefresh);
  }

  Future<AuthSession> _refreshSession(String refreshToken) async {
    final response = await _refreshDio.post<Map<String, dynamic>>(
      ApiPaths.authRefresh,
      data: <String, dynamic>{'refreshToken': refreshToken},
      options: Options(
        extra: const <String, Object>{
          skipAuthenticationKey: true,
          skipTokenRefreshKey: true,
        },
      ),
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'The backend returned an empty refresh response.',
      );
    }

    final session = AuthSession.fromJson(data);
    await _sessionStore.save(session);
    return session;
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    AuthSession session,
  ) {
    final headers = Map<String, dynamic>.from(requestOptions.headers)
      ..['Authorization'] = session.authorizationHeader;
    final extra = Map<String, dynamic>.from(requestOptions.extra)
      ..[retryAttemptedKey] = true;

    return _refreshDio.fetch<dynamic>(
      requestOptions.copyWith(headers: headers, extra: extra),
    );
  }
}
