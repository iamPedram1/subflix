import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

part 'user_preference.freezed.dart';
part 'user_preference.g.dart';

@freezed
abstract class UserPreference with _$UserPreference {
  const factory UserPreference({
    required bool hasSeenOnboarding,
    required AppLanguage preferredTargetLanguage,
    required ThemePreference themePreference,
  }) = _UserPreference;

  factory UserPreference.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceFromJson(json);
}
