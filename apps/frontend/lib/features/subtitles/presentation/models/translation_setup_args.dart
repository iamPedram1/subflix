import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_format.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_source.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

class TranslationSetupArgs {
  const TranslationSetupArgs.catalog({required this.item, required this.source})
    : file = null;

  const TranslationSetupArgs.upload({required this.file})
    : item = null,
      source = null;

  final MovieSearchItem? item;
  final SubtitleSource? source;
  final SubtitleFile? file;

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
    );
  }
}
