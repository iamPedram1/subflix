// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSignUpResult _$AuthSignUpResultFromJson(Map<String, dynamic> json) =>
    _AuthSignUpResult(
      user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
      verificationRequired: json['verificationRequired'] as bool,
      verificationToken: json['verificationToken'] as String?,
    );

Map<String, dynamic> _$AuthSignUpResultToJson(_AuthSignUpResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'verificationRequired': instance.verificationRequired,
      'verificationToken': instance.verificationToken,
    };
