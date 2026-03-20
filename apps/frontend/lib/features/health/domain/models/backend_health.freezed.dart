// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backend_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackendHealth {

 String get status; String get service; String? get environment; DateTime get timestamp;
/// Create a copy of BackendHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackendHealthCopyWith<BackendHealth> get copyWith => _$BackendHealthCopyWithImpl<BackendHealth>(this as BackendHealth, _$identity);

  /// Serializes this BackendHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackendHealth&&(identical(other.status, status) || other.status == status)&&(identical(other.service, service) || other.service == service)&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,service,environment,timestamp);

@override
String toString() {
  return 'BackendHealth(status: $status, service: $service, environment: $environment, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $BackendHealthCopyWith<$Res>  {
  factory $BackendHealthCopyWith(BackendHealth value, $Res Function(BackendHealth) _then) = _$BackendHealthCopyWithImpl;
@useResult
$Res call({
 String status, String service, String? environment, DateTime timestamp
});




}
/// @nodoc
class _$BackendHealthCopyWithImpl<$Res>
    implements $BackendHealthCopyWith<$Res> {
  _$BackendHealthCopyWithImpl(this._self, this._then);

  final BackendHealth _self;
  final $Res Function(BackendHealth) _then;

/// Create a copy of BackendHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? service = null,Object? environment = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BackendHealth].
extension BackendHealthPatterns on BackendHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackendHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackendHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackendHealth value)  $default,){
final _that = this;
switch (_that) {
case _BackendHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackendHealth value)?  $default,){
final _that = this;
switch (_that) {
case _BackendHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String service,  String? environment,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackendHealth() when $default != null:
return $default(_that.status,_that.service,_that.environment,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String service,  String? environment,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _BackendHealth():
return $default(_that.status,_that.service,_that.environment,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String service,  String? environment,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _BackendHealth() when $default != null:
return $default(_that.status,_that.service,_that.environment,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackendHealth implements BackendHealth {
  const _BackendHealth({required this.status, required this.service, this.environment, required this.timestamp});
  factory _BackendHealth.fromJson(Map<String, dynamic> json) => _$BackendHealthFromJson(json);

@override final  String status;
@override final  String service;
@override final  String? environment;
@override final  DateTime timestamp;

/// Create a copy of BackendHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackendHealthCopyWith<_BackendHealth> get copyWith => __$BackendHealthCopyWithImpl<_BackendHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackendHealthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackendHealth&&(identical(other.status, status) || other.status == status)&&(identical(other.service, service) || other.service == service)&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,service,environment,timestamp);

@override
String toString() {
  return 'BackendHealth(status: $status, service: $service, environment: $environment, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$BackendHealthCopyWith<$Res> implements $BackendHealthCopyWith<$Res> {
  factory _$BackendHealthCopyWith(_BackendHealth value, $Res Function(_BackendHealth) _then) = __$BackendHealthCopyWithImpl;
@override @useResult
$Res call({
 String status, String service, String? environment, DateTime timestamp
});




}
/// @nodoc
class __$BackendHealthCopyWithImpl<$Res>
    implements _$BackendHealthCopyWith<$Res> {
  __$BackendHealthCopyWithImpl(this._self, this._then);

  final _BackendHealth _self;
  final $Res Function(_BackendHealth) _then;

/// Create a copy of BackendHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? service = null,Object? environment = freezed,Object? timestamp = null,}) {
  return _then(_BackendHealth(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
