import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';

/// HTTP client for device-scoped preference endpoints.
class PreferencesApi {
  PreferencesApi(this._dio);

  final Dio _dio;

  Future<UserPreference> getPreferences() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/v1/preferences');
      return UserPreference.fromJson(response.data ?? const <String, dynamic>{});
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }

  Future<UserPreference> patchPreferences(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/v1/preferences',
        data: payload,
      );
      return UserPreference.fromJson(response.data ?? const <String, dynamic>{});
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}
