import 'package:flutter/foundation.dart';

@immutable
class AuthConfirmEmailArgs {
  const AuthConfirmEmailArgs({this.email, this.token});

  final String? email;
  final String? token;
}
