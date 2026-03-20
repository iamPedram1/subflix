import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/health/domain/models/backend_health.dart';

part 'backend_health_provider.g.dart';

@Riverpod(keepAlive: true)
Future<BackendHealth> backendHealth(Ref ref) {
  return ref.watch(healthApiProvider).getHealth();
}
