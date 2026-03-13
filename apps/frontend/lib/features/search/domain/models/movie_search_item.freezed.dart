// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MovieSearchItem {

 String get id; String get title; int get year; SearchMediaType get mediaType; String get synopsis; List<String> get genres; int get runtimeMinutes; double get popularity;
/// Create a copy of MovieSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieSearchItemCopyWith<MovieSearchItem> get copyWith => _$MovieSearchItemCopyWithImpl<MovieSearchItem>(this as MovieSearchItem, _$identity);

  /// Serializes this MovieSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.runtimeMinutes, runtimeMinutes) || other.runtimeMinutes == runtimeMinutes)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,mediaType,synopsis,const DeepCollectionEquality().hash(genres),runtimeMinutes,popularity);

@override
String toString() {
  return 'MovieSearchItem(id: $id, title: $title, year: $year, mediaType: $mediaType, synopsis: $synopsis, genres: $genres, runtimeMinutes: $runtimeMinutes, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class $MovieSearchItemCopyWith<$Res>  {
  factory $MovieSearchItemCopyWith(MovieSearchItem value, $Res Function(MovieSearchItem) _then) = _$MovieSearchItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, int year, SearchMediaType mediaType, String synopsis, List<String> genres, int runtimeMinutes, double popularity
});




}
/// @nodoc
class _$MovieSearchItemCopyWithImpl<$Res>
    implements $MovieSearchItemCopyWith<$Res> {
  _$MovieSearchItemCopyWithImpl(this._self, this._then);

  final MovieSearchItem _self;
  final $Res Function(MovieSearchItem) _then;

/// Create a copy of MovieSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? year = null,Object? mediaType = null,Object? synopsis = null,Object? genres = null,Object? runtimeMinutes = null,Object? popularity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as SearchMediaType,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,runtimeMinutes: null == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieSearchItem].
extension MovieSearchItemPatterns on MovieSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _MovieSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _MovieSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int year,  SearchMediaType mediaType,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieSearchItem() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int year,  SearchMediaType mediaType,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity)  $default,) {final _that = this;
switch (_that) {
case _MovieSearchItem():
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int year,  SearchMediaType mediaType,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity)?  $default,) {final _that = this;
switch (_that) {
case _MovieSearchItem() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovieSearchItem implements MovieSearchItem {
  const _MovieSearchItem({required this.id, required this.title, required this.year, required this.mediaType, required this.synopsis, required final  List<String> genres, required this.runtimeMinutes, required this.popularity}): _genres = genres;
  factory _MovieSearchItem.fromJson(Map<String, dynamic> json) => _$MovieSearchItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  int year;
@override final  SearchMediaType mediaType;
@override final  String synopsis;
 final  List<String> _genres;
@override List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override final  int runtimeMinutes;
@override final  double popularity;

/// Create a copy of MovieSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieSearchItemCopyWith<_MovieSearchItem> get copyWith => __$MovieSearchItemCopyWithImpl<_MovieSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovieSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieSearchItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.runtimeMinutes, runtimeMinutes) || other.runtimeMinutes == runtimeMinutes)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,mediaType,synopsis,const DeepCollectionEquality().hash(_genres),runtimeMinutes,popularity);

@override
String toString() {
  return 'MovieSearchItem(id: $id, title: $title, year: $year, mediaType: $mediaType, synopsis: $synopsis, genres: $genres, runtimeMinutes: $runtimeMinutes, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class _$MovieSearchItemCopyWith<$Res> implements $MovieSearchItemCopyWith<$Res> {
  factory _$MovieSearchItemCopyWith(_MovieSearchItem value, $Res Function(_MovieSearchItem) _then) = __$MovieSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int year, SearchMediaType mediaType, String synopsis, List<String> genres, int runtimeMinutes, double popularity
});




}
/// @nodoc
class __$MovieSearchItemCopyWithImpl<$Res>
    implements _$MovieSearchItemCopyWith<$Res> {
  __$MovieSearchItemCopyWithImpl(this._self, this._then);

  final _MovieSearchItem _self;
  final $Res Function(_MovieSearchItem) _then;

/// Create a copy of MovieSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? year = null,Object? mediaType = null,Object? synopsis = null,Object? genres = null,Object? runtimeMinutes = null,Object? popularity = null,}) {
  return _then(_MovieSearchItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as SearchMediaType,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,runtimeMinutes: null == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
