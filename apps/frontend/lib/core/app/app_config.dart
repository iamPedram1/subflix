import 'package:flutter/foundation.dart';

/// Central app configuration sourced from compile-time values when available.
abstract final class AppConfig {
  static const String _apiBaseUrlOverride = String.fromEnvironment(
    'SUBFLIX_API_BASE_URL',
  );

  static String get apiBaseUrl {
    if (_apiBaseUrlOverride.trim().isNotEmpty) {
      return _apiBaseUrlOverride.trim();
    }

    if (kIsWeb) {
      return 'http://localhost:3000';
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'http://10.0.2.2:3000',
      _ => 'http://localhost:3000',
    };
  }
}
