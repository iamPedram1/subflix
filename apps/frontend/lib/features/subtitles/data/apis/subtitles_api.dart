import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';

part 'subtitles_api.g.dart';

/// HTTP client for subtitle upload parsing.
class SubtitlesApi {
  SubtitlesApi(Dio dio, {String? baseUrl})
    : _client = SubtitlesRestClient(dio, baseUrl: baseUrl);

  final SubtitlesRestClient _client;

  Future<SubtitleFile> parseFile({
    required String fileName,
    required Uint8List bytes,
  }) async {
    final file = MultipartFile.fromBytes(bytes, filename: fileName);
    return _client.parseFile(file).guardApiCall();
  }
}

@RestApi()
abstract class SubtitlesRestClient {
  factory SubtitlesRestClient(Dio dio, {String? baseUrl}) =
      _SubtitlesRestClient;

  @POST(ApiPaths.subtitlesParse)
  @MultiPart()
  Future<SubtitleFile> parseFile(@Part(name: 'file') MultipartFile file);
}
