import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

class TranslationSetupArgs {
  const TranslationSetupArgs.catalog({
    required this.item,
    required this.source,
    this.seasonNumber,
    this.episodeNumber,
    this.releaseHint,
  }) : file = null;

  const TranslationSetupArgs.upload({required this.file})
    : item = null,
      source = null,
      seasonNumber = null,
      episodeNumber = null,
      releaseHint = null;

  final MovieSearchItem? item;
  final SubtitleSource? source;
  final SubtitleFile? file;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? releaseHint;

  bool get isUpload => file != null;

  String get title => item?.title ?? file!.name;

  String get sourceName => source?.label ?? file!.name;

  SubtitleFormat get format => source?.format ?? file!.format;

  TranslationRequest toRequest(AppLanguage targetLanguage) {
    final file = this.file;
    if (file != null) {
      return TranslationRequest.upload(
        file: file,
        targetLanguage: targetLanguage,
      );
    }

    return TranslationRequest.catalog(
      item: item!,
      source: source!,
      targetLanguage: targetLanguage,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      releaseHint: releaseHint,
    );
  }
}
