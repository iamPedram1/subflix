import 'dart:io';

import 'package:dio/dio.dart';

/// Normalized exception used by repositories to surface API-friendly errors.
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.code,
    this.statusCode,
    this.details,
    this.requestId,
    this.timestamp,
  });

  factory ApiException.fromDioException(DioException error) {
    final response = error.response;
    final data = response?.data;
    final statusCode = response?.statusCode;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      return ApiException(
        message: _stringifyMessage(message),
        code: data['code'] as String?,
        statusCode: statusCode,
        details: data['details'],
        requestId: data['requestId'] as String?,
        timestamp: _parseTimestamp(data['timestamp']),
      );
    }

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const ApiException(
        message:
            'The server took too long to respond. Please check the backend and try again.',
      ),
      DioExceptionType.connectionError => const ApiException(
        message:
            'Could not reach the SubFlix backend. Make sure the API is running and the base URL is correct.',
      ),
      DioExceptionType.badCertificate => const ApiException(
        message: 'The backend certificate was rejected.',
      ),
      DioExceptionType.cancel => const ApiException(
        message: 'The request was cancelled.',
      ),
      DioExceptionType.badResponse => ApiException(
        message: statusCode == null
            ? 'The backend responded with an unexpected status code.'
            : 'The backend responded with an unexpected status code ($statusCode).',
        statusCode: statusCode,
      ),
      DioExceptionType.unknown => ApiException(
        message: error.error is SocketException
            ? 'Could not reach the SubFlix backend. Make sure the API is running and the base URL is correct.'
            : (error.message ?? 'An unexpected network error occurred.'),
      ),
    };
  }

  final String message;
  final String? code;
  final int? statusCode;
  final Object? details;
  final String? requestId;
  final DateTime? timestamp;

  bool get isUnauthorized => statusCode == 401;

  static String _stringifyMessage(Object? rawMessage) {
    if (rawMessage is List) {
      return rawMessage.join('\n');
    }
    if (rawMessage is String && rawMessage.trim().isNotEmpty) {
      return rawMessage;
    }
    return 'The request could not be completed.';
  }

  static DateTime? _parseTimestamp(Object? rawTimestamp) {
    if (rawTimestamp is! String || rawTimestamp.trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(rawTimestamp);
  }

  @override
  String toString() => message;
}
