import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/auth/domain/models/auth_user.dart';

part 'auth_signup_result.freezed.dart';
part 'auth_signup_result.g.dart';

@freezed
abstract class AuthSignUpResult with _$AuthSignUpResult {
  const factory AuthSignUpResult({
    required AuthUser user,
    required bool verificationRequired,
    String? verificationToken,
  }) = _AuthSignUpResult;

  factory AuthSignUpResult.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpResultFromJson(json);
}
