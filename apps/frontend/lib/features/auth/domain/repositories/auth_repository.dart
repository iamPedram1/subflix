import 'package:subflix/features/auth/domain/models/auth_forgot_password_result.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/auth/domain/models/auth_signup_result.dart';
import 'package:subflix/features/auth/domain/models/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthSession?> restoreSession();

  Future<AuthSignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  Future<bool> confirmEmail(String token);

  Future<AuthSession> signIn({
    required String email,
    required String password,
  });

  Future<AuthSession> refreshSession({String? refreshToken});

  Future<AuthForgotPasswordResult> forgotPassword(String email);

  Future<bool> resetPassword({
    required String token,
    required String password,
  });

  Future<AuthSession> signInWithFirebase(String idToken);

  Future<bool> signOut();

  Future<AuthUser> getProfile();
}
