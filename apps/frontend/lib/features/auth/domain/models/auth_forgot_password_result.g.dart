// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthForgotPasswordResult _$AuthForgotPasswordResultFromJson(
  Map<String, dynamic> json,
) => _AuthForgotPasswordResult(
  sent: json['sent'] as bool,
  resetToken: json['resetToken'] as String?,
);

Map<String, dynamic> _$AuthForgotPasswordResultToJson(
  _AuthForgotPasswordResult instance,
) => <String, dynamic>{
  'sent': instance.sent,
  'resetToken': instance.resetToken,
};
