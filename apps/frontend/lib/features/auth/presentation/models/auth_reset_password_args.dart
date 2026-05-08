import 'package:flutter/foundation.dart';

@immutable
class AuthResetPasswordArgs {
  const AuthResetPasswordArgs({this.email, this.token});

  final String? email;
  final String? token;
}
