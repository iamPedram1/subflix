import 'package:flutter/foundation.dart';

/// Central app configuration sourced from compile-time values when available.
abstract final class AppConfig {
  static const String _apiBaseUrlOverride = String.fromEnvironment(
    'SUBFLIX_API_BASE_URL',
  );

  static String get apiBaseUrl {
    final rawBaseUrl = _resolvedApiBaseUrl;
    final uri = Uri.parse(rawBaseUrl);
    final segments = <String>[
      ...uri.pathSegments.where((segment) => segment.isNotEmpty),
    ];
    if (segments.isEmpty || segments.last != 'v1') {
      segments.add('v1');
    }
    return uri.replace(pathSegments: segments).toString();
  }

  static String get _resolvedApiBaseUrl {
    if (_apiBaseUrlOverride.trim().isNotEmpty) {
      return _apiBaseUrlOverride.trim();
    }

    if (kIsWeb) {
      return 'http://localhost:3000';
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'http://192.168.100.46:300',
      _ => 'http://192.168.100.46:300',
    };
  }
}
