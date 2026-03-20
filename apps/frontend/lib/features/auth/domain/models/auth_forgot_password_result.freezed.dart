// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_forgot_password_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthForgotPasswordResult {

 bool get sent; String? get resetToken;
/// Create a copy of AuthForgotPasswordResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthForgotPasswordResultCopyWith<AuthForgotPasswordResult> get copyWith => _$AuthForgotPasswordResultCopyWithImpl<AuthForgotPasswordResult>(this as AuthForgotPasswordResult, _$identity);

  /// Serializes this AuthForgotPasswordResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthForgotPasswordResult&&(identical(other.sent, sent) || other.sent == sent)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sent,resetToken);

@override
String toString() {
  return 'AuthForgotPasswordResult(sent: $sent, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $AuthForgotPasswordResultCopyWith<$Res>  {
  factory $AuthForgotPasswordResultCopyWith(AuthForgotPasswordResult value, $Res Function(AuthForgotPasswordResult) _then) = _$AuthForgotPasswordResultCopyWithImpl;
@useResult
$Res call({
 bool sent, String? resetToken
});




}
/// @nodoc
class _$AuthForgotPasswordResultCopyWithImpl<$Res>
    implements $AuthForgotPasswordResultCopyWith<$Res> {
  _$AuthForgotPasswordResultCopyWithImpl(this._self, this._then);

  final AuthForgotPasswordResult _self;
  final $Res Function(AuthForgotPasswordResult) _then;

/// Create a copy of AuthForgotPasswordResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sent = null,Object? resetToken = freezed,}) {
  return _then(_self.copyWith(
sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthForgotPasswordResult].
extension AuthForgotPasswordResultPatterns on AuthForgotPasswordResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthForgotPasswordResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthForgotPasswordResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthForgotPasswordResult value)  $default,){
final _that = this;
switch (_that) {
case _AuthForgotPasswordResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthForgotPasswordResult value)?  $default,){
final _that = this;
switch (_that) {
case _AuthForgotPasswordResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool sent,  String? resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthForgotPasswordResult() when $default != null:
return $default(_that.sent,_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool sent,  String? resetToken)  $default,) {final _that = this;
switch (_that) {
case _AuthForgotPasswordResult():
return $default(_that.sent,_that.resetToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool sent,  String? resetToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthForgotPasswordResult() when $default != null:
return $default(_that.sent,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthForgotPasswordResult implements AuthForgotPasswordResult {
  const _AuthForgotPasswordResult({required this.sent, this.resetToken});
  factory _AuthForgotPasswordResult.fromJson(Map<String, dynamic> json) => _$AuthForgotPasswordResultFromJson(json);

@override final  bool sent;
@override final  String? resetToken;

/// Create a copy of AuthForgotPasswordResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthForgotPasswordResultCopyWith<_AuthForgotPasswordResult> get copyWith => __$AuthForgotPasswordResultCopyWithImpl<_AuthForgotPasswordResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthForgotPasswordResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthForgotPasswordResult&&(identical(other.sent, sent) || other.sent == sent)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sent,resetToken);

@override
String toString() {
  return 'AuthForgotPasswordResult(sent: $sent, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$AuthForgotPasswordResultCopyWith<$Res> implements $AuthForgotPasswordResultCopyWith<$Res> {
  factory _$AuthForgotPasswordResultCopyWith(_AuthForgotPasswordResult value, $Res Function(_AuthForgotPasswordResult) _then) = __$AuthForgotPasswordResultCopyWithImpl;
@override @useResult
$Res call({
 bool sent, String? resetToken
});




}
/// @nodoc
class __$AuthForgotPasswordResultCopyWithImpl<$Res>
    implements _$AuthForgotPasswordResultCopyWith<$Res> {
  __$AuthForgotPasswordResultCopyWithImpl(this._self, this._then);

  final _AuthForgotPasswordResult _self;
  final $Res Function(_AuthForgotPasswordResult) _then;

/// Create a copy of AuthForgotPasswordResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sent = null,Object? resetToken = freezed,}) {
  return _then(_AuthForgotPasswordResult(
sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
