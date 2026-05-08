import 'dart:ui';

const Set<String> _supportedBackendLanguages = <String>{
  'en',
  'es',
  'ar',
  'fa',
  'fr',
  'de',
  'pt',
  'ja',
  'zh',
  'ko',
  'hi',
  'tr',
};

/// Resolves the backend-facing Accept-Language header value.
///
/// The backend localizes error messages using this header and falls back to
/// English when the requested language is unsupported.
String resolveAcceptLanguageHeader({Locale? locale}) {
  final resolved = (locale ?? PlatformDispatcher.instance.locale).languageCode
      .trim()
      .toLowerCase();
  if (_supportedBackendLanguages.contains(resolved)) {
    return resolved;
  }
  return 'en';
}
