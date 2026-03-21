import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/app/router/app_routes_data.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_icon_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/features/health/domain/models/backend_health.dart';

class HomeHeaderBlock extends StatelessWidget {
  const HomeHeaderBlock({required this.backendHealth, super.key});

  static const double quickActionsOverlap = 76;

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: quickActionsOverlap),
          child: _HeroSection(backendHealth: backendHealth),
        ),
        const Positioned(
          left: 16,
          right: 16,
          bottom: 0,
          child: _QuickActions(),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.backendHealth});

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 64),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      context.t.homeWelcomeTitle,
                      variant: AppTextVariant.headlineMedium,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      context.t.homeWelcomeSubtitle,
                      variant: AppTextVariant.bodyMedium,
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                    const SizedBox(height: 12),
                    _BackendStatusPill(backendHealth: backendHealth),
                  ],
                ),
              ),
              AppIconButton(
                icon: Icons.settings_outlined,
                onPressed: () => const SettingsRoute().push(context),
                variant: AppIconButtonVariant.tonal,
                backgroundColor: Colors.white.withValues(alpha: 0.20),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ],
          ),
          const SizedBox(height: 28),
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => context.push(AppRoutes.search),
            child: Material(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFFD4D4D8)
                      : const Color(0xFFE5E7EB),
                  width: 1.2,
                ),
              ),
              shadowColor: Colors.black.withValues(alpha: isDark ? 0.18 : 0.10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.18 : 0.10,
                      ),
                      blurRadius: isDark ? 28 : 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textPrimaryLight,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppText(
                        context.t.homeSearchPlaceholder,
                        variant: AppTextVariant.bodyLarge,
                        color: AppColors.textPrimaryLight.withValues(
                          alpha: 0.78,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackendStatusPill extends StatelessWidget {
  const _BackendStatusPill({required this.backendHealth});

  final AsyncValue<BackendHealth> backendHealth;

  @override
  Widget build(BuildContext context) {
    final (icon, label, color) = backendHealth.when(
      data: (_) =>
          (Icons.cloud_done_rounded, 'Backend online', const Color(0xFF22C55E)),
      error: (_, _) => (
        Icons.cloud_off_rounded,
        'Backend unavailable',
        const Color(0xFFF97316),
      ),
      loading: () =>
          (Icons.sync_rounded, 'Checking backend', const Color(0xFFEAB308)),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final items = <_QuickActionModel>[
      _QuickActionModel(
        label: context.t.homeQuickSearch,
        icon: Icons.search_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.primary, AppColors.secondary],
        ),
        onTap: () => context.push(AppRoutes.search),
      ),
      _QuickActionModel(
        label: context.t.homeQuickHistory,
        icon: Icons.history_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.secondary, AppColors.tertiary],
        ),
        onTap: () => const HistoryRoute().go(context),
      ),
      _QuickActionModel(
        label: context.t.homeQuickUpload,
        icon: Icons.file_upload_outlined,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.tertiary, Color(0xFFF43F5E)],
        ),
        onTap: () => context.push(AppRoutes.upload),
      ),
    ];

    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: item == items.last ? 0 : 12),
                child: _QuickActionCard(item: item),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.item});

  final _QuickActionModel item;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      onTap: item.onTap,
      child: Column(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: item.gradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          AppText(
            item.label,
            variant: AppTextVariant.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuickActionModel {
  const _QuickActionModel({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
}
