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

 String get id; String get title; String get sourceName; TranslationSourceType get sourceType; TranslationJobStatus get status; String get stageLabel; AppLanguage get sourceLanguage; AppLanguage get targetLanguage; DateTime get createdAt; DateTime get updatedAt; SubtitleFormat get format; int get lineCount; int get durationMs; List<SubtitleLine> get lines; double get progress; String? get errorMessage; int? get subtitleConfidenceScore; String? get subtitleConfidenceLevel; List<String> get subtitleWarnings; int? get subtitleTimingOffsetMs; int? get subtitleTimingConfidence; bool? get subtitleTimingCorrected; String? get subtitleAcquisitionMode; bool? get reusedExistingSubtitle; int? get reusedSubtitleConfidenceScore; String? get reusedSubtitleConfidenceLevel; bool? get translationReuse; String? get translationReusedFromJobId;
/// Create a copy of TranslationJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationJobCopyWith<TranslationJob> get copyWith => _$TranslationJobCopyWithImpl<TranslationJob>(this as TranslationJob, _$identity);

  /// Serializes this TranslationJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.format, format) || other.format == format)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.subtitleConfidenceScore, subtitleConfidenceScore) || other.subtitleConfidenceScore == subtitleConfidenceScore)&&(identical(other.subtitleConfidenceLevel, subtitleConfidenceLevel) || other.subtitleConfidenceLevel == subtitleConfidenceLevel)&&const DeepCollectionEquality().equals(other.subtitleWarnings, subtitleWarnings)&&(identical(other.subtitleTimingOffsetMs, subtitleTimingOffsetMs) || other.subtitleTimingOffsetMs == subtitleTimingOffsetMs)&&(identical(other.subtitleTimingConfidence, subtitleTimingConfidence) || other.subtitleTimingConfidence == subtitleTimingConfidence)&&(identical(other.subtitleTimingCorrected, subtitleTimingCorrected) || other.subtitleTimingCorrected == subtitleTimingCorrected)&&(identical(other.subtitleAcquisitionMode, subtitleAcquisitionMode) || other.subtitleAcquisitionMode == subtitleAcquisitionMode)&&(identical(other.reusedExistingSubtitle, reusedExistingSubtitle) || other.reusedExistingSubtitle == reusedExistingSubtitle)&&(identical(other.reusedSubtitleConfidenceScore, reusedSubtitleConfidenceScore) || other.reusedSubtitleConfidenceScore == reusedSubtitleConfidenceScore)&&(identical(other.reusedSubtitleConfidenceLevel, reusedSubtitleConfidenceLevel) || other.reusedSubtitleConfidenceLevel == reusedSubtitleConfidenceLevel)&&(identical(other.translationReuse, translationReuse) || other.translationReuse == translationReuse)&&(identical(other.translationReusedFromJobId, translationReusedFromJobId) || other.translationReusedFromJobId == translationReusedFromJobId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,sourceName,sourceType,status,stageLabel,sourceLanguage,targetLanguage,createdAt,updatedAt,format,lineCount,durationMs,const DeepCollectionEquality().hash(lines),progress,errorMessage,subtitleConfidenceScore,subtitleConfidenceLevel,const DeepCollectionEquality().hash(subtitleWarnings),subtitleTimingOffsetMs,subtitleTimingConfidence,subtitleTimingCorrected,subtitleAcquisitionMode,reusedExistingSubtitle,reusedSubtitleConfidenceScore,reusedSubtitleConfidenceLevel,translationReuse,translationReusedFromJobId]);

