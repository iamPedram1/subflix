import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/auth/domain/models/auth_user.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const AuthSession._();

  const factory AuthSession({
    required AuthUser user,
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required String tokenType,
  }) = _AuthSession;

  String get authorizationHeader => '$tokenType $accessToken';

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}
