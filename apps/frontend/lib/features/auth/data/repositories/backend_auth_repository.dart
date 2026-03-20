import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/auth/data/apis/auth_api.dart';
import 'package:subflix/features/auth/data/session/auth_session_store.dart';
import 'package:subflix/features/auth/domain/models/auth_forgot_password_result.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/auth/domain/models/auth_signup_result.dart';
import 'package:subflix/features/auth/domain/models/auth_user.dart';
import 'package:subflix/features/auth/domain/repositories/auth_repository.dart';

/// Backend-backed authentication and session persistence implementation.
class BackendAuthRepository implements AuthRepository {
  BackendAuthRepository(this._api, this._sessionStore);

  final AuthApi _api;
  final AuthSessionStore _sessionStore;

  @override
  Future<AuthSession?> restoreSession() {
    return _sessionStore.read();
  }

  @override
  Future<AuthSignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return _api.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  @override
  Future<bool> confirmEmail(String token) {
    return _api.confirmEmail(token);
  }

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async {
    final session = await _api.signIn(email: email, password: password);
    await _sessionStore.save(session);
    return session;
  }

  @override
  Future<AuthSession> refreshSession({String? refreshToken}) async {
    final resolvedToken =
        refreshToken?.trim().isNotEmpty == true
            ? refreshToken!.trim()
            : (await _sessionStore.read())?.refreshToken.trim();
    if (resolvedToken == null || resolvedToken.isEmpty) {
      throw const ApiException(
        message: 'No refresh token is available for this device.',
      );
    }

    final session = await _api.refresh(resolvedToken);
    await _sessionStore.save(session);
    return session;
  }

  @override
  Future<AuthForgotPasswordResult> forgotPassword(String email) {
    return _api.forgotPassword(email);
  }

  @override
  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    final didReset = await _api.resetPassword(token: token, password: password);
    if (didReset) {
      await _sessionStore.clear();
    }
    return didReset;
  }

  @override
  Future<AuthSession> signInWithFirebase(String idToken) async {
    final session = await _api.signInWithFirebase(idToken);
    await _sessionStore.save(session);
    return session;
  }

  @override
  Future<bool> signOut() async {
    final refreshToken = (await _sessionStore.read())?.refreshToken.trim();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _sessionStore.clear();
      return false;
    }

    final revoked = await _api.signOut(refreshToken);
    await _sessionStore.clear();
    return revoked;
  }

  @override
  Future<AuthUser> getProfile() async {
    final user = await _api.getProfile();
    final current = await _sessionStore.read();
    if (current != null) {
      await _sessionStore.save(current.copyWith(user: user));
    }
    return user;
  }
}