@override
String toString() {
  return 'TranslationJob(id: $id, title: $title, sourceName: $sourceName, sourceType: $sourceType, status: $status, stageLabel: $stageLabel, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, createdAt: $createdAt, updatedAt: $updatedAt, format: $format, lineCount: $lineCount, durationMs: $durationMs, lines: $lines, progress: $progress, errorMessage: $errorMessage, subtitleConfidenceScore: $subtitleConfidenceScore, subtitleConfidenceLevel: $subtitleConfidenceLevel, subtitleWarnings: $subtitleWarnings, subtitleTimingOffsetMs: $subtitleTimingOffsetMs, subtitleTimingConfidence: $subtitleTimingConfidence, subtitleTimingCorrected: $subtitleTimingCorrected, subtitleAcquisitionMode: $subtitleAcquisitionMode, reusedExistingSubtitle: $reusedExistingSubtitle, reusedSubtitleConfidenceScore: $reusedSubtitleConfidenceScore, reusedSubtitleConfidenceLevel: $reusedSubtitleConfidenceLevel, translationReuse: $translationReuse, translationReusedFromJobId: $translationReusedFromJobId)';
}


}

/// @nodoc
abstract mixin class $TranslationJobCopyWith<$Res>  {
  factory $TranslationJobCopyWith(TranslationJob value, $Res Function(TranslationJob) _then) = _$TranslationJobCopyWithImpl;
@useResult
$Res call({
 String id, String title, String sourceName, TranslationSourceType sourceType, TranslationJobStatus status, String stageLabel, AppLanguage sourceLanguage, AppLanguage targetLanguage, DateTime createdAt, DateTime updatedAt, SubtitleFormat format, int lineCount, int durationMs, List<SubtitleLine> lines, double progress, String? errorMessage, int? subtitleConfidenceScore, String? subtitleConfidenceLevel, List<String> subtitleWarnings, int? subtitleTimingOffsetMs, int? subtitleTimingConfidence, bool? subtitleTimingCorrected, String? subtitleAcquisitionMode, bool? reusedExistingSubtitle, int? reusedSubtitleConfidenceScore, String? reusedSubtitleConfidenceLevel, bool? translationReuse, String? translationReusedFromJobId
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? sourceName = null,Object? sourceType = null,Object? status = null,Object? stageLabel = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? createdAt = null,Object? updatedAt = null,Object? format = null,Object? lineCount = null,Object? durationMs = null,Object? lines = null,Object? progress = null,Object? errorMessage = freezed,Object? subtitleConfidenceScore = freezed,Object? subtitleConfidenceLevel = freezed,Object? subtitleWarnings = null,Object? subtitleTimingOffsetMs = freezed,Object? subtitleTimingConfidence = freezed,Object? subtitleTimingCorrected = freezed,Object? subtitleAcquisitionMode = freezed,Object? reusedExistingSubtitle = freezed,Object? reusedSubtitleConfidenceScore = freezed,Object? reusedSubtitleConfidenceLevel = freezed,Object? translationReuse = freezed,Object? translationReusedFromJobId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as TranslationSourceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranslationJobStatus,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,subtitleConfidenceScore: freezed == subtitleConfidenceScore ? _self.subtitleConfidenceScore : subtitleConfidenceScore // ignore: cast_nullable_to_non_nullable
as int?,subtitleConfidenceLevel: freezed == subtitleConfidenceLevel ? _self.subtitleConfidenceLevel : subtitleConfidenceLevel // ignore: cast_nullable_to_non_nullable
as String?,subtitleWarnings: null == subtitleWarnings ? _self.subtitleWarnings : subtitleWarnings // ignore: cast_nullable_to_non_nullable
as List<String>,subtitleTimingOffsetMs: freezed == subtitleTimingOffsetMs ? _self.subtitleTimingOffsetMs : subtitleTimingOffsetMs // ignore: cast_nullable_to_non_nullable
as int?,subtitleTimingConfidence: freezed == subtitleTimingConfidence ? _self.subtitleTimingConfidence : subtitleTimingConfidence // ignore: cast_nullable_to_non_nullable
as int?,subtitleTimingCorrected: freezed == subtitleTimingCorrected ? _self.subtitleTimingCorrected : subtitleTimingCorrected // ignore: cast_nullable_to_non_nullable
as bool?,subtitleAcquisitionMode: freezed == subtitleAcquisitionMode ? _self.subtitleAcquisitionMode : subtitleAcquisitionMode // ignore: cast_nullable_to_non_nullable
as String?,reusedExistingSubtitle: freezed == reusedExistingSubtitle ? _self.reusedExistingSubtitle : reusedExistingSubtitle // ignore: cast_nullable_to_non_nullable
as bool?,reusedSubtitleConfidenceScore: freezed == reusedSubtitleConfidenceScore ? _self.reusedSubtitleConfidenceScore : reusedSubtitleConfidenceScore // ignore: cast_nullable_to_non_nullable
as int?,reusedSubtitleConfidenceLevel: freezed == reusedSubtitleConfidenceLevel ? _self.reusedSubtitleConfidenceLevel : reusedSubtitleConfidenceLevel // ignore: cast_nullable_to_non_nullable
as String?,translationReuse: freezed == translationReuse ? _self.translationReuse : translationReuse // ignore: cast_nullable_to_non_nullable
as bool?,translationReusedFromJobId: freezed == translationReusedFromJobId ? _self.translationReusedFromJobId : translationReusedFromJobId // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  String stageLabel,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  int lineCount,  int durationMs,  List<SubtitleLine> lines,  double progress,  String? errorMessage,  int? subtitleConfidenceScore,  String? subtitleConfidenceLevel,  List<String> subtitleWarnings,  int? subtitleTimingOffsetMs,  int? subtitleTimingConfidence,  bool? subtitleTimingCorrected,  String? subtitleAcquisitionMode,  bool? reusedExistingSubtitle,  int? reusedSubtitleConfidenceScore,  String? reusedSubtitleConfidenceLevel,  bool? translationReuse,  String? translationReusedFromJobId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.stageLabel,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lineCount,_that.durationMs,_that.lines,_that.progress,_that.errorMessage,_that.subtitleConfidenceScore,_that.subtitleConfidenceLevel,_that.subtitleWarnings,_that.subtitleTimingOffsetMs,_that.subtitleTimingConfidence,_that.subtitleTimingCorrected,_that.subtitleAcquisitionMode,_that.reusedExistingSubtitle,_that.reusedSubtitleConfidenceScore,_that.reusedSubtitleConfidenceLevel,_that.translationReuse,_that.translationReusedFromJobId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  String stageLabel,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  int lineCount,  int durationMs,  List<SubtitleLine> lines,  double progress,  String? errorMessage,  int? subtitleConfidenceScore,  String? subtitleConfidenceLevel,  List<String> subtitleWarnings,  int? subtitleTimingOffsetMs,  int? subtitleTimingConfidence,  bool? subtitleTimingCorrected,  String? subtitleAcquisitionMode,  bool? reusedExistingSubtitle,  int? reusedSubtitleConfidenceScore,  String? reusedSubtitleConfidenceLevel,  bool? translationReuse,  String? translationReusedFromJobId)  $default,) {final _that = this;
switch (_that) {
case _TranslationJob():
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.stageLabel,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lineCount,_that.durationMs,_that.lines,_that.progress,_that.errorMessage,_that.subtitleConfidenceScore,_that.subtitleConfidenceLevel,_that.subtitleWarnings,_that.subtitleTimingOffsetMs,_that.subtitleTimingConfidence,_that.subtitleTimingCorrected,_that.subtitleAcquisitionMode,_that.reusedExistingSubtitle,_that.reusedSubtitleConfidenceScore,_that.reusedSubtitleConfidenceLevel,_that.translationReuse,_that.translationReusedFromJobId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String sourceName,  TranslationSourceType sourceType,  TranslationJobStatus status,  String stageLabel,  AppLanguage sourceLanguage,  AppLanguage targetLanguage,  DateTime createdAt,  DateTime updatedAt,  SubtitleFormat format,  int lineCount,  int durationMs,  List<SubtitleLine> lines,  double progress,  String? errorMessage,  int? subtitleConfidenceScore,  String? subtitleConfidenceLevel,  List<String> subtitleWarnings,  int? subtitleTimingOffsetMs,  int? subtitleTimingConfidence,  bool? subtitleTimingCorrected,  String? subtitleAcquisitionMode,  bool? reusedExistingSubtitle,  int? reusedSubtitleConfidenceScore,  String? reusedSubtitleConfidenceLevel,  bool? translationReuse,  String? translationReusedFromJobId)?  $default,) {final _that = this;
switch (_that) {
case _TranslationJob() when $default != null:
return $default(_that.id,_that.title,_that.sourceName,_that.sourceType,_that.status,_that.stageLabel,_that.sourceLanguage,_that.targetLanguage,_that.createdAt,_that.updatedAt,_that.format,_that.lineCount,_that.durationMs,_that.lines,_that.progress,_that.errorMessage,_that.subtitleConfidenceScore,_that.subtitleConfidenceLevel,_that.subtitleWarnings,_that.subtitleTimingOffsetMs,_that.subtitleTimingConfidence,_that.subtitleTimingCorrected,_that.subtitleAcquisitionMode,_that.reusedExistingSubtitle,_that.reusedSubtitleConfidenceScore,_that.reusedSubtitleConfidenceLevel,_that.translationReuse,_that.translationReusedFromJobId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationJob implements TranslationJob {
  const _TranslationJob({required this.id, required this.title, required this.sourceName, required this.sourceType, required this.status, required this.stageLabel, required this.sourceLanguage, required this.targetLanguage, required this.createdAt, required this.updatedAt, required this.format, required this.lineCount, required this.durationMs, final  List<SubtitleLine> lines = const <SubtitleLine>[], required this.progress, this.errorMessage, this.subtitleConfidenceScore, this.subtitleConfidenceLevel, final  List<String> subtitleWarnings = const <String>[], this.subtitleTimingOffsetMs, this.subtitleTimingConfidence, this.subtitleTimingCorrected, this.subtitleAcquisitionMode, this.reusedExistingSubtitle, this.reusedSubtitleConfidenceScore, this.reusedSubtitleConfidenceLevel, this.translationReuse, this.translationReusedFromJobId}): _lines = lines,_subtitleWarnings = subtitleWarnings;
  factory _TranslationJob.fromJson(Map<String, dynamic> json) => _$TranslationJobFromJson(json);

@override final  String id;
@override final  String title;
@override final  String sourceName;
@override final  TranslationSourceType sourceType;
@override final  TranslationJobStatus status;
@override final  String stageLabel;
@override final  AppLanguage sourceLanguage;
@override final  AppLanguage targetLanguage;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SubtitleFormat format;
@override final  int lineCount;
@override final  int durationMs;
 final  List<SubtitleLine> _lines;
@override@JsonKey() List<SubtitleLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  double progress;
@override final  String? errorMessage;
@override final  int? subtitleConfidenceScore;
@override final  String? subtitleConfidenceLevel;
 final  List<String> _subtitleWarnings;
@override@JsonKey() List<String> get subtitleWarnings {
  if (_subtitleWarnings is EqualUnmodifiableListView) return _subtitleWarnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subtitleWarnings);
}

@override final  int? subtitleTimingOffsetMs;
@override final  int? subtitleTimingConfidence;
@override final  bool? subtitleTimingCorrected;
@override final  String? subtitleAcquisitionMode;
@override final  bool? reusedExistingSubtitle;
@override final  int? reusedSubtitleConfidenceScore;
@override final  String? reusedSubtitleConfidenceLevel;
@override final  bool? translationReuse;
@override final  String? translationReusedFromJobId;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.format, format) || other.format == format)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.subtitleConfidenceScore, subtitleConfidenceScore) || other.subtitleConfidenceScore == subtitleConfidenceScore)&&(identical(other.subtitleConfidenceLevel, subtitleConfidenceLevel) || other.subtitleConfidenceLevel == subtitleConfidenceLevel)&&const DeepCollectionEquality().equals(other._subtitleWarnings, _subtitleWarnings)&&(identical(other.subtitleTimingOffsetMs, subtitleTimingOffsetMs) || other.subtitleTimingOffsetMs == subtitleTimingOffsetMs)&&(identical(other.subtitleTimingConfidence, subtitleTimingConfidence) || other.subtitleTimingConfidence == subtitleTimingConfidence)&&(identical(other.subtitleTimingCorrected, subtitleTimingCorrected) || other.subtitleTimingCorrected == subtitleTimingCorrected)&&(identical(other.subtitleAcquisitionMode, subtitleAcquisitionMode) || other.subtitleAcquisitionMode == subtitleAcquisitionMode)&&(identical(other.reusedExistingSubtitle, reusedExistingSubtitle) || other.reusedExistingSubtitle == reusedExistingSubtitle)&&(identical(other.reusedSubtitleConfidenceScore, reusedSubtitleConfidenceScore) || other.reusedSubtitleConfidenceScore == reusedSubtitleConfidenceScore)&&(identical(other.reusedSubtitleConfidenceLevel, reusedSubtitleConfidenceLevel) || other.reusedSubtitleConfidenceLevel == reusedSubtitleConfidenceLevel)&&(identical(other.translationReuse, translationReuse) || other.translationReuse == translationReuse)&&(identical(other.translationReusedFromJobId, translationReusedFromJobId) || other.translationReusedFromJobId == translationReusedFromJobId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,sourceName,sourceType,status,stageLabel,sourceLanguage,targetLanguage,createdAt,updatedAt,format,lineCount,durationMs,const DeepCollectionEquality().hash(_lines),progress,errorMessage,subtitleConfidenceScore,subtitleConfidenceLevel,const DeepCollectionEquality().hash(_subtitleWarnings),subtitleTimingOffsetMs,subtitleTimingConfidence,subtitleTimingCorrected,subtitleAcquisitionMode,reusedExistingSubtitle,reusedSubtitleConfidenceScore,reusedSubtitleConfidenceLevel,translationReuse,translationReusedFromJobId]);

