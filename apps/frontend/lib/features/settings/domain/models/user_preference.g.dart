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
  AppLanguage.english: 'english',
  AppLanguage.spanish: 'spanish',
  AppLanguage.arabic: 'arabic',
  AppLanguage.french: 'french',
  AppLanguage.german: 'german',
  AppLanguage.portuguese: 'portuguese',
  AppLanguage.japanese: 'japanese',
  AppLanguage.korean: 'korean',
  AppLanguage.hindi: 'hindi',
  AppLanguage.turkish: 'turkish',
};

const _$ThemePreferenceEnumMap = {
  ThemePreference.system: 'system',
  ThemePreference.dark: 'dark',
  ThemePreference.light: 'light',
};
