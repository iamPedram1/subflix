import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';

part 'preferences_api.g.dart';

/// HTTP client for device-scoped preference endpoints.
class PreferencesApi {
  PreferencesApi(Dio dio, {String? baseUrl})
    : _client = PreferencesRestClient(dio, baseUrl: baseUrl);

  final PreferencesRestClient _client;

  Future<UserPreference> getPreferences() {
    return _client.getPreferences().guardApiCall();
  }

  Future<UserPreference> patchPreferences(Map<String, dynamic> payload) {
    return _client.patchPreferences(payload).guardApiCall();
  }
}

@RestApi()
abstract class PreferencesRestClient {
  factory PreferencesRestClient(Dio dio, {String? baseUrl}) =
      _PreferencesRestClient;

  @GET(ApiPaths.preferences)
  Future<UserPreference> getPreferences();

  @PATCH(ApiPaths.preferences)
  Future<UserPreference> patchPreferences(
    @Body() Map<String, dynamic> payload,
  );
}
