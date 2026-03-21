import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final ProviderSubscription<AsyncValue<UserPreference>>
  _settingsSubscription;
  Timer? _navigationTimer;
  Timer? _guardTimer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _settingsSubscription = ref.listenManual<AsyncValue<UserPreference>>(
      settingsControllerProvider,
      (_, next) {
        next.whenOrNull(
          data: _routeFromPreference,
          error: (_, stackTrace) => _routeToFallback(),
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(settingsControllerProvider)
          .whenOrNull(
            data: _routeFromPreference,
            error: (_, stackTrace) => _routeToFallback(),
          );
    });

    _guardTimer = Timer(const Duration(seconds: 6), _routeToFallback);
  }

  void _routeFromPreference(UserPreference preference) {
    _scheduleNavigation(
      preference.hasSeenOnboarding ? AppRoutes.home : AppRoutes.onboarding,
    );
  }

  void _routeToFallback() {
    _scheduleNavigation(
      AppRoutes.onboarding,
      delay: const Duration(milliseconds: 250),
    );
  }

  void _scheduleNavigation(String location, {Duration? delay}) {
    if (!mounted || _hasNavigated) {
      return;
    }

    _guardTimer?.cancel();
    _navigationTimer?.cancel();
    _navigationTimer = Timer(delay ?? const Duration(milliseconds: 2200), () {
      if (!mounted || _hasNavigated) {
        return;
      }
      _hasNavigated = true;
      context.go(location);
    });
  }

  @override
  void dispose() {
    _guardTimer?.cancel();
    _navigationTimer?.cancel();
    _settingsSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF0A0A0A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const _ParticleField(),
            SafeArea(
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: <Widget>[
                      Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.accentGradient,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.45,
                                  ),
                                  blurRadius: 36,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.movie_creation_outlined,
                              size: 54,
                              color: Colors.white,
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .rotate(duration: 20.seconds),
                      const SizedBox(height: 28),
                      AppText(
                            context.t.splashHeadline,
                            variant: AppTextVariant.displayMedium,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )
                          .animate()
                          .fadeIn(duration: 450.ms)
                          .moveY(begin: 12, end: 0),
                      const SizedBox(height: 8),
                      AppText(
                        context.t.brandSubtitleFull,
                        variant: AppTextVariant.bodyLarge,
                        textAlign: TextAlign.center,
                        color: Colors.white.withValues(alpha: 0.68),
                        letterSpacing: 1.2,
                      ).animate().fadeIn(delay: 200.ms, duration: 450.ms),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            3,
                            (index) =>
                                Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF818CF8),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                    .animate(
                                      delay: Duration(
                                        milliseconds: index * 180,
                                      ),
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .scaleXY(
                                      begin: 1,
                                      end: 1.5,
                                      duration: 900.ms,
                                    )
                                    .then()
                                    .scaleXY(
                                      begin: 1.5,
                                      end: 1,
                                      duration: 900.ms,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        AppText(
                          context.t.splashPreparing,
                          variant: AppTextVariant.bodyMedium,
                          color: Colors.white.withValues(alpha: 0.62),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParticleField extends StatelessWidget {
  const _ParticleField();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: List<Widget>.generate(18, (index) {
          final top = (index * 37.0) % 700;
          final left = (index * 53.0) % 360;
          return Positioned(
            top: top,
            left: left,
            child:
                Container(
                      width: index.isEven ? 4 : 6,
                      height: index.isEven ? 4 : 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(
                      delay: Duration(milliseconds: 120 * index),
                      onPlay: (controller) => controller.repeat(),
                    )
                    .fadeIn(duration: 900.ms)
                    .moveY(begin: -12, end: 24, duration: 2800.ms)
                    .fadeOut(delay: 1800.ms, duration: 900.ms),
          );
        }),
      ),
    );
  }
}
