// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiHealth _$ApiHealthFromJson(Map<String, dynamic> json) => _ApiHealth(
  status: json['status'] as String,
  service: json['service'] as String,
  environment: json['environment'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ApiHealthToJson(_ApiHealth instance) =>
    <String, dynamic>{
      'status': instance.status,
      'service': instance.service,
      'environment': instance.environment,
      'timestamp': instance.timestamp.toIso8601String(),
    };
