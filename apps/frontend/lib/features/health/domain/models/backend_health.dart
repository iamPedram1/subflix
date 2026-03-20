import 'package:freezed_annotation/freezed_annotation.dart';

part 'backend_health.freezed.dart';
part 'backend_health.g.dart';

@freezed
abstract class BackendHealth with _$BackendHealth {
  const factory BackendHealth({
    required String status,
    required String service,
    String? environment,
    required DateTime timestamp,
  }) = _BackendHealth;

  factory BackendHealth.fromJson(Map<String, dynamic> json) =>
      _$BackendHealthFromJson(json);
}
