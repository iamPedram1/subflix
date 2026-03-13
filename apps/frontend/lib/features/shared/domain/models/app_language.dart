enum AppLanguage {
  english(code: 'en', label: 'English', nativeLabel: 'English'),
  spanish(code: 'es', label: 'Spanish', nativeLabel: 'Espanol'),
  arabic(code: 'ar', label: 'Arabic', nativeLabel: 'العربية'),
  french(code: 'fr', label: 'French', nativeLabel: 'Francais'),
  german(code: 'de', label: 'German', nativeLabel: 'Deutsch'),
  portuguese(code: 'pt', label: 'Portuguese', nativeLabel: 'Portugues'),
  japanese(code: 'ja', label: 'Japanese', nativeLabel: '日本語'),
  korean(code: 'ko', label: 'Korean', nativeLabel: '한국어'),
  hindi(code: 'hi', label: 'Hindi', nativeLabel: 'हिन्दी'),
  turkish(code: 'tr', label: 'Turkish', nativeLabel: 'Turkce');

  const AppLanguage({
    required this.code,
    required this.label,
    required this.nativeLabel,
  });

  final String code;
  final String label;
  final String nativeLabel;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}
