import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            children: <Widget>[
              const SectionHeader(
                title: 'Settings',
                subtitle:
                    'Manage subtitle defaults, appearance, app information, and placeholder premium controls.',
              ),
              const SizedBox(height: 16),
              settings.when(
                data: (preference) => Column(
                  spacing: 16,
                  children: <Widget>[
                    AppSurfaceCard(
                      child: Column(
                        spacing: 14,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Preferred target language',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: AppLanguage.values
                                .map(
                                  (language) => ChoiceChip(
                                    selected:
                                        language ==
                                        preference.preferredTargetLanguage,
                                    label: Text(language.label),
                                    onSelected: (_) => ref
                                        .read(
                                          settingsControllerProvider.notifier,
                                        )
                                        .setPreferredTargetLanguage(language),
                                  ),
                                )
                                .toList(growable: false),
                          ),
                        ],
                      ),
                    ),
                    AppSurfaceCard(
                      child: Column(
                        spacing: 14,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Appearance',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SegmentedButton<ThemePreference>(
                            segments: ThemePreference.values
                                .map(
                                  (preference) =>
                                      ButtonSegment<ThemePreference>(
                                        value: preference,
                                        label: Text(preference.label),
                                      ),
                                )
                                .toList(growable: false),
                            selected: <ThemePreference>{
                              preference.themePreference,
                            },
                            onSelectionChanged: (selection) => ref
                                .read(settingsControllerProvider.notifier)
                                .setThemePreference(selection.first),
                          ),
                        ],
                      ),
                    ),
                    AppSurfaceCard(
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            spacing: 10,
                            children: <Widget>[
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.16,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Iconsax.crown,
                                  color: AppColors.secondary,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Premium placeholder',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    Text(
                                      'Later we can connect subscriptions, billing, and cloud project sync here.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppSurfaceCard(
                      child: Column(
                        spacing: 8,
                        children: <Widget>[
                          _SettingsTile(
                            icon: Iconsax.infoCircle,
                            title: 'About SubFlix',
                            subtitle: 'Version 1.0.0+1',
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'about'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.messageQuestion,
                            title: 'Support placeholder',
                            subtitle: 'Mock help and contact page',
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'support'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.book,
                            title: 'Privacy policy',
                            subtitle: 'Mock privacy content',
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'privacy'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.book,
                            title: 'Terms of service',
                            subtitle: 'Mock terms content',
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'terms'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSurfaceCard(
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Maintenance',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Clear backend-owned translation jobs for this device and start with an empty history state.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(historyControllerProvider.notifier)
                                  .clear();
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Translation history cleared for this device',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Iconsax.trash),
                            label: const Text('Clear cache'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                error: (error, stackTrace) => StatePanel(
                  icon: Iconsax.warning2,
                  title: 'Settings failed to load',
                  message: error.toString(),
                  action: OutlinedButton.icon(
                    onPressed: () => ref.invalidate(settingsControllerProvider),
                    icon: const Icon(Iconsax.refresh),
                    label: const Text('Retry'),
                  ),
                ),
                loading: () => Column(
                  spacing: 14,
                  children: const <Widget>[
                    LoadingSkeleton(height: 140),
                    LoadingSkeleton(height: 120),
                    LoadingSkeleton(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Iconsax.arrowRight),
      onTap: onTap,
    );
  }
}
