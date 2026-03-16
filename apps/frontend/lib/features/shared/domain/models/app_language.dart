import 'package:freezed_annotation/freezed_annotation.dart';

enum AppLanguage {
  @JsonValue('en')
  english(code: 'en', label: 'English', nativeLabel: 'English'),
  @JsonValue('es')
  spanish(code: 'es', label: 'Spanish', nativeLabel: 'Espa\u00f1ol'),
  @JsonValue('fa')
  persian(code: 'fa', label: 'Persian', nativeLabel: '\u0641\u0627\u0631\u0633\u06cc'),
  @JsonValue('ar')
  arabic(code: 'ar', label: 'Arabic', nativeLabel: 'Al Arabiya'),
  @JsonValue('fr')
  french(code: 'fr', label: 'French', nativeLabel: 'Fran\u00e7ais'),
  @JsonValue('de')
  german(code: 'de', label: 'German', nativeLabel: 'Deutsch'),
  @JsonValue('pt')
  portuguese(code: 'pt', label: 'Portuguese', nativeLabel: 'Portugu\u00eas'),
  @JsonValue('ja')
  japanese(code: 'ja', label: 'Japanese', nativeLabel: 'Nihongo'),
  @JsonValue('zh')
  chinese(code: 'zh', label: 'Chinese', nativeLabel: '\u4e2d\u6587'),
  @JsonValue('ko')
  korean(code: 'ko', label: 'Korean', nativeLabel: 'Hangug-eo'),
  @JsonValue('hi')
  hindi(code: 'hi', label: 'Hindi', nativeLabel: 'Hindi'),
  @JsonValue('tr')
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