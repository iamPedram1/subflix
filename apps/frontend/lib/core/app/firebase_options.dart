import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Runtime Firebase configuration sourced from compile-time dart-defines.
///
/// This keeps the app buildable without checked-in platform secrets while still
/// allowing a real Firebase project to be wired in for every supported target.
abstract final class DefaultFirebaseOptions {
  static const String projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const String storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );
  static const String messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );

  static const String androidApiKey = String.fromEnvironment(
    'FIREBASE_ANDROID_API_KEY',
  );
  static const String androidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
  );

  static const String iosApiKey = String.fromEnvironment(
    'FIREBASE_IOS_API_KEY',
  );
  static const String iosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static const String iosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'com.subflix.app.subflix',
  );

  static const String macosApiKey = String.fromEnvironment(
    'FIREBASE_MACOS_API_KEY',
  );
  static const String macosAppId = String.fromEnvironment(
    'FIREBASE_MACOS_APP_ID',
  );
  static const String macosBundleId = String.fromEnvironment(
    'FIREBASE_MACOS_BUNDLE_ID',
    defaultValue: 'com.subflix.app.subflix',
  );

  static const String webApiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
  );
  static const String webAppId = String.fromEnvironment('FIREBASE_WEB_APP_ID');
  static const String webAuthDomain = String.fromEnvironment(
    'FIREBASE_WEB_AUTH_DOMAIN',
  );
  static const String webMeasurementId = String.fromEnvironment(
    'FIREBASE_WEB_MEASUREMENT_ID',
  );

  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  static const String googleClientIdIos = String.fromEnvironment(
    'GOOGLE_CLIENT_ID_IOS',
  );
  static const String googleClientIdMacos = String.fromEnvironment(
    'GOOGLE_CLIENT_ID_MACOS',
  );
  static const String googleClientIdWeb = String.fromEnvironment(
    'GOOGLE_CLIENT_ID_WEB',
  );

  static bool get isConfigured => currentPlatform != null;

  static FirebaseOptions? get currentPlatform {
    if (kIsWeb) {
      return _webOptions;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _androidOptions,
      TargetPlatform.iOS => _iosOptions,
      TargetPlatform.macOS => _macosOptions,
      _ => null,
    };
  }

  static String? get googleClientId {
    if (kIsWeb) {
      return _nonEmpty(googleClientIdWeb);
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => _nonEmpty(googleClientIdIos),
      TargetPlatform.macOS => _nonEmpty(googleClientIdMacos),
      _ => null,
    };
  }

  static String? get serverClientId => _nonEmpty(googleServerClientId);

  static FirebaseOptions? get _androidOptions {
    if (!_hasCoreValues(androidApiKey, androidAppId)) {
      return null;
    }
    return FirebaseOptions(
      apiKey: androidApiKey,
      appId: androidAppId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: _nonEmpty(storageBucket),
    );
  }

  static FirebaseOptions? get _iosOptions {
    if (!_hasCoreValues(iosApiKey, iosAppId)) {
      return null;
    }
    return FirebaseOptions(
      apiKey: iosApiKey,
      appId: iosAppId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: _nonEmpty(storageBucket),
      iosBundleId: _nonEmpty(iosBundleId),
    );
  }

  static FirebaseOptions? get _macosOptions {
    if (!_hasCoreValues(macosApiKey, macosAppId)) {
      return null;
    }
    return FirebaseOptions(
      apiKey: macosApiKey,
      appId: macosAppId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: _nonEmpty(storageBucket),
      iosBundleId: _nonEmpty(macosBundleId),
    );
  }

  static FirebaseOptions? get _webOptions {
    if (!_hasCoreValues(webApiKey, webAppId)) {
      return null;
    }
    return FirebaseOptions(
      apiKey: webApiKey,
      appId: webAppId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: _nonEmpty(storageBucket),
      authDomain: _nonEmpty(webAuthDomain),
      measurementId: _nonEmpty(webMeasurementId),
    );
  }

  static bool _hasCoreValues(String apiKey, String appId) {
    return _nonEmpty(projectId) != null &&
        _nonEmpty(messagingSenderId) != null &&
        _nonEmpty(apiKey) != null &&
        _nonEmpty(appId) != null;
  }

  static String? _nonEmpty(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }
}