@override
String toString() {
  return 'TranslationJob(id: $id, title: $title, sourceName: $sourceName, sourceType: $sourceType, status: $status, stageLabel: $stageLabel, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, createdAt: $createdAt, updatedAt: $updatedAt, format: $format, lineCount: $lineCount, durationMs: $durationMs, lines: $lines, progress: $progress, errorMessage: $errorMessage, subtitleConfidenceScore: $subtitleConfidenceScore, subtitleConfidenceLevel: $subtitleConfidenceLevel, subtitleWarnings: $subtitleWarnings, subtitleTimingOffsetMs: $subtitleTimingOffsetMs, subtitleTimingConfidence: $subtitleTimingConfidence, subtitleTimingCorrected: $subtitleTimingCorrected, subtitleAcquisitionMode: $subtitleAcquisitionMode, reusedExistingSubtitle: $reusedExistingSubtitle, reusedSubtitleConfidenceScore: $reusedSubtitleConfidenceScore, reusedSubtitleConfidenceLevel: $reusedSubtitleConfidenceLevel, translationReuse: $translationReuse, translationReusedFromJobId: $translationReusedFromJobId)';
}


}

/// @nodoc
abstract mixin class _$TranslationJobCopyWith<$Res> implements $TranslationJobCopyWith<$Res> {
  factory _$TranslationJobCopyWith(_TranslationJob value, $Res Function(_TranslationJob) _then) = __$TranslationJobCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String sourceName, TranslationSourceType sourceType, TranslationJobStatus status, String stageLabel, AppLanguage sourceLanguage, AppLanguage targetLanguage, DateTime createdAt, DateTime updatedAt, SubtitleFormat format, int lineCount, int durationMs, List<SubtitleLine> lines, double progress, String? errorMessage, int? subtitleConfidenceScore, String? subtitleConfidenceLevel, List<String> subtitleWarnings, int? subtitleTimingOffsetMs, int? subtitleTimingConfidence, bool? subtitleTimingCorrected, String? subtitleAcquisitionMode, bool? reusedExistingSubtitle, int? reusedSubtitleConfidenceScore, String? reusedSubtitleConfidenceLevel, bool? translationReuse, String? translationReusedFromJobId
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? sourceName = null,Object? sourceType = null,Object? status = null,Object? stageLabel = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? createdAt = null,Object? updatedAt = null,Object? format = null,Object? lineCount = null,Object? durationMs = null,Object? lines = null,Object? progress = null,Object? errorMessage = freezed,Object? subtitleConfidenceScore = freezed,Object? subtitleConfidenceLevel = freezed,Object? subtitleWarnings = null,Object? subtitleTimingOffsetMs = freezed,Object? subtitleTimingConfidence = freezed,Object? subtitleTimingCorrected = freezed,Object? subtitleAcquisitionMode = freezed,Object? reusedExistingSubtitle = freezed,Object? reusedSubtitleConfidenceScore = freezed,Object? reusedSubtitleConfidenceLevel = freezed,Object? translationReuse = freezed,Object? translationReusedFromJobId = freezed,}) {
  return _then(_TranslationJob(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as TranslationSourceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranslationJobStatus,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as SubtitleFormat,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SubtitleLine>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,subtitleConfidenceScore: freezed == subtitleConfidenceScore ? _self.subtitleConfidenceScore : subtitleConfidenceScore // ignore: cast_nullable_to_non_nullable
as int?,subtitleConfidenceLevel: freezed == subtitleConfidenceLevel ? _self.subtitleConfidenceLevel : subtitleConfidenceLevel // ignore: cast_nullable_to_non_nullable
as String?,subtitleWarnings: null == subtitleWarnings ? _self._subtitleWarnings : subtitleWarnings // ignore: cast_nullable_to_non_nullable
as List<String>,subtitleTimingOffsetMs: freezed == subtitleTimingOffsetMs ? _self.subtitleTimingOffsetMs : subtitleTimingOffsetMs // ignore: cast_nullable_to_non_nullable
as int?,subtitleTimingConfidence: freezed == subtitleTimingConfidence ? _self.subtitleTimingConfidence : subtitleTimingConfidence // ignore: cast_nullable_to_non_nullable
as int?,subtitleTimingCorrected: freezed == subtitleTimingCorrected ? _self.subtitleTimingCorrected : subtitleTimingCorrected // ignore: cast_nullable_to_non_nullable
as bool?,subtitleAcquisitionMode: freezed == subtitleAcquisitionMode ? _self.subtitleAcquisitionMode : subtitleAcquisitionMode // ignore: cast_nullable_to_non_nullable
as String?,reusedExistingSubtitle: freezed == reusedExistingSubtitle ? _self.reusedExistingSubtitle : reusedExistingSubtitle // ignore: cast_nullable_to_non_nullable
as bool?,reusedSubtitleConfidenceScore: freezed == reusedSubtitleConfidenceScore ? _self.reusedSubtitleConfidenceScore : reusedSubtitleConfidenceScore // ignore: cast_nullable_to_non_nullable
as int?,reusedSubtitleConfidenceLevel: freezed == reusedSubtitleConfidenceLevel ? _self.reusedSubtitleConfidenceLevel : reusedSubtitleConfidenceLevel // ignore: cast_nullable_to_non_nullable
as String?,translationReuse: freezed == translationReuse ? _self.translationReuse : translationReuse // ignore: cast_nullable_to_non_nullable
as bool?,translationReusedFromJobId: freezed == translationReusedFromJobId ? _self.translationReusedFromJobId : translationReusedFromJobId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
