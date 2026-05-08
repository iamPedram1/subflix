// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_signup_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthSignUpResult {

 AuthUser get user; bool get verificationRequired; String? get verificationToken;
/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSignUpResultCopyWith<AuthSignUpResult> get copyWith => _$AuthSignUpResultCopyWithImpl<AuthSignUpResult>(this as AuthSignUpResult, _$identity);

  /// Serializes this AuthSignUpResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSignUpResult&&(identical(other.user, user) || other.user == user)&&(identical(other.verificationRequired, verificationRequired) || other.verificationRequired == verificationRequired)&&(identical(other.verificationToken, verificationToken) || other.verificationToken == verificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,verificationRequired,verificationToken);

@override
String toString() {
  return 'AuthSignUpResult(user: $user, verificationRequired: $verificationRequired, verificationToken: $verificationToken)';
}


}

/// @nodoc
abstract mixin class $AuthSignUpResultCopyWith<$Res>  {
  factory $AuthSignUpResultCopyWith(AuthSignUpResult value, $Res Function(AuthSignUpResult) _then) = _$AuthSignUpResultCopyWithImpl;
@useResult
$Res call({
 AuthUser user, bool verificationRequired, String? verificationToken
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthSignUpResultCopyWithImpl<$Res>
    implements $AuthSignUpResultCopyWith<$Res> {
  _$AuthSignUpResultCopyWithImpl(this._self, this._then);

  final AuthSignUpResult _self;
  final $Res Function(AuthSignUpResult) _then;

/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? verificationRequired = null,Object? verificationToken = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,verificationRequired: null == verificationRequired ? _self.verificationRequired : verificationRequired // ignore: cast_nullable_to_non_nullable
as bool,verificationToken: freezed == verificationToken ? _self.verificationToken : verificationToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSignUpResult].
extension AuthSignUpResultPatterns on AuthSignUpResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSignUpResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSignUpResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSignUpResult value)  $default,){
final _that = this;
switch (_that) {
case _AuthSignUpResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSignUpResult value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSignUpResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthUser user,  bool verificationRequired,  String? verificationToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSignUpResult() when $default != null:
return $default(_that.user,_that.verificationRequired,_that.verificationToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthUser user,  bool verificationRequired,  String? verificationToken)  $default,) {final _that = this;
switch (_that) {
case _AuthSignUpResult():
return $default(_that.user,_that.verificationRequired,_that.verificationToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthUser user,  bool verificationRequired,  String? verificationToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthSignUpResult() when $default != null:
return $default(_that.user,_that.verificationRequired,_that.verificationToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSignUpResult implements AuthSignUpResult {
  const _AuthSignUpResult({required this.user, required this.verificationRequired, this.verificationToken});
  factory _AuthSignUpResult.fromJson(Map<String, dynamic> json) => _$AuthSignUpResultFromJson(json);

@override final  AuthUser user;
@override final  bool verificationRequired;
@override final  String? verificationToken;

/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSignUpResultCopyWith<_AuthSignUpResult> get copyWith => __$AuthSignUpResultCopyWithImpl<_AuthSignUpResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSignUpResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSignUpResult&&(identical(other.user, user) || other.user == user)&&(identical(other.verificationRequired, verificationRequired) || other.verificationRequired == verificationRequired)&&(identical(other.verificationToken, verificationToken) || other.verificationToken == verificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,verificationRequired,verificationToken);

@override
String toString() {
  return 'AuthSignUpResult(user: $user, verificationRequired: $verificationRequired, verificationToken: $verificationToken)';
}


}

/// @nodoc
abstract mixin class _$AuthSignUpResultCopyWith<$Res> implements $AuthSignUpResultCopyWith<$Res> {
  factory _$AuthSignUpResultCopyWith(_AuthSignUpResult value, $Res Function(_AuthSignUpResult) _then) = __$AuthSignUpResultCopyWithImpl;
@override @useResult
$Res call({
 AuthUser user, bool verificationRequired, String? verificationToken
});


@override $AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthSignUpResultCopyWithImpl<$Res>
    implements _$AuthSignUpResultCopyWith<$Res> {
  __$AuthSignUpResultCopyWithImpl(this._self, this._then);

  final _AuthSignUpResult _self;
  final $Res Function(_AuthSignUpResult) _then;

/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? verificationRequired = null,Object? verificationToken = freezed,}) {
  return _then(_AuthSignUpResult(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,verificationRequired: null == verificationRequired ? _self.verificationRequired : verificationRequired // ignore: cast_nullable_to_non_nullable
as bool,verificationToken: freezed == verificationToken ? _self.verificationToken : verificationToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthSignUpResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
