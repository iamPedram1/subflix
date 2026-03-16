import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/subflix_wordmark.dart';
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

  @override
  void initState() {
    super.initState();
    _settingsSubscription = ref.listenManual<AsyncValue<UserPreference>>(
      settingsControllerProvider,
      (_, next) => next.whenData(_routeFromPreference),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsControllerProvider).whenData(_routeFromPreference);
    });
  }

  void _routeFromPreference(UserPreference preference) {
    if (!mounted) {
      return;
    }

    context.go(
      preference.hasSeenOnboarding ? AppRoutes.home : AppRoutes.onboarding,
    );
  }

  @override
  void dispose() {
    _settingsSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: Center(
              child: Padding(
                padding: AppInsets.cardLarge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24,
                  children: <Widget>[
                    const SubflixWordmark(),
                    Text(
                      context.t.splashPreparing,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                    const LoadingSkeleton(width: 220, height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
