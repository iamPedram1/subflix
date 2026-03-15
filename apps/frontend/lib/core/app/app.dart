import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/app/router/app_router.dart';
import 'package:subflix/core/localization/app_localizations.dart';
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
      onGenerateTitle: (context) => context.t.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.globalDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('en');
        return supportedLocales.firstWhere(
          (supported) => supported.languageCode == locale.languageCode,
          orElse: () => const Locale('en'),
        );
      },
    );
  }
}
