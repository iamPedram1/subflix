import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/app/router/app_router.dart';
import 'package:subflix/core/styles/theme.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(settingsControllerProvider);
    final themeMode =
        settings.asData?.value.themePreference.toThemeMode() ??
        ThemeMode.system;

    return MaterialApp.router(
      title: 'SubFlix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
