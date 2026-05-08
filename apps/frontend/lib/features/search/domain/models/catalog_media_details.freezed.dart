// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_media_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogSeasonDetails {

 int get seasonNumber; String get name; int get episodeCount; String? get airDate; String? get overview; String? get posterUrl;
/// Create a copy of CatalogSeasonDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogSeasonDetailsCopyWith<CatalogSeasonDetails> get copyWith => _$CatalogSeasonDetailsCopyWithImpl<CatalogSeasonDetails>(this as CatalogSeasonDetails, _$identity);

  /// Serializes this CatalogSeasonDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogSeasonDetails&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.airDate, airDate) || other.airDate == airDate)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonNumber,name,episodeCount,airDate,overview,posterUrl);

@override
String toString() {
  return 'CatalogSeasonDetails(seasonNumber: $seasonNumber, name: $name, episodeCount: $episodeCount, airDate: $airDate, overview: $overview, posterUrl: $posterUrl)';
}


}

/// @nodoc
abstract mixin class $CatalogSeasonDetailsCopyWith<$Res>  {
  factory $CatalogSeasonDetailsCopyWith(CatalogSeasonDetails value, $Res Function(CatalogSeasonDetails) _then) = _$CatalogSeasonDetailsCopyWithImpl;
@useResult
$Res call({
 int seasonNumber, String name, int episodeCount, String? airDate, String? overview, String? posterUrl
});




}
/// @nodoc
class _$CatalogSeasonDetailsCopyWithImpl<$Res>
    implements $CatalogSeasonDetailsCopyWith<$Res> {
  _$CatalogSeasonDetailsCopyWithImpl(this._self, this._then);

  final CatalogSeasonDetails _self;
  final $Res Function(CatalogSeasonDetails) _then;

/// Create a copy of CatalogSeasonDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonNumber = null,Object? name = null,Object? episodeCount = null,Object? airDate = freezed,Object? overview = freezed,Object? posterUrl = freezed,}) {
  return _then(_self.copyWith(
seasonNumber: null == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,episodeCount: null == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int,airDate: freezed == airDate ? _self.airDate : airDate // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,posterUrl: freezed == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogSeasonDetails].
extension CatalogSeasonDetailsPatterns on CatalogSeasonDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogSeasonDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogSeasonDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogSeasonDetails value)  $default,){
final _that = this;
switch (_that) {
case _CatalogSeasonDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogSeasonDetails value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogSeasonDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seasonNumber,  String name,  int episodeCount,  String? airDate,  String? overview,  String? posterUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogSeasonDetails() when $default != null:
return $default(_that.seasonNumber,_that.name,_that.episodeCount,_that.airDate,_that.overview,_that.posterUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seasonNumber,  String name,  int episodeCount,  String? airDate,  String? overview,  String? posterUrl)  $default,) {final _that = this;
switch (_that) {
case _CatalogSeasonDetails():
return $default(_that.seasonNumber,_that.name,_that.episodeCount,_that.airDate,_that.overview,_that.posterUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seasonNumber,  String name,  int episodeCount,  String? airDate,  String? overview,  String? posterUrl)?  $default,) {final _that = this;
switch (_that) {
case _CatalogSeasonDetails() when $default != null:
return $default(_that.seasonNumber,_that.name,_that.episodeCount,_that.airDate,_that.overview,_that.posterUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogSeasonDetails implements CatalogSeasonDetails {
  const _CatalogSeasonDetails({required this.seasonNumber, required this.name, required this.episodeCount, this.airDate, this.overview, this.posterUrl});
  factory _CatalogSeasonDetails.fromJson(Map<String, dynamic> json) => _$CatalogSeasonDetailsFromJson(json);

@override final  int seasonNumber;
@override final  String name;
@override final  int episodeCount;
@override final  String? airDate;
@override final  String? overview;
@override final  String? posterUrl;

/// Create a copy of CatalogSeasonDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogSeasonDetailsCopyWith<_CatalogSeasonDetails> get copyWith => __$CatalogSeasonDetailsCopyWithImpl<_CatalogSeasonDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogSeasonDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogSeasonDetails&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.airDate, airDate) || other.airDate == airDate)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonNumber,name,episodeCount,airDate,overview,posterUrl);

@override
String toString() {
  return 'CatalogSeasonDetails(seasonNumber: $seasonNumber, name: $name, episodeCount: $episodeCount, airDate: $airDate, overview: $overview, posterUrl: $posterUrl)';
}


}

/// @nodoc
abstract mixin class _$CatalogSeasonDetailsCopyWith<$Res> implements $CatalogSeasonDetailsCopyWith<$Res> {
  factory _$CatalogSeasonDetailsCopyWith(_CatalogSeasonDetails value, $Res Function(_CatalogSeasonDetails) _then) = __$CatalogSeasonDetailsCopyWithImpl;
@override @useResult
$Res call({
 int seasonNumber, String name, int episodeCount, String? airDate, String? overview, String? posterUrl
});




}
/// @nodoc
class __$CatalogSeasonDetailsCopyWithImpl<$Res>
    implements _$CatalogSeasonDetailsCopyWith<$Res> {
  __$CatalogSeasonDetailsCopyWithImpl(this._self, this._then);

  final _CatalogSeasonDetails _self;
  final $Res Function(_CatalogSeasonDetails) _then;

/// Create a copy of CatalogSeasonDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonNumber = null,Object? name = null,Object? episodeCount = null,Object? airDate = freezed,Object? overview = freezed,Object? posterUrl = freezed,}) {
  return _then(_CatalogSeasonDetails(
seasonNumber: null == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,episodeCount: null == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int,airDate: freezed == airDate ? _self.airDate : airDate // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,posterUrl: freezed == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CatalogMediaDetails {

 String get id; String get title; int get year; SearchMediaType get mediaType; String? get posterUrl; String get synopsis; List<String> get genres; int get runtimeMinutes; double get popularity; int? get tmdbId; String? get imdbId; String? get originalTitle; CatalogProviderMediaType get providerMediaType; int? get seasonsCount; int? get episodesCount; List<CatalogSeasonDetails>? get seasons;
/// Create a copy of CatalogMediaDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogMediaDetailsCopyWith<CatalogMediaDetails> get copyWith => _$CatalogMediaDetailsCopyWithImpl<CatalogMediaDetails>(this as CatalogMediaDetails, _$identity);

  /// Serializes this CatalogMediaDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogMediaDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.runtimeMinutes, runtimeMinutes) || other.runtimeMinutes == runtimeMinutes)&&(identical(other.popularity, popularity) || other.popularity == popularity)&&(identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId)&&(identical(other.imdbId, imdbId) || other.imdbId == imdbId)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.providerMediaType, providerMediaType) || other.providerMediaType == providerMediaType)&&(identical(other.seasonsCount, seasonsCount) || other.seasonsCount == seasonsCount)&&(identical(other.episodesCount, episodesCount) || other.episodesCount == episodesCount)&&const DeepCollectionEquality().equals(other.seasons, seasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,mediaType,posterUrl,synopsis,const DeepCollectionEquality().hash(genres),runtimeMinutes,popularity,tmdbId,imdbId,originalTitle,providerMediaType,seasonsCount,episodesCount,const DeepCollectionEquality().hash(seasons));

@override
String toString() {
  return 'CatalogMediaDetails(id: $id, title: $title, year: $year, mediaType: $mediaType, posterUrl: $posterUrl, synopsis: $synopsis, genres: $genres, runtimeMinutes: $runtimeMinutes, popularity: $popularity, tmdbId: $tmdbId, imdbId: $imdbId, originalTitle: $originalTitle, providerMediaType: $providerMediaType, seasonsCount: $seasonsCount, episodesCount: $episodesCount, seasons: $seasons)';
}


}

/// @nodoc
abstract mixin class $CatalogMediaDetailsCopyWith<$Res>  {
  factory $CatalogMediaDetailsCopyWith(CatalogMediaDetails value, $Res Function(CatalogMediaDetails) _then) = _$CatalogMediaDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String title, int year, SearchMediaType mediaType, String? posterUrl, String synopsis, List<String> genres, int runtimeMinutes, double popularity, int? tmdbId, String? imdbId, String? originalTitle, CatalogProviderMediaType providerMediaType, int? seasonsCount, int? episodesCount, List<CatalogSeasonDetails>? seasons
});




}
/// @nodoc
class _$CatalogMediaDetailsCopyWithImpl<$Res>
    implements $CatalogMediaDetailsCopyWith<$Res> {
  _$CatalogMediaDetailsCopyWithImpl(this._self, this._then);

  final CatalogMediaDetails _self;
  final $Res Function(CatalogMediaDetails) _then;

/// Create a copy of CatalogMediaDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? year = null,Object? mediaType = null,Object? posterUrl = freezed,Object? synopsis = null,Object? genres = null,Object? runtimeMinutes = null,Object? popularity = null,Object? tmdbId = freezed,Object? imdbId = freezed,Object? originalTitle = freezed,Object? providerMediaType = null,Object? seasonsCount = freezed,Object? episodesCount = freezed,Object? seasons = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as SearchMediaType,posterUrl: freezed == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String?,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,runtimeMinutes: null == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as double,tmdbId: freezed == tmdbId ? _self.tmdbId : tmdbId // ignore: cast_nullable_to_non_nullable
as int?,imdbId: freezed == imdbId ? _self.imdbId : imdbId // ignore: cast_nullable_to_non_nullable
as String?,originalTitle: freezed == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String?,providerMediaType: null == providerMediaType ? _self.providerMediaType : providerMediaType // ignore: cast_nullable_to_non_nullable
as CatalogProviderMediaType,seasonsCount: freezed == seasonsCount ? _self.seasonsCount : seasonsCount // ignore: cast_nullable_to_non_nullable
as int?,episodesCount: freezed == episodesCount ? _self.episodesCount : episodesCount // ignore: cast_nullable_to_non_nullable
as int?,seasons: freezed == seasons ? _self.seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<CatalogSeasonDetails>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogMediaDetails].
extension CatalogMediaDetailsPatterns on CatalogMediaDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogMediaDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogMediaDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogMediaDetails value)  $default,){
final _that = this;
switch (_that) {
case _CatalogMediaDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogMediaDetails value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogMediaDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int year,  SearchMediaType mediaType,  String? posterUrl,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity,  int? tmdbId,  String? imdbId,  String? originalTitle,  CatalogProviderMediaType providerMediaType,  int? seasonsCount,  int? episodesCount,  List<CatalogSeasonDetails>? seasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogMediaDetails() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.posterUrl,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity,_that.tmdbId,_that.imdbId,_that.originalTitle,_that.providerMediaType,_that.seasonsCount,_that.episodesCount,_that.seasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int year,  SearchMediaType mediaType,  String? posterUrl,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity,  int? tmdbId,  String? imdbId,  String? originalTitle,  CatalogProviderMediaType providerMediaType,  int? seasonsCount,  int? episodesCount,  List<CatalogSeasonDetails>? seasons)  $default,) {final _that = this;
switch (_that) {
case _CatalogMediaDetails():
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.posterUrl,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity,_that.tmdbId,_that.imdbId,_that.originalTitle,_that.providerMediaType,_that.seasonsCount,_that.episodesCount,_that.seasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int year,  SearchMediaType mediaType,  String? posterUrl,  String synopsis,  List<String> genres,  int runtimeMinutes,  double popularity,  int? tmdbId,  String? imdbId,  String? originalTitle,  CatalogProviderMediaType providerMediaType,  int? seasonsCount,  int? episodesCount,  List<CatalogSeasonDetails>? seasons)?  $default,) {final _that = this;
switch (_that) {
case _CatalogMediaDetails() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.mediaType,_that.posterUrl,_that.synopsis,_that.genres,_that.runtimeMinutes,_that.popularity,_that.tmdbId,_that.imdbId,_that.originalTitle,_that.providerMediaType,_that.seasonsCount,_that.episodesCount,_that.seasons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogMediaDetails extends CatalogMediaDetails {
  const _CatalogMediaDetails({required this.id, required this.title, required this.year, required this.mediaType, this.posterUrl, required this.synopsis, required final  List<String> genres, required this.runtimeMinutes, required this.popularity, this.tmdbId, this.imdbId, this.originalTitle, required this.providerMediaType, this.seasonsCount, this.episodesCount, final  List<CatalogSeasonDetails>? seasons}): _genres = genres,_seasons = seasons,super._();
  factory _CatalogMediaDetails.fromJson(Map<String, dynamic> json) => _$CatalogMediaDetailsFromJson(json);

@override final  String id;
@override final  String title;
@override final  int year;
@override final  SearchMediaType mediaType;
@override final  String? posterUrl;
@override final  String synopsis;
 final  List<String> _genres;
@override List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override final  int runtimeMinutes;
@override final  double popularity;
@override final  int? tmdbId;
@override final  String? imdbId;
@override final  String? originalTitle;
@override final  CatalogProviderMediaType providerMediaType;
@override final  int? seasonsCount;
@override final  int? episodesCount;
 final  List<CatalogSeasonDetails>? _seasons;
@override List<CatalogSeasonDetails>? get seasons {
  final value = _seasons;
  if (value == null) return null;
  if (_seasons is EqualUnmodifiableListView) return _seasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CatalogMediaDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogMediaDetailsCopyWith<_CatalogMediaDetails> get copyWith => __$CatalogMediaDetailsCopyWithImpl<_CatalogMediaDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogMediaDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogMediaDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.runtimeMinutes, runtimeMinutes) || other.runtimeMinutes == runtimeMinutes)&&(identical(other.popularity, popularity) || other.popularity == popularity)&&(identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId)&&(identical(other.imdbId, imdbId) || other.imdbId == imdbId)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.providerMediaType, providerMediaType) || other.providerMediaType == providerMediaType)&&(identical(other.seasonsCount, seasonsCount) || other.seasonsCount == seasonsCount)&&(identical(other.episodesCount, episodesCount) || other.episodesCount == episodesCount)&&const DeepCollectionEquality().equals(other._seasons, _seasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,mediaType,posterUrl,synopsis,const DeepCollectionEquality().hash(_genres),runtimeMinutes,popularity,tmdbId,imdbId,originalTitle,providerMediaType,seasonsCount,episodesCount,const DeepCollectionEquality().hash(_seasons));

@override
String toString() {
  return 'CatalogMediaDetails(id: $id, title: $title, year: $year, mediaType: $mediaType, posterUrl: $posterUrl, synopsis: $synopsis, genres: $genres, runtimeMinutes: $runtimeMinutes, popularity: $popularity, tmdbId: $tmdbId, imdbId: $imdbId, originalTitle: $originalTitle, providerMediaType: $providerMediaType, seasonsCount: $seasonsCount, episodesCount: $episodesCount, seasons: $seasons)';
}


}

/// @nodoc
abstract mixin class _$CatalogMediaDetailsCopyWith<$Res> implements $CatalogMediaDetailsCopyWith<$Res> {
  factory _$CatalogMediaDetailsCopyWith(_CatalogMediaDetails value, $Res Function(_CatalogMediaDetails) _then) = __$CatalogMediaDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int year, SearchMediaType mediaType, String? posterUrl, String synopsis, List<String> genres, int runtimeMinutes, double popularity, int? tmdbId, String? imdbId, String? originalTitle, CatalogProviderMediaType providerMediaType, int? seasonsCount, int? episodesCount, List<CatalogSeasonDetails>? seasons
});




}
/// @nodoc
class __$CatalogMediaDetailsCopyWithImpl<$Res>
    implements _$CatalogMediaDetailsCopyWith<$Res> {
  __$CatalogMediaDetailsCopyWithImpl(this._self, this._then);

  final _CatalogMediaDetails _self;
  final $Res Function(_CatalogMediaDetails) _then;

/// Create a copy of CatalogMediaDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? year = null,Object? mediaType = null,Object? posterUrl = freezed,Object? synopsis = null,Object? genres = null,Object? runtimeMinutes = null,Object? popularity = null,Object? tmdbId = freezed,Object? imdbId = freezed,Object? originalTitle = freezed,Object? providerMediaType = null,Object? seasonsCount = freezed,Object? episodesCount = freezed,Object? seasons = freezed,}) {
  return _then(_CatalogMediaDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as SearchMediaType,posterUrl: freezed == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String?,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,runtimeMinutes: null == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as double,tmdbId: freezed == tmdbId ? _self.tmdbId : tmdbId // ignore: cast_nullable_to_non_nullable
as int?,imdbId: freezed == imdbId ? _self.imdbId : imdbId // ignore: cast_nullable_to_non_nullable
as String?,originalTitle: freezed == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String?,providerMediaType: null == providerMediaType ? _self.providerMediaType : providerMediaType // ignore: cast_nullable_to_non_nullable
as CatalogProviderMediaType,seasonsCount: freezed == seasonsCount ? _self.seasonsCount : seasonsCount // ignore: cast_nullable_to_non_nullable
as int?,episodesCount: freezed == episodesCount ? _self.episodesCount : episodesCount // ignore: cast_nullable_to_non_nullable
as int?,seasons: freezed == seasons ? _self._seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<CatalogSeasonDetails>?,
  ));
}


}

// dart format on
