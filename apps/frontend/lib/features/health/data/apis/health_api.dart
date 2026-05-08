import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:subflix/core/network/api_call_guard.dart';
import 'package:subflix/core/network/api_paths.dart';
import 'package:subflix/features/health/domain/models/api_health.dart';

part 'health_api.g.dart';

/// HTTP client for the public backend health endpoint.
class HealthApi {
  HealthApi(Dio dio, {String? baseUrl})
    : _client = HealthRestClient(dio, baseUrl: baseUrl);

  final HealthRestClient _client;

  Future<ApiHealth> getHealth() {
    return _client.getHealth().guardApiCall();
  }
}

@RestApi()
abstract class HealthRestClient {
  factory HealthRestClient(Dio dio, {String? baseUrl}) = _HealthRestClient;

  @GET(ApiPaths.health)
  Future<ApiHealth> getHealth();
}
