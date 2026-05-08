// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtitleLine {

@JsonKey(name: 'cueIndex') int get index; int get startMs; int get endMs; String get originalText; String? get translatedText;
/// Create a copy of SubtitleLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleLineCopyWith<SubtitleLine> get copyWith => _$SubtitleLineCopyWithImpl<SubtitleLine>(this as SubtitleLine, _$identity);

  /// Serializes this SubtitleLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleLine&&(identical(other.index, index) || other.index == index)&&(identical(other.startMs, startMs) || other.startMs == startMs)&&(identical(other.endMs, endMs) || other.endMs == endMs)&&(identical(other.originalText, originalText) || other.originalText == originalText)&&(identical(other.translatedText, translatedText) || other.translatedText == translatedText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,startMs,endMs,originalText,translatedText);

@override
String toString() {
  return 'SubtitleLine(index: $index, startMs: $startMs, endMs: $endMs, originalText: $originalText, translatedText: $translatedText)';
}


}

/// @nodoc
abstract mixin class $SubtitleLineCopyWith<$Res>  {
  factory $SubtitleLineCopyWith(SubtitleLine value, $Res Function(SubtitleLine) _then) = _$SubtitleLineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cueIndex') int index, int startMs, int endMs, String originalText, String? translatedText
});




}
/// @nodoc
class _$SubtitleLineCopyWithImpl<$Res>
    implements $SubtitleLineCopyWith<$Res> {
  _$SubtitleLineCopyWithImpl(this._self, this._then);

  final SubtitleLine _self;
  final $Res Function(SubtitleLine) _then;

/// Create a copy of SubtitleLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? startMs = null,Object? endMs = null,Object? originalText = null,Object? translatedText = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,originalText: null == originalText ? _self.originalText : originalText // ignore: cast_nullable_to_non_nullable
as String,translatedText: freezed == translatedText ? _self.translatedText : translatedText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleLine].
extension SubtitleLinePatterns on SubtitleLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleLine value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleLine value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cueIndex')  int index,  int startMs,  int endMs,  String originalText,  String? translatedText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleLine() when $default != null:
return $default(_that.index,_that.startMs,_that.endMs,_that.originalText,_that.translatedText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cueIndex')  int index,  int startMs,  int endMs,  String originalText,  String? translatedText)  $default,) {final _that = this;
switch (_that) {
case _SubtitleLine():
return $default(_that.index,_that.startMs,_that.endMs,_that.originalText,_that.translatedText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cueIndex')  int index,  int startMs,  int endMs,  String originalText,  String? translatedText)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleLine() when $default != null:
return $default(_that.index,_that.startMs,_that.endMs,_that.originalText,_that.translatedText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleLine implements SubtitleLine {
  const _SubtitleLine({@JsonKey(name: 'cueIndex') required this.index, required this.startMs, required this.endMs, required this.originalText, this.translatedText});
  factory _SubtitleLine.fromJson(Map<String, dynamic> json) => _$SubtitleLineFromJson(json);

@override@JsonKey(name: 'cueIndex') final  int index;
@override final  int startMs;
@override final  int endMs;
@override final  String originalText;
@override final  String? translatedText;

/// Create a copy of SubtitleLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleLineCopyWith<_SubtitleLine> get copyWith => __$SubtitleLineCopyWithImpl<_SubtitleLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleLine&&(identical(other.index, index) || other.index == index)&&(identical(other.startMs, startMs) || other.startMs == startMs)&&(identical(other.endMs, endMs) || other.endMs == endMs)&&(identical(other.originalText, originalText) || other.originalText == originalText)&&(identical(other.translatedText, translatedText) || other.translatedText == translatedText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,startMs,endMs,originalText,translatedText);

@override
String toString() {
  return 'SubtitleLine(index: $index, startMs: $startMs, endMs: $endMs, originalText: $originalText, translatedText: $translatedText)';
}


}

/// @nodoc
abstract mixin class _$SubtitleLineCopyWith<$Res> implements $SubtitleLineCopyWith<$Res> {
  factory _$SubtitleLineCopyWith(_SubtitleLine value, $Res Function(_SubtitleLine) _then) = __$SubtitleLineCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cueIndex') int index, int startMs, int endMs, String originalText, String? translatedText
});




}
/// @nodoc
class __$SubtitleLineCopyWithImpl<$Res>
    implements _$SubtitleLineCopyWith<$Res> {
  __$SubtitleLineCopyWithImpl(this._self, this._then);

  final _SubtitleLine _self;
  final $Res Function(_SubtitleLine) _then;

/// Create a copy of SubtitleLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? startMs = null,Object? endMs = null,Object? originalText = null,Object? translatedText = freezed,}) {
  return _then(_SubtitleLine(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,originalText: null == originalText ? _self.originalText : originalText // ignore: cast_nullable_to_non_nullable
as String,translatedText: freezed == translatedText ? _self.translatedText : translatedText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
