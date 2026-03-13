// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtitleSource {

 String get id; String get label; String get releaseGroup; SubtitleFormat get format; bool get hearingImpaired; int get lineCount; int get downloads; double get rating;
/// Create a copy of SubtitleSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleSourceCopyWith<SubtitleSource> get copyWith => _$SubtitleSourceCopyWithImpl<SubtitleSource>(this as SubtitleSource, _$identity);

  /// Serializes this SubtitleSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleSource&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.releaseGroup, releaseGroup) || other.releaseGroup == releaseGroup)&&(identical(other.format, format) || other.format == format)&&(identical(other.hearingImpaired, hearingImpaired) || other.hearingImpaired == hearingImpaired)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.downloads, downloads) || other.downloads == downloads)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,releaseGroup,format,hearingImpaired,lineCount,downloads,rating);

@override
String toString() {
  return 'SubtitleSource(id: $id, label: $label, releaseGroup: $releaseGroup, format: $format, hearingImpaired: $hearingImpaired, lineCount: $lineCount, downloads: $downloads, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $SubtitleSourceCopyWith<$Res>  {
  factory $SubtitleSourceCopyWith(SubtitleSource value, $Res Function(SubtitleSource) _then) = _$SubtitleSourceCopyWithImpl;
@useResult
$Res call({
 String id, String label, String releaseGroup, SubtitleFormat format, bool hearingImpaired, int lineCount, int downloads, double rating
});




}
/// @nodoc
class _$SubtitleSourceCopyWithImpl<$Res>
    implements $SubtitleSourceCopyWith<$Res> {
  _$SubtitleSourceCopyWithImpl(this._self, this._then);

  final SubtitleSource _self;
  final $Res Function(SubtitleSource) _then;

/// Create a copy of SubtitleSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? releaseGroup = null,Object? format = null,Object? hearingImpaired = null,Object? lineCount = null,Object? downloads = null,Object? rating = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,releaseGroup: null == releaseGroup ? _self.releaseGroup : releaseGroup // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,hearingImpaired: null == hearingImpaired ? _self.hearingImpaired : hearingImpaired // ignore: cast_nullable_to_non_nullable
as bool,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleSource].
extension SubtitleSourcePatterns on SubtitleSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleSource value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleSource value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String releaseGroup,  SubtitleFormat format,  bool hearingImpaired,  int lineCount,  int downloads,  double rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleSource() when $default != null:
return $default(_that.id,_that.label,_that.releaseGroup,_that.format,_that.hearingImpaired,_that.lineCount,_that.downloads,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String releaseGroup,  SubtitleFormat format,  bool hearingImpaired,  int lineCount,  int downloads,  double rating)  $default,) {final _that = this;
switch (_that) {
case _SubtitleSource():
return $default(_that.id,_that.label,_that.releaseGroup,_that.format,_that.hearingImpaired,_that.lineCount,_that.downloads,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String releaseGroup,  SubtitleFormat format,  bool hearingImpaired,  int lineCount,  int downloads,  double rating)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleSource() when $default != null:
return $default(_that.id,_that.label,_that.releaseGroup,_that.format,_that.hearingImpaired,_that.lineCount,_that.downloads,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleSource implements SubtitleSource {
  const _SubtitleSource({required this.id, required this.label, required this.releaseGroup, required this.format, required this.hearingImpaired, required this.lineCount, required this.downloads, required this.rating});
  factory _SubtitleSource.fromJson(Map<String, dynamic> json) => _$SubtitleSourceFromJson(json);

@override final  String id;
@override final  String label;
@override final  String releaseGroup;
@override final  SubtitleFormat format;
@override final  bool hearingImpaired;
@override final  int lineCount;
@override final  int downloads;
@override final  double rating;

/// Create a copy of SubtitleSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleSourceCopyWith<_SubtitleSource> get copyWith => __$SubtitleSourceCopyWithImpl<_SubtitleSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleSource&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.releaseGroup, releaseGroup) || other.releaseGroup == releaseGroup)&&(identical(other.format, format) || other.format == format)&&(identical(other.hearingImpaired, hearingImpaired) || other.hearingImpaired == hearingImpaired)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.downloads, downloads) || other.downloads == downloads)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,releaseGroup,format,hearingImpaired,lineCount,downloads,rating);

@override
String toString() {
  return 'SubtitleSource(id: $id, label: $label, releaseGroup: $releaseGroup, format: $format, hearingImpaired: $hearingImpaired, lineCount: $lineCount, downloads: $downloads, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$SubtitleSourceCopyWith<$Res> implements $SubtitleSourceCopyWith<$Res> {
  factory _$SubtitleSourceCopyWith(_SubtitleSource value, $Res Function(_SubtitleSource) _then) = __$SubtitleSourceCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String releaseGroup, SubtitleFormat format, bool hearingImpaired, int lineCount, int downloads, double rating
});




}
/// @nodoc
class __$SubtitleSourceCopyWithImpl<$Res>
    implements _$SubtitleSourceCopyWith<$Res> {
  __$SubtitleSourceCopyWithImpl(this._self, this._then);

  final _SubtitleSource _self;
  final $Res Function(_SubtitleSource) _then;

/// Create a copy of SubtitleSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? releaseGroup = null,Object? format = null,Object? hearingImpaired = null,Object? lineCount = null,Object? downloads = null,Object? rating = null,}) {
  return _then(_SubtitleSource(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,releaseGroup: null == releaseGroup ? _self.releaseGroup : releaseGroup // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,hearingImpaired: null == hearingImpaired ? _self.hearingImpaired : hearingImpaired // ignore: cast_nullable_to_non_nullable
as bool,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
