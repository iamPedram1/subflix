// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackendHealth _$BackendHealthFromJson(Map<String, dynamic> json) =>
    _BackendHealth(
      status: json['status'] as String,
      service: json['service'] as String,
      environment: json['environment'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$BackendHealthToJson(_BackendHealth instance) =>
    <String, dynamic>{
      'status': instance.status,
      'service': instance.service,
      'environment': instance.environment,
      'timestamp': instance.timestamp.toIso8601String(),
    };
