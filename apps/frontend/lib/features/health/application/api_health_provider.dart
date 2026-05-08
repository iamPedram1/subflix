import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/health/domain/models/api_health.dart';

part 'api_health_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ApiHealth> apiHealth(Ref ref) {
  return ref.watch(healthApiProvider).getHealth();
}
