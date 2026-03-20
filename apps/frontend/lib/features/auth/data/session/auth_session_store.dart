import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:subflix/features/auth/domain/models/auth_session.dart';

/// Persists the current authenticated session locally between app launches.
class AuthSessionStore {
  AuthSessionStore(this._sharedPreferences);

  static const String _preferenceKey = 'subflix.auth.session';

  final SharedPreferences _sharedPreferences;

  Future<AuthSession?> read() async {
    final rawValue = _sharedPreferences.getString(_preferenceKey);
    if (rawValue == null || rawValue.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is! Map<String, dynamic>) {
        await clear();
        return null;
      }
      return AuthSession.fromJson(decoded);
    } catch (_) {
      await clear();
      return null;
    }
  }

  Future<void> save(AuthSession session) {
    return _sharedPreferences.setString(
      _preferenceKey,
      jsonEncode(session.toJson()),
    );
  }

  Future<void> clear() {
    return _sharedPreferences.remove(_preferenceKey);
  }
}
