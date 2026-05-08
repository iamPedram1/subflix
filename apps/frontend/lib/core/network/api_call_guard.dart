import 'package:dio/dio.dart';

import 'package:subflix/core/network/api_exception.dart';

/// Maps Dio failures from generated clients into the app's normalized API error.
extension ApiCallGuard<T> on Future<T> {
  Future<T> guardApiCall() async {
    try {
      return await this;
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}
