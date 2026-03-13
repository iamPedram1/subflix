// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreference {

 bool get hasSeenOnboarding; AppLanguage get preferredTargetLanguage; ThemePreference get themePreference;
/// Create a copy of UserPreference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferenceCopyWith<UserPreference> get copyWith => _$UserPreferenceCopyWithImpl<UserPreference>(this as UserPreference, _$identity);

  /// Serializes this UserPreference to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreference&&(identical(other.hasSeenOnboarding, hasSeenOnboarding) || other.hasSeenOnboarding == hasSeenOnboarding)&&(identical(other.preferredTargetLanguage, preferredTargetLanguage) || other.preferredTargetLanguage == preferredTargetLanguage)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasSeenOnboarding,preferredTargetLanguage,themePreference);

@override
String toString() {
  return 'UserPreference(hasSeenOnboarding: $hasSeenOnboarding, preferredTargetLanguage: $preferredTargetLanguage, themePreference: $themePreference)';
}


}

/// @nodoc
abstract mixin class $UserPreferenceCopyWith<$Res>  {
  factory $UserPreferenceCopyWith(UserPreference value, $Res Function(UserPreference) _then) = _$UserPreferenceCopyWithImpl;
@useResult
$Res call({
 bool hasSeenOnboarding, AppLanguage preferredTargetLanguage, ThemePreference themePreference
});




}
/// @nodoc
class _$UserPreferenceCopyWithImpl<$Res>
    implements $UserPreferenceCopyWith<$Res> {
  _$UserPreferenceCopyWithImpl(this._self, this._then);

  final UserPreference _self;
  final $Res Function(UserPreference) _then;

/// Create a copy of UserPreference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasSeenOnboarding = null,Object? preferredTargetLanguage = null,Object? themePreference = null,}) {
  return _then(_self.copyWith(
hasSeenOnboarding: null == hasSeenOnboarding ? _self.hasSeenOnboarding : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
as bool,preferredTargetLanguage: null == preferredTargetLanguage ? _self.preferredTargetLanguage : preferredTargetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as ThemePreference,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreference].
extension UserPreferencePatterns on UserPreference {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreference() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreference value)  $default,){
final _that = this;
switch (_that) {
case _UserPreference():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreference value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreference() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasSeenOnboarding,  AppLanguage preferredTargetLanguage,  ThemePreference themePreference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreference() when $default != null:
return $default(_that.hasSeenOnboarding,_that.preferredTargetLanguage,_that.themePreference);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasSeenOnboarding,  AppLanguage preferredTargetLanguage,  ThemePreference themePreference)  $default,) {final _that = this;
switch (_that) {
case _UserPreference():
return $default(_that.hasSeenOnboarding,_that.preferredTargetLanguage,_that.themePreference);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasSeenOnboarding,  AppLanguage preferredTargetLanguage,  ThemePreference themePreference)?  $default,) {final _that = this;
switch (_that) {
case _UserPreference() when $default != null:
return $default(_that.hasSeenOnboarding,_that.preferredTargetLanguage,_that.themePreference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreference implements UserPreference {
  const _UserPreference({required this.hasSeenOnboarding, required this.preferredTargetLanguage, required this.themePreference});
  factory _UserPreference.fromJson(Map<String, dynamic> json) => _$UserPreferenceFromJson(json);

@override final  bool hasSeenOnboarding;
@override final  AppLanguage preferredTargetLanguage;
@override final  ThemePreference themePreference;

/// Create a copy of UserPreference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferenceCopyWith<_UserPreference> get copyWith => __$UserPreferenceCopyWithImpl<_UserPreference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreference&&(identical(other.hasSeenOnboarding, hasSeenOnboarding) || other.hasSeenOnboarding == hasSeenOnboarding)&&(identical(other.preferredTargetLanguage, preferredTargetLanguage) || other.preferredTargetLanguage == preferredTargetLanguage)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasSeenOnboarding,preferredTargetLanguage,themePreference);

@override
String toString() {
  return 'UserPreference(hasSeenOnboarding: $hasSeenOnboarding, preferredTargetLanguage: $preferredTargetLanguage, themePreference: $themePreference)';
}


}

/// @nodoc
abstract mixin class _$UserPreferenceCopyWith<$Res> implements $UserPreferenceCopyWith<$Res> {
  factory _$UserPreferenceCopyWith(_UserPreference value, $Res Function(_UserPreference) _then) = __$UserPreferenceCopyWithImpl;
@override @useResult
$Res call({
 bool hasSeenOnboarding, AppLanguage preferredTargetLanguage, ThemePreference themePreference
});




}
/// @nodoc
class __$UserPreferenceCopyWithImpl<$Res>
    implements _$UserPreferenceCopyWith<$Res> {
  __$UserPreferenceCopyWithImpl(this._self, this._then);

  final _UserPreference _self;
  final $Res Function(_UserPreference) _then;

/// Create a copy of UserPreference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasSeenOnboarding = null,Object? preferredTargetLanguage = null,Object? themePreference = null,}) {
  return _then(_UserPreference(
hasSeenOnboarding: null == hasSeenOnboarding ? _self.hasSeenOnboarding : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
as bool,preferredTargetLanguage: null == preferredTargetLanguage ? _self.preferredTargetLanguage : preferredTargetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as ThemePreference,
  ));
}


}

// dart format on
