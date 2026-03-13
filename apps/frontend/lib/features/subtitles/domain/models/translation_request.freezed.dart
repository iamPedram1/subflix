// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranslationRequest {

 AppLanguage get targetLanguage;
/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationRequestCopyWith<TranslationRequest> get copyWith => _$TranslationRequestCopyWithImpl<TranslationRequest>(this as TranslationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationRequest&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,targetLanguage);

@override
String toString() {
  return 'TranslationRequest(targetLanguage: $targetLanguage)';
}


}

/// @nodoc
abstract mixin class $TranslationRequestCopyWith<$Res>  {
  factory $TranslationRequestCopyWith(TranslationRequest value, $Res Function(TranslationRequest) _then) = _$TranslationRequestCopyWithImpl;
@useResult
$Res call({
 AppLanguage targetLanguage
});




}
/// @nodoc
class _$TranslationRequestCopyWithImpl<$Res>
    implements $TranslationRequestCopyWith<$Res> {
  _$TranslationRequestCopyWithImpl(this._self, this._then);

  final TranslationRequest _self;
  final $Res Function(TranslationRequest) _then;

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetLanguage = null,}) {
  return _then(_self.copyWith(
targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationRequest].
extension TranslationRequestPatterns on TranslationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatalogTranslationRequest value)?  catalog,TResult Function( UploadTranslationRequest value)?  upload,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatalogTranslationRequest() when catalog != null:
return catalog(_that);case UploadTranslationRequest() when upload != null:
return upload(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatalogTranslationRequest value)  catalog,required TResult Function( UploadTranslationRequest value)  upload,}){
final _that = this;
switch (_that) {
case CatalogTranslationRequest():
return catalog(_that);case UploadTranslationRequest():
return upload(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatalogTranslationRequest value)?  catalog,TResult? Function( UploadTranslationRequest value)?  upload,}){
final _that = this;
switch (_that) {
case CatalogTranslationRequest() when catalog != null:
return catalog(_that);case UploadTranslationRequest() when upload != null:
return upload(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MovieSearchItem item,  SubtitleSource source,  AppLanguage targetLanguage)?  catalog,TResult Function( SubtitleFile file,  AppLanguage targetLanguage)?  upload,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatalogTranslationRequest() when catalog != null:
return catalog(_that.item,_that.source,_that.targetLanguage);case UploadTranslationRequest() when upload != null:
return upload(_that.file,_that.targetLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MovieSearchItem item,  SubtitleSource source,  AppLanguage targetLanguage)  catalog,required TResult Function( SubtitleFile file,  AppLanguage targetLanguage)  upload,}) {final _that = this;
switch (_that) {
case CatalogTranslationRequest():
return catalog(_that.item,_that.source,_that.targetLanguage);case UploadTranslationRequest():
return upload(_that.file,_that.targetLanguage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MovieSearchItem item,  SubtitleSource source,  AppLanguage targetLanguage)?  catalog,TResult? Function( SubtitleFile file,  AppLanguage targetLanguage)?  upload,}) {final _that = this;
switch (_that) {
case CatalogTranslationRequest() when catalog != null:
return catalog(_that.item,_that.source,_that.targetLanguage);case UploadTranslationRequest() when upload != null:
return upload(_that.file,_that.targetLanguage);case _:
  return null;

}
}

}

/// @nodoc


class CatalogTranslationRequest implements TranslationRequest {
  const CatalogTranslationRequest({required this.item, required this.source, required this.targetLanguage});
  

 final  MovieSearchItem item;
 final  SubtitleSource source;
@override final  AppLanguage targetLanguage;

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogTranslationRequestCopyWith<CatalogTranslationRequest> get copyWith => _$CatalogTranslationRequestCopyWithImpl<CatalogTranslationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogTranslationRequest&&(identical(other.item, item) || other.item == item)&&(identical(other.source, source) || other.source == source)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,item,source,targetLanguage);

@override
String toString() {
  return 'TranslationRequest.catalog(item: $item, source: $source, targetLanguage: $targetLanguage)';
}


}

/// @nodoc
abstract mixin class $CatalogTranslationRequestCopyWith<$Res> implements $TranslationRequestCopyWith<$Res> {
  factory $CatalogTranslationRequestCopyWith(CatalogTranslationRequest value, $Res Function(CatalogTranslationRequest) _then) = _$CatalogTranslationRequestCopyWithImpl;
@override @useResult
$Res call({
 MovieSearchItem item, SubtitleSource source, AppLanguage targetLanguage
});


$MovieSearchItemCopyWith<$Res> get item;$SubtitleSourceCopyWith<$Res> get source;

}
/// @nodoc
class _$CatalogTranslationRequestCopyWithImpl<$Res>
    implements $CatalogTranslationRequestCopyWith<$Res> {
  _$CatalogTranslationRequestCopyWithImpl(this._self, this._then);

  final CatalogTranslationRequest _self;
  final $Res Function(CatalogTranslationRequest) _then;

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? source = null,Object? targetLanguage = null,}) {
  return _then(CatalogTranslationRequest(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as MovieSearchItem,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SubtitleSource,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovieSearchItemCopyWith<$Res> get item {
  
  return $MovieSearchItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubtitleSourceCopyWith<$Res> get source {
  
  return $SubtitleSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

/// @nodoc


class UploadTranslationRequest implements TranslationRequest {
  const UploadTranslationRequest({required this.file, required this.targetLanguage});
  

 final  SubtitleFile file;
@override final  AppLanguage targetLanguage;

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadTranslationRequestCopyWith<UploadTranslationRequest> get copyWith => _$UploadTranslationRequestCopyWithImpl<UploadTranslationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadTranslationRequest&&(identical(other.file, file) || other.file == file)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,file,targetLanguage);

@override
String toString() {
  return 'TranslationRequest.upload(file: $file, targetLanguage: $targetLanguage)';
}


}

/// @nodoc
abstract mixin class $UploadTranslationRequestCopyWith<$Res> implements $TranslationRequestCopyWith<$Res> {
  factory $UploadTranslationRequestCopyWith(UploadTranslationRequest value, $Res Function(UploadTranslationRequest) _then) = _$UploadTranslationRequestCopyWithImpl;
@override @useResult
$Res call({
 SubtitleFile file, AppLanguage targetLanguage
});


$SubtitleFileCopyWith<$Res> get file;

}
/// @nodoc
class _$UploadTranslationRequestCopyWithImpl<$Res>
    implements $UploadTranslationRequestCopyWith<$Res> {
  _$UploadTranslationRequestCopyWithImpl(this._self, this._then);

  final UploadTranslationRequest _self;
  final $Res Function(UploadTranslationRequest) _then;

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? targetLanguage = null,}) {
  return _then(UploadTranslationRequest(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as SubtitleFile,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}

/// Create a copy of TranslationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubtitleFileCopyWith<$Res> get file {
  
  return $SubtitleFileCopyWith<$Res>(_self.file, (value) {
    return _then(_self.copyWith(file: value));
  });
}
}

// dart format on
