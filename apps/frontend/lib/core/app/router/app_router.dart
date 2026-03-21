import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/app/router/app_routes_data.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(initialLocation: AppRoutes.splash, routes: $appRoutes);
}
