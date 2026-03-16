import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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

part 'app_routes_data.g.dart';

@TypedGoRoute<SplashRoute>(path: AppRoutes.splash)
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<OnboardingRoute>(path: AppRoutes.onboarding)
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

@TypedStatefulShellRoute<HomeShellRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: AppRoutes.home),
      ],
    ),
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HistoryRoute>(path: AppRoutes.history),
      ],
    ),
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(path: AppRoutes.settings),
      ],
    ),
  ],
)
class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return HomeShell(navigationShell: navigationShell);
  }
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryScreen();
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

@TypedGoRoute<SearchRoute>(path: AppRoutes.search)
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchScreen();
}

@TypedGoRoute<SubtitleSourcesRoute>(path: AppRoutes.subtitleSources)
class SubtitleSourcesRoute extends GoRouteData with $SubtitleSourcesRoute {
  const SubtitleSourcesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final args = state.extra as SubtitleSourcesArgs?;
    if (args == null) {
      return RouteStateMissingScreen(
        title: context.t.routeMissingSubtitleSourcesTitle,
        message: context.t.routeMissingSubtitleSourcesMessage,
      );
    }

    return SubtitleSourcesScreen(args: args);
  }
}

@TypedGoRoute<SeriesSeasonsRoute>(path: AppRoutes.seriesSeasons)
class SeriesSeasonsRoute extends GoRouteData with $SeriesSeasonsRoute {
  const SeriesSeasonsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final item = state.extra as MovieSearchItem?;
    if (item == null) {
      return RouteStateMissingScreen(
        title: context.t.routeMissingSeriesSeasonsTitle,
        message: context.t.routeMissingSeriesSeasonsMessage,
      );
    }

    return SeriesSeasonsScreen(item: item);
  }
}

@TypedGoRoute<SeriesEpisodesRoute>(path: AppRoutes.seriesEpisodes)
class SeriesEpisodesRoute extends GoRouteData with $SeriesEpisodesRoute {
  const SeriesEpisodesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final args = state.extra as SeriesEpisodesArgs?;
    if (args == null) {
      return RouteStateMissingScreen(
        title: context.t.routeMissingSeasonEpisodesTitle,
        message: context.t.routeMissingSeasonEpisodesMessage,
      );
    }

    return SeriesEpisodesScreen(args: args);
  }
}

@TypedGoRoute<TranslationSetupRoute>(path: AppRoutes.translateSetup)
class TranslationSetupRoute extends GoRouteData with $TranslationSetupRoute {
  const TranslationSetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final args = state.extra as TranslationSetupArgs?;
    if (args == null) {
      return RouteStateMissingScreen(
        title: context.t.routeMissingTranslationSetupTitle,
        message: context.t.routeMissingTranslationSetupMessage,
      );
    }

    return TranslationSetupScreen(args: args);
  }
}

@TypedGoRoute<TranslationProgressRoute>(path: AppRoutes.translationProgress)
class TranslationProgressRoute extends GoRouteData with $TranslationProgressRoute {
  const TranslationProgressRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final request = state.extra as TranslationRequest?;
    if (request == null) {
      return RouteStateMissingScreen(
        title: context.t.routeMissingTranslationProgressTitle,
        message: context.t.routeMissingTranslationProgressMessage,
      );
    }

    return TranslationProgressScreen(request: request);
  }
}

@TypedGoRoute<TranslationPreviewRoute>(path: AppRoutes.translationPreview)
class TranslationPreviewRoute extends GoRouteData with $TranslationPreviewRoute {
  const TranslationPreviewRoute({required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TranslationPreviewScreen(jobId: jobId);
}

@TypedGoRoute<UploadRoute>(path: AppRoutes.upload)
class UploadRoute extends GoRouteData with $UploadRoute {
  const UploadRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UploadScreen();
}

@TypedGoRoute<LegalRoute>(path: AppRoutes.legal)
class LegalRoute extends GoRouteData with $LegalRoute {
  const LegalRoute({this.slug = 'about'});

  final String slug;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      LegalPlaceholderScreen(slug: slug);
}
