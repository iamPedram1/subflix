// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) =>
    _UserPreference(
      hasSeenOnboarding: json['hasSeenOnboarding'] as bool,
      preferredTargetLanguage: $enumDecode(
        _$AppLanguageEnumMap,
        json['preferredTargetLanguage'],
      ),
      themePreference: $enumDecode(
        _$ThemePreferenceEnumMap,
        json['themePreference'],
      ),
    );

Map<String, dynamic> _$UserPreferenceToJson(_UserPreference instance) =>
    <String, dynamic>{
      'hasSeenOnboarding': instance.hasSeenOnboarding,
      'preferredTargetLanguage':
          _$AppLanguageEnumMap[instance.preferredTargetLanguage]!,
      'themePreference': _$ThemePreferenceEnumMap[instance.themePreference]!,
    };

const _$AppLanguageEnumMap = {
  AppLanguage.english: 'en',
  AppLanguage.spanish: 'es',
  AppLanguage.persian: 'fa',
  AppLanguage.arabic: 'ar',
  AppLanguage.french: 'fr',
  AppLanguage.german: 'de',
  AppLanguage.portuguese: 'pt',
  AppLanguage.japanese: 'ja',
  AppLanguage.chinese: 'zh',
  AppLanguage.korean: 'ko',
  AppLanguage.hindi: 'hi',
  AppLanguage.turkish: 'tr',
};

const _$ThemePreferenceEnumMap = {
  ThemePreference.system: 'system',
  ThemePreference.dark: 'dark',
  ThemePreference.light: 'light',
};
