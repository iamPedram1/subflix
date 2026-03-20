import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_forgot_password_result.freezed.dart';
part 'auth_forgot_password_result.g.dart';

@freezed
abstract class AuthForgotPasswordResult with _$AuthForgotPasswordResult {
  const factory AuthForgotPasswordResult({
    required bool sent,
    String? resetToken,
  }) = _AuthForgotPasswordResult;

  factory AuthForgotPasswordResult.fromJson(Map<String, dynamic> json) =>
      _$AuthForgotPasswordResultFromJson(json);
}
