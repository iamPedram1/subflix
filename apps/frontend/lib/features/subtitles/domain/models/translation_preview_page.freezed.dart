// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_preview_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationPreviewPage {

 TranslationJob get job; List<SubtitleLine> get items; int get page; int get limit; int get total; int get totalPages;
/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationPreviewPageCopyWith<TranslationPreviewPage> get copyWith => _$TranslationPreviewPageCopyWithImpl<TranslationPreviewPage>(this as TranslationPreviewPage, _$identity);

  /// Serializes this TranslationPreviewPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationPreviewPage&&(identical(other.job, job) || other.job == job)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,job,const DeepCollectionEquality().hash(items),page,limit,total,totalPages);

@override
String toString() {
  return 'TranslationPreviewPage(job: $job, items: $items, page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $TranslationPreviewPageCopyWith<$Res>  {
  factory $TranslationPreviewPageCopyWith(TranslationPreviewPage value, $Res Function(TranslationPreviewPage) _then) = _$TranslationPreviewPageCopyWithImpl;
@useResult
$Res call({
 TranslationJob job, List<SubtitleLine> items, int page, int limit, int total, int totalPages
});


$TranslationJobCopyWith<$Res> get job;

}
/// @nodoc
class _$TranslationPreviewPageCopyWithImpl<$Res>
    implements $TranslationPreviewPageCopyWith<$Res> {
  _$TranslationPreviewPageCopyWithImpl(this._self, this._then);

  final TranslationPreviewPage _self;
  final $Res Function(TranslationPreviewPage) _then;

/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? job = null,Object? items = null,Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as TranslationJob,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<$Res> get job {
  
  return $TranslationJobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranslationPreviewPage].
extension TranslationPreviewPagePatterns on TranslationPreviewPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationPreviewPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationPreviewPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationPreviewPage value)  $default,){
final _that = this;
switch (_that) {
case _TranslationPreviewPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationPreviewPage value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationPreviewPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TranslationJob job,  List<SubtitleLine> items,  int page,  int limit,  int total,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationPreviewPage() when $default != null:
return $default(_that.job,_that.items,_that.page,_that.limit,_that.total,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TranslationJob job,  List<SubtitleLine> items,  int page,  int limit,  int total,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _TranslationPreviewPage():
return $default(_that.job,_that.items,_that.page,_that.limit,_that.total,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TranslationJob job,  List<SubtitleLine> items,  int page,  int limit,  int total,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _TranslationPreviewPage() when $default != null:
return $default(_that.job,_that.items,_that.page,_that.limit,_that.total,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationPreviewPage implements TranslationPreviewPage {
  const _TranslationPreviewPage({required this.job, required final  List<SubtitleLine> items, required this.page, required this.limit, required this.total, required this.totalPages}): _items = items;
  factory _TranslationPreviewPage.fromJson(Map<String, dynamic> json) => _$TranslationPreviewPageFromJson(json);

@override final  TranslationJob job;
 final  List<SubtitleLine> _items;
@override List<SubtitleLine> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  int limit;
@override final  int total;
@override final  int totalPages;

/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationPreviewPageCopyWith<_TranslationPreviewPage> get copyWith => __$TranslationPreviewPageCopyWithImpl<_TranslationPreviewPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationPreviewPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationPreviewPage&&(identical(other.job, job) || other.job == job)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,job,const DeepCollectionEquality().hash(_items),page,limit,total,totalPages);

@override
String toString() {
  return 'TranslationPreviewPage(job: $job, items: $items, page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$TranslationPreviewPageCopyWith<$Res> implements $TranslationPreviewPageCopyWith<$Res> {
  factory _$TranslationPreviewPageCopyWith(_TranslationPreviewPage value, $Res Function(_TranslationPreviewPage) _then) = __$TranslationPreviewPageCopyWithImpl;
@override @useResult
$Res call({
 TranslationJob job, List<SubtitleLine> items, int page, int limit, int total, int totalPages
});


@override $TranslationJobCopyWith<$Res> get job;

}
/// @nodoc
class __$TranslationPreviewPageCopyWithImpl<$Res>
    implements _$TranslationPreviewPageCopyWith<$Res> {
  __$TranslationPreviewPageCopyWithImpl(this._self, this._then);

  final _TranslationPreviewPage _self;
  final $Res Function(_TranslationPreviewPage) _then;

/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? job = null,Object? items = null,Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_TranslationPreviewPage(
job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as TranslationJob,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TranslationPreviewPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<$Res> get job {
  
  return $TranslationJobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
