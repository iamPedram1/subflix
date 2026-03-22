import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_health.freezed.dart';
part 'api_health.g.dart';

@freezed
abstract class ApiHealth with _$ApiHealth {
  const factory ApiHealth({
    required String status,
    required String service,
    String? environment,
    required DateTime timestamp,
  }) = _ApiHealth;

  factory ApiHealth.fromJson(Map<String, dynamic> json) =>
      _$ApiHealthFromJson(json);
}
