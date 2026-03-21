import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/auth/domain/models/auth_forgot_password_result.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/auth/domain/models/auth_signup_result.dart';
import 'package:subflix/features/auth/domain/models/auth_user.dart';

part 'auth_api.g.dart';

/// HTTP client for auth, session, and current-user endpoints.
class AuthApi {
  AuthApi(Dio dio, {String? baseUrl})
    : _client = AuthRestClient(dio, baseUrl: baseUrl);

  final AuthRestClient _client;

  Future<AuthSignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return _client.signUp(<String, dynamic>{
      'email': email,
      'password': password,
      if (displayName != null && displayName.trim().isNotEmpty)
        'displayName': displayName.trim(),
    }).guardApiCall();
  }

  Future<bool> confirmEmail(String token) async {
    final response = await _client.confirmEmail(<String, dynamic>{
      'token': token,
    }).guardApiCall();
    return response.verified == true;
  }

  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) {
    return _client.signIn(<String, dynamic>{
      'email': email,
      'password': password,
    }).guardApiCall();
  }

  Future<AuthSession> refresh(String refreshToken) {
    return _client.refresh(<String, dynamic>{
      'refreshToken': refreshToken,
    }).guardApiCall();
  }

  Future<AuthForgotPasswordResult> forgotPassword(String email) {
    return _client.forgotPassword(<String, dynamic>{
      'email': email,
    }).guardApiCall();
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await _client.resetPassword(<String, dynamic>{
      'token': token,
      'password': password,
    }).guardApiCall();
    return response.reset == true;
  }

  Future<AuthSession> signInWithFirebase(String idToken) {
    return _client.signInWithFirebase(<String, dynamic>{
      'idToken': idToken,
    }).guardApiCall();
  }

  Future<bool> signOut(String refreshToken) async {
    final response = await _client.signOut(<String, dynamic>{
      'refreshToken': refreshToken,
    }).guardApiCall();
    return response.revoked == true;
  }

  Future<AuthUser> getProfile() async {
    final response = await _client.getProfile().guardApiCall();
    return response.user;
  }
}

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String? baseUrl}) = _AuthRestClient;

  @POST(ApiPaths.authSignUp)
  Future<AuthSignUpResult> signUp(@Body() Map<String, dynamic> payload);

  @POST(ApiPaths.authConfirmEmail)
  Future<AuthActionResponse> confirmEmail(@Body() Map<String, dynamic> payload);

  @POST(ApiPaths.authSignIn)
  Future<AuthSession> signIn(@Body() Map<String, dynamic> payload);

  @POST(ApiPaths.authRefresh)
  Future<AuthSession> refresh(@Body() Map<String, dynamic> payload);

  @POST(ApiPaths.authForgotPassword)
  Future<AuthForgotPasswordResult> forgotPassword(
    @Body() Map<String, dynamic> payload,
  );

  @POST(ApiPaths.authResetPassword)
  Future<AuthActionResponse> resetPassword(
    @Body() Map<String, dynamic> payload,
  );

  @POST(ApiPaths.authFirebase)
  Future<AuthSession> signInWithFirebase(@Body() Map<String, dynamic> payload);

  @POST(ApiPaths.authSignOut)
  Future<AuthActionResponse> signOut(@Body() Map<String, dynamic> payload);

  @GET(ApiPaths.authMe)
  Future<AuthProfileResponse> getProfile();
}

@JsonSerializable(createToJson: false)
class AuthActionResponse {
  const AuthActionResponse({this.verified, this.reset, this.revoked});

  factory AuthActionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthActionResponseFromJson(json);

  final bool? verified;
  final bool? reset;
  final bool? revoked;
}

@JsonSerializable(createToJson: false)
class AuthProfileResponse {
  const AuthProfileResponse({required this.user});

  factory AuthProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthProfileResponseFromJson(json);

  final AuthUser user;
}
