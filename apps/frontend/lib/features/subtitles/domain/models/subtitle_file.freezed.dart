// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtitleFile {

 String get id; String get name; SubtitleFormat get format; AppLanguage get sourceLanguage; List<SubtitleLine> get lines; String? get originalPath;
/// Create a copy of SubtitleFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleFileCopyWith<SubtitleFile> get copyWith => _$SubtitleFileCopyWithImpl<SubtitleFile>(this as SubtitleFile, _$identity);

  /// Serializes this SubtitleFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleFile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.originalPath, originalPath) || other.originalPath == originalPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,format,sourceLanguage,const DeepCollectionEquality().hash(lines),originalPath);

@override
String toString() {
  return 'SubtitleFile(id: $id, name: $name, format: $format, sourceLanguage: $sourceLanguage, lines: $lines, originalPath: $originalPath)';
}


}

/// @nodoc
abstract mixin class $SubtitleFileCopyWith<$Res>  {
  factory $SubtitleFileCopyWith(SubtitleFile value, $Res Function(SubtitleFile) _then) = _$SubtitleFileCopyWithImpl;
@useResult
$Res call({
 String id, String name, SubtitleFormat format, AppLanguage sourceLanguage, List<SubtitleLine> lines, String? originalPath
});




}
/// @nodoc
class _$SubtitleFileCopyWithImpl<$Res>
    implements $SubtitleFileCopyWith<$Res> {
  _$SubtitleFileCopyWithImpl(this._self, this._then);

  final SubtitleFile _self;
  final $Res Function(SubtitleFile) _then;

/// Create a copy of SubtitleFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? format = null,Object? sourceLanguage = null,Object? lines = null,Object? originalPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,originalPath: freezed == originalPath ? _self.originalPath : originalPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleFile].
extension SubtitleFilePatterns on SubtitleFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleFile value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleFile value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SubtitleFormat format,  AppLanguage sourceLanguage,  List<SubtitleLine> lines,  String? originalPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleFile() when $default != null:
return $default(_that.id,_that.name,_that.format,_that.sourceLanguage,_that.lines,_that.originalPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SubtitleFormat format,  AppLanguage sourceLanguage,  List<SubtitleLine> lines,  String? originalPath)  $default,) {final _that = this;
switch (_that) {
case _SubtitleFile():
return $default(_that.id,_that.name,_that.format,_that.sourceLanguage,_that.lines,_that.originalPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SubtitleFormat format,  AppLanguage sourceLanguage,  List<SubtitleLine> lines,  String? originalPath)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleFile() when $default != null:
return $default(_that.id,_that.name,_that.format,_that.sourceLanguage,_that.lines,_that.originalPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleFile implements SubtitleFile {
  const _SubtitleFile({required this.id, required this.name, required this.format, required this.sourceLanguage, required final  List<SubtitleLine> lines, this.originalPath}): _lines = lines;
  factory _SubtitleFile.fromJson(Map<String, dynamic> json) => _$SubtitleFileFromJson(json);

@override final  String id;
@override final  String name;
@override final  SubtitleFormat format;
@override final  AppLanguage sourceLanguage;
 final  List<SubtitleLine> _lines;
@override List<SubtitleLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  String? originalPath;

/// Create a copy of SubtitleFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleFileCopyWith<_SubtitleFile> get copyWith => __$SubtitleFileCopyWithImpl<_SubtitleFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleFile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.originalPath, originalPath) || other.originalPath == originalPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,format,sourceLanguage,const DeepCollectionEquality().hash(_lines),originalPath);

@override
String toString() {
  return 'SubtitleFile(id: $id, name: $name, format: $format, sourceLanguage: $sourceLanguage, lines: $lines, originalPath: $originalPath)';
}


}

/// @nodoc
abstract mixin class _$SubtitleFileCopyWith<$Res> implements $SubtitleFileCopyWith<$Res> {
  factory _$SubtitleFileCopyWith(_SubtitleFile value, $Res Function(_SubtitleFile) _then) = __$SubtitleFileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SubtitleFormat format, AppLanguage sourceLanguage, List<SubtitleLine> lines, String? originalPath
});




}
/// @nodoc
class __$SubtitleFileCopyWithImpl<$Res>
    implements _$SubtitleFileCopyWith<$Res> {
  __$SubtitleFileCopyWithImpl(this._self, this._then);

  final _SubtitleFile _self;
  final $Res Function(_SubtitleFile) _then;

/// Create a copy of SubtitleFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? format = null,Object? sourceLanguage = null,Object? lines = null,Object? originalPath = freezed,}) {
  return _then(_SubtitleFile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,originalPath: freezed == originalPath ? _self.originalPath : originalPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
