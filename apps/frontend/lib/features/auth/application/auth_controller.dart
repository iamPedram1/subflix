import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/auth/domain/models/auth_forgot_password_result.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/auth/domain/models/auth_signup_result.dart';
import 'package:subflix/features/auth/domain/models/auth_user.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthSession?> build() {
    return ref.watch(authRepositoryProvider).restoreSession();
  }

  Future<AuthSignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password, displayName: displayName);
  }

  Future<bool> confirmEmail(String token) {
    return ref.read(authRepositoryProvider).confirmEmail(token);
  }

  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async {
    final session = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    state = AsyncValue.data(session);
    return session;
  }

  Future<AuthSession> refreshSession() async {
    final session = await ref.read(authRepositoryProvider).refreshSession();
    state = AsyncValue.data(session);
    return session;
  }

  Future<AuthForgotPasswordResult> forgotPassword(String email) {
    return ref.read(authRepositoryProvider).forgotPassword(email);
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    final didReset = await ref
        .read(authRepositoryProvider)
        .resetPassword(token: token, password: password);
    if (didReset) {
      state = const AsyncValue.data(null);
    }
    return didReset;
  }

  Future<AuthSession> signInWithFirebase(String idToken) async {
    final session = await ref
        .read(authRepositoryProvider)
        .signInWithFirebase(idToken);
    state = AsyncValue.data(session);
    return session;
  }

  Future<bool> signOut() async {
    final didRevoke = await ref.read(authRepositoryProvider).signOut();
    state = const AsyncValue.data(null);
    return didRevoke;
  }

  Future<AuthUser> refreshProfile() async {
    final user = await ref.read(authRepositoryProvider).getProfile();
    final currentSession = state.asData?.value;
    if (currentSession != null) {
      state = AsyncValue.data(currentSession.copyWith(user: user));
    }
    return user;
  }
}
