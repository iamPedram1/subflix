import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/features/history/presentation/screens/history_screen.dart';
import 'package:subflix/features/home/presentation/screens/home_screen.dart';
import 'package:subflix/features/home/presentation/widgets/home_shell.dart';
import 'package:subflix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:subflix/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:subflix/features/search/presentation/screens/search_screen.dart';
import 'package:subflix/features/settings/presentation/screens/legal_placeholder_screen.dart';
import 'package:subflix/features/settings/presentation/screens/settings_screen.dart';
import 'package:subflix/features/subtitles/presentation/screens/subtitle_sources_screen.dart';
import 'package:subflix/features/subtitles/presentation/screens/translation_preview_screen.dart';
import 'package:subflix/features/subtitles/presentation/screens/translation_progress_screen.dart';
import 'package:subflix/features/subtitles/presentation/screens/translation_setup_screen.dart';
import 'package:subflix/features/subtitles/presentation/screens/upload_screen.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.subtitleSources,
        builder: (context, state) => const SubtitleSourcesScreen(),
      ),
      GoRoute(
        path: AppRoutes.translateSetup,
        builder: (context, state) => const TranslationSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.translationProgress,
        builder: (context, state) => const TranslationProgressScreen(),
      ),
      GoRoute(
        path: AppRoutes.translationPreview,
        builder: (context, state) => TranslationPreviewScreen(
          jobId: state.pathParameters['jobId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.upload,
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: AppRoutes.legal,
        builder: (context, state) => LegalPlaceholderScreen(
          slug: state.pathParameters['slug'] ?? 'about',
        ),
      ),
    ],
  );
}
