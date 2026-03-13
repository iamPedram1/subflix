// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_progress_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranslationProgressUpdate {

 double get progress; String get stageLabel; TranslationJob? get job;
/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationProgressUpdateCopyWith<TranslationProgressUpdate> get copyWith => _$TranslationProgressUpdateCopyWithImpl<TranslationProgressUpdate>(this as TranslationProgressUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationProgressUpdate&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.job, job) || other.job == job));
}


@override
int get hashCode => Object.hash(runtimeType,progress,stageLabel,job);

@override
String toString() {
  return 'TranslationProgressUpdate(progress: $progress, stageLabel: $stageLabel, job: $job)';
}


}

/// @nodoc
abstract mixin class $TranslationProgressUpdateCopyWith<$Res>  {
  factory $TranslationProgressUpdateCopyWith(TranslationProgressUpdate value, $Res Function(TranslationProgressUpdate) _then) = _$TranslationProgressUpdateCopyWithImpl;
@useResult
$Res call({
 double progress, String stageLabel, TranslationJob? job
});


$TranslationJobCopyWith<$Res>? get job;

}
/// @nodoc
class _$TranslationProgressUpdateCopyWithImpl<$Res>
    implements $TranslationProgressUpdateCopyWith<$Res> {
  _$TranslationProgressUpdateCopyWithImpl(this._self, this._then);

  final TranslationProgressUpdate _self;
  final $Res Function(TranslationProgressUpdate) _then;

/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? stageLabel = null,Object? job = freezed,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as TranslationJob?,
  ));
}
/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $TranslationJobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranslationProgressUpdate].
extension TranslationProgressUpdatePatterns on TranslationProgressUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationProgressUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationProgressUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationProgressUpdate value)  $default,){
final _that = this;
switch (_that) {
case _TranslationProgressUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationProgressUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationProgressUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double progress,  String stageLabel,  TranslationJob? job)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationProgressUpdate() when $default != null:
return $default(_that.progress,_that.stageLabel,_that.job);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double progress,  String stageLabel,  TranslationJob? job)  $default,) {final _that = this;
switch (_that) {
case _TranslationProgressUpdate():
return $default(_that.progress,_that.stageLabel,_that.job);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double progress,  String stageLabel,  TranslationJob? job)?  $default,) {final _that = this;
switch (_that) {
case _TranslationProgressUpdate() when $default != null:
return $default(_that.progress,_that.stageLabel,_that.job);case _:
  return null;

}
}

}

/// @nodoc


class _TranslationProgressUpdate implements TranslationProgressUpdate {
  const _TranslationProgressUpdate({required this.progress, required this.stageLabel, this.job});
  

@override final  double progress;
@override final  String stageLabel;
@override final  TranslationJob? job;

/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationProgressUpdateCopyWith<_TranslationProgressUpdate> get copyWith => __$TranslationProgressUpdateCopyWithImpl<_TranslationProgressUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationProgressUpdate&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.job, job) || other.job == job));
}


@override
int get hashCode => Object.hash(runtimeType,progress,stageLabel,job);

@override
String toString() {
  return 'TranslationProgressUpdate(progress: $progress, stageLabel: $stageLabel, job: $job)';
}


}

/// @nodoc
abstract mixin class _$TranslationProgressUpdateCopyWith<$Res> implements $TranslationProgressUpdateCopyWith<$Res> {
  factory _$TranslationProgressUpdateCopyWith(_TranslationProgressUpdate value, $Res Function(_TranslationProgressUpdate) _then) = __$TranslationProgressUpdateCopyWithImpl;
@override @useResult
$Res call({
 double progress, String stageLabel, TranslationJob? job
});


@override $TranslationJobCopyWith<$Res>? get job;

}
/// @nodoc
class __$TranslationProgressUpdateCopyWithImpl<$Res>
    implements _$TranslationProgressUpdateCopyWith<$Res> {
  __$TranslationProgressUpdateCopyWithImpl(this._self, this._then);

  final _TranslationProgressUpdate _self;
  final $Res Function(_TranslationProgressUpdate) _then;

/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? stageLabel = null,Object? job = freezed,}) {
  return _then(_TranslationProgressUpdate(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as TranslationJob?,
  ));
}

/// Create a copy of TranslationProgressUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $TranslationJobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
