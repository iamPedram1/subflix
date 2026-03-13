// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationJob {

 String get id; String get title; String get sourceName; TranslationSourceType get sourceType; TranslationJobStatus get status; AppLanguage get sourceLanguage; AppLanguage get targetLanguage; DateTime get createdAt; DateTime get updatedAt; SubtitleFormat get format; List<SubtitleLine> get lines; double get progress; String? get errorMessage;
/// Create a copy of TranslationJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<TranslationJob> get copyWith => _$TranslationJobCopyWithImpl<TranslationJob>(this as TranslationJob, _$identity);

  /// Serializes this TranslationJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.format, format) || other.format == format)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,sourceName,sourceType,status,sourceLanguage,targetLanguage,createdAt,updatedAt,format,const DeepCollectionEquality().hash(lines),progress,errorMessage);

@override
String toString() {
  return 'TranslationJob(id: $id, title: $title, sourceName: $sourceName, sourceType: $sourceType, status: $status, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, createdAt: $createdAt, updatedAt: $updatedAt, format: $format, lines: $lines, progress: $progress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TranslationJobCopyWith<$Res>  {
  factory $TranslationJobCopyWith(TranslationJob value, $Res Function(TranslationJob) _then) = _$TranslationJobCopyWithImpl;
@useResult
$Res call({
 String id, String title, String sourceName, TranslationSourceType sourceType, TranslationJobStatus status, AppLanguage sourceLanguage, AppLanguage targetLanguage, DateTime createdAt, DateTime updatedAt, SubtitleFormat format, List<SubtitleLine> lines, double progress, String? errorMessage
});




}
/// @nodoc
class _$TranslationJobCopyWithImpl<$Res>
    implements $TranslationJobCopyWith<$Res> {
  _$TranslationJobCopyWithImpl(this._self, this._then);

  final TranslationJob _self;
  final $Res Function(TranslationJob) _then;

/// Create a copy of TranslationJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? sourceName = null,Object? sourceType = null,Object? status = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? createdAt = null,Object? updatedAt = null,Object? format = null,Object? lines = null,Object? progress = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as TranslationSourceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranslationJobStatus,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationJob].
extension TranslationJobPatterns on TranslationJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationJob value)  $default,){
final _that = this;
switch (_that) {
case _TranslationJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationJob value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  List<SubtitleLine> lines,  double progress,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lines,_that.progress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  List<SubtitleLine> lines,  double progress,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TranslationJob():
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lines,_that.progress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  List<SubtitleLine> lines,  double progress,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lines,_that.progress,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationJob implements TranslationJob {
  const _TranslationJob({required this.id, required this.title, required this.sourceName, required this.sourceType, required this.status, required this.sourceLanguage, required this.targetLanguage, required this.createdAt, required this.updatedAt, required this.format, required final  List<SubtitleLine> lines, required this.progress, this.errorMessage}): _lines = lines;
  factory _TranslationJob.fromJson(Map<String, dynamic> json) => _$TranslationJobFromJson(json);

@override final  String id;
@override final  String title;
@override final  String sourceName;
@override final  TranslationSourceType sourceType;
@override final  TranslationJobStatus status;
@override final  AppLanguage sourceLanguage;
@override final  AppLanguage targetLanguage;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SubtitleFormat format;
 final  List<SubtitleLine> _lines;
@override List<SubtitleLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  double progress;
@override final  String? errorMessage;

/// Create a copy of TranslationJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationJobCopyWith<_TranslationJob> get copyWith => __$TranslationJobCopyWithImpl<_TranslationJob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationJobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.format, format) || other.format == format)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,sourceName,sourceType,status,sourceLanguage,targetLanguage,createdAt,updatedAt,format,const DeepCollectionEquality().hash(_lines),progress,errorMessage);

@override
String toString() {
  return 'TranslationJob(id: $id, title: $title, sourceName: $sourceName, sourceType: $sourceType, status: $status, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, createdAt: $createdAt, updatedAt: $updatedAt, format: $format, lines: $lines, progress: $progress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TranslationJobCopyWith<$Res> implements $TranslationJobCopyWith<$Res> {
  factory _$TranslationJobCopyWith(_TranslationJob value, $Res Function(_TranslationJob) _then) = __$TranslationJobCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String sourceName, TranslationSourceType sourceType, TranslationJobStatus status, AppLanguage sourceLanguage, AppLanguage targetLanguage, DateTime createdAt, DateTime updatedAt, SubtitleFormat format, List<SubtitleLine> lines, double progress, String? errorMessage
});




}
/// @nodoc
class __$TranslationJobCopyWithImpl<$Res>
    implements _$TranslationJobCopyWith<$Res> {
  __$TranslationJobCopyWithImpl(this._self, this._then);

  final _TranslationJob _self;
  final $Res Function(_TranslationJob) _then;

/// Create a copy of TranslationJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? sourceName = null,Object? sourceType = null,Object? status = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? createdAt = null,Object? updatedAt = null,Object? format = null,Object? lines = null,Object? progress = null,Object? errorMessage = freezed,}) {
  return _then(_TranslationJob(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as TranslationSourceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranslationJobStatus,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
