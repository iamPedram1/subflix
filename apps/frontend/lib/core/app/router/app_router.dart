import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/ui/widgets/route_state_missing_screen.dart';
import 'package:subflix/features/history/presentation/screens/history_screen.dart';
import 'package:subflix/features/home/presentation/screens/home_screen.dart';
import 'package:subflix/features/home/presentation/widgets/home_shell.dart';
import 'package:subflix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:subflix/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:subflix/features/search/domain/models/movie_search_item.dart';
import 'package:subflix/features/search/presentation/models/series_selection_args.dart';
import 'package:subflix/features/search/presentation/screens/search_screen.dart';
import 'package:subflix/features/search/presentation/screens/series_episodes_screen.dart';
import 'package:subflix/features/search/presentation/screens/series_seasons_screen.dart';
import 'package:subflix/features/settings/presentation/screens/legal_placeholder_screen.dart';
import 'package:subflix/features/settings/presentation/screens/settings_screen.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';
import 'package:subflix/features/subtitles/presentation/models/subtitle_sources_args.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';
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
        builder: (context, state) {
          final extra = state.extra;
          final args = switch (extra) {
            SubtitleSourcesArgs args => args,
            MovieSearchItem item => SubtitleSourcesArgs(item: item),
            _ => null,
          };

          if (args == null) {
            return RouteStateMissingScreen(
              title: context.t.routeMissingSubtitleSourcesTitle,
              message: context.t.routeMissingSubtitleSourcesMessage,
            );
          }

          return SubtitleSourcesScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutes.seriesSeasons,
        builder: (context, state) {
          final item = state.extra as MovieSearchItem?;
          if (item == null) {
            return RouteStateMissingScreen(
              title: context.t.routeMissingSeriesSeasonsTitle,
              message: context.t.routeMissingSeriesSeasonsMessage,
            );
          }

          return SeriesSeasonsScreen(item: item);
        },
      ),
      GoRoute(
        path: AppRoutes.seriesEpisodes,
        builder: (context, state) {
          final args = state.extra as SeriesEpisodesArgs?;
          if (args == null) {
            return RouteStateMissingScreen(
              title: context.t.routeMissingSeasonEpisodesTitle,
              message: context.t.routeMissingSeasonEpisodesMessage,
            );
          }

          return SeriesEpisodesScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutes.translateSetup,
        builder: (context, state) {
          final args = state.extra as TranslationSetupArgs?;
          if (args == null) {
            return RouteStateMissingScreen(
              title: context.t.routeMissingTranslationSetupTitle,
              message: context.t.routeMissingTranslationSetupMessage,
            );
          }

          return TranslationSetupScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutes.translationProgress,
        builder: (context, state) {
          final request = state.extra as TranslationRequest?;
          if (request == null) {
            return RouteStateMissingScreen(
              title: context.t.routeMissingTranslationProgressTitle,
              message: context.t.routeMissingTranslationProgressMessage,
            );
          }

          return TranslationProgressScreen(request: request);
        },
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
