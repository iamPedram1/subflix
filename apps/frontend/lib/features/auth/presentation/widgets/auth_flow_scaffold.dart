import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/network/api_exception.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/features/auth/data/services/firebase_oauth_service.dart';

class AuthFlowScaffold extends StatelessWidget {
  const AuthFlowScaffold({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
    this.eyebrow,
    this.footer,
    this.onBack,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;
  final String? eyebrow;
  final Widget? footer;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: AppInsets.page,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed:
                          onBack ??
                          () {
                            if (context.canPop()) {
                              context.pop();
                              return;
                            }
                            context.go(AppRoutes.settings);
                          },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: AppInsets.cardXL,
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (eyebrow != null) ...<Widget>[
                        AppText(
                          eyebrow!,
                          variant: AppTextVariant.labelLarge,
                          color: Colors.white.withValues(alpha: 0.82),
                          letterSpacing: 0.6,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(icon, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppText(
                        title,
                        variant: AppTextVariant.headlineMedium,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppText(
                        subtitle,
                        variant: AppTextVariant.bodyMedium,
                        color: Colors.white.withValues(alpha: 0.84),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSurfaceCard(child: child),
                if (footer != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  footer!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String describeAuthError(Object error) {
  return switch (error) {
    ApiException() => error.message,
    FirebaseOAuthException() => error.message,
    _ => 'Something went wrong. Please try again.',
  };
}

bool isLikelyEmail(String value) {
  final normalized = value.trim();
  if (normalized.isEmpty) {
    return false;
  }
  return RegExp(
    r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$',
    caseSensitive: false,
  ).hasMatch(normalized);
}
