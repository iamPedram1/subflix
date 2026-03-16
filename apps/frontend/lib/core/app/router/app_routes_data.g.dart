// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $homeShellRoute,
  $searchRoute,
  $subtitleSourcesRoute,
  $seriesSeasonsRoute,
  $seriesEpisodesRoute,
  $translationSetupRoute,
  $translationProgressRoute,
  $translationPreviewRoute,
  $uploadRoute,
  $legalRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/splash', factory: $SplashRoute._fromState);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/splash');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShellRoute => StatefulShellRouteData.$route(
  factory: $HomeShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/history', factory: $HistoryRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          factory: $SettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HistoryRoute on GoRouteData {
  static HistoryRoute _fromState(GoRouterState state) => const HistoryRoute();

  @override
  String get location => GoRouteData.$location('/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute =>
    GoRouteData.$route(path: '/search', factory: $SearchRoute._fromState);

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $subtitleSourcesRoute => GoRouteData.$route(
  path: '/search/sources',
  factory: $SubtitleSourcesRoute._fromState,
);

mixin $SubtitleSourcesRoute on GoRouteData {
  static SubtitleSourcesRoute _fromState(GoRouterState state) =>
      const SubtitleSourcesRoute();

  @override
  String get location => GoRouteData.$location('/search/sources');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $seriesSeasonsRoute => GoRouteData.$route(
  path: '/search/series/seasons',
  factory: $SeriesSeasonsRoute._fromState,
);

mixin $SeriesSeasonsRoute on GoRouteData {
  static SeriesSeasonsRoute _fromState(GoRouterState state) =>
      const SeriesSeasonsRoute();

  @override
  String get location => GoRouteData.$location('/search/series/seasons');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $seriesEpisodesRoute => GoRouteData.$route(
  path: '/search/series/episodes',
  factory: $SeriesEpisodesRoute._fromState,
);

mixin $SeriesEpisodesRoute on GoRouteData {
  static SeriesEpisodesRoute _fromState(GoRouterState state) =>
      const SeriesEpisodesRoute();

  @override
  String get location => GoRouteData.$location('/search/series/episodes');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $translationSetupRoute => GoRouteData.$route(
  path: '/translate/setup',
  factory: $TranslationSetupRoute._fromState,
);

mixin $TranslationSetupRoute on GoRouteData {
  static TranslationSetupRoute _fromState(GoRouterState state) =>
      const TranslationSetupRoute();

  @override
  String get location => GoRouteData.$location('/translate/setup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $translationProgressRoute => GoRouteData.$route(
  path: '/translate/progress',
  factory: $TranslationProgressRoute._fromState,
);

mixin $TranslationProgressRoute on GoRouteData {
  static TranslationProgressRoute _fromState(GoRouterState state) =>
      const TranslationProgressRoute();

  @override
  String get location => GoRouteData.$location('/translate/progress');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $translationPreviewRoute => GoRouteData.$route(
  path: '/translate/preview/:jobId',
  factory: $TranslationPreviewRoute._fromState,
);

mixin $TranslationPreviewRoute on GoRouteData {
  static TranslationPreviewRoute _fromState(GoRouterState state) =>
      TranslationPreviewRoute(jobId: state.pathParameters['jobId']!);

  TranslationPreviewRoute get _self => this as TranslationPreviewRoute;

  @override
  String get location => GoRouteData.$location(
    '/translate/preview/${Uri.encodeComponent(_self.jobId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $uploadRoute =>
    GoRouteData.$route(path: '/upload', factory: $UploadRoute._fromState);

mixin $UploadRoute on GoRouteData {
  static UploadRoute _fromState(GoRouterState state) => const UploadRoute();

  @override
  String get location => GoRouteData.$location('/upload');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $legalRoute =>
    GoRouteData.$route(path: '/legal/:slug', factory: $LegalRoute._fromState);

mixin $LegalRoute on GoRouteData {
  static LegalRoute _fromState(GoRouterState state) =>
      LegalRoute(slug: state.pathParameters['slug'] ?? 'about');

  LegalRoute get _self => this as LegalRoute;

  @override
  String get location =>
      GoRouteData.$location('/legal/${Uri.encodeComponent(_self.slug)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
