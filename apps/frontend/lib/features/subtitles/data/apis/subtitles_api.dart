import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';

/// HTTP client for subtitle upload parsing.
class SubtitlesApi {
  SubtitlesApi(this._dio);

  final Dio _dio;

  Future<SubtitleFile> parseFile({
    required String fileName,
    required Uint8List bytes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/subtitles/parse',
        data: FormData.fromMap(<String, dynamic>{
          'file': MultipartFile.fromBytes(bytes, filename: fileName),
        }),
      );
      return SubtitleFile.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}
