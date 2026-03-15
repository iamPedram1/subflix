import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
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
              SectionHeader(
                title: context.t.settingsTitle,
                subtitle: context.t.settingsSubtitle,
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
                            context.t.settingsLanguageLabel,
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
                            context.t.settingsThemeLabel,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SegmentedButton<ThemePreference>(
                            segments: ThemePreference.values
                                .map(
                                  (preference) =>
                                      ButtonSegment<ThemePreference>(
                                        value: preference,
                                        label: Text(preference.label(context)),
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
                                      context.t.settingsPremiumTitle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    Text(
                                      context.t.settingsPremiumSubtitle,
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
                            title: context.t.settingsAboutTitle,
                            subtitle: context.t.settingsVersion('1.0.0+1'),
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'about'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.messageQuestion,
                            title: context.t.settingsSupportTitle,
                            subtitle: context.t.settingsSupportSubtitle,
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'support'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.book,
                            title: context.t.settingsPrivacyTitle,
                            subtitle: context.t.settingsPrivacySubtitle,
                            onTap: () => context.push(
                              AppRoutes.legal.replaceFirst(':slug', 'privacy'),
                            ),
                          ),
                          _SettingsTile(
                            icon: Iconsax.book,
                            title: context.t.settingsTermsTitle,
                            subtitle: context.t.settingsTermsSubtitle,
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
                            context.t.settingsMaintenanceTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            context.t.settingsMaintenanceSubtitle,
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
                                SnackBar(
                                  content: Text(
                                    context.t.settingsHistoryClearedSnack,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Iconsax.trash),
                            label: Text(context.t.settingsClearCache),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                error: (error, stackTrace) => StatePanel(
                  icon: Iconsax.warning2,
                  title: context.t.settingsFailedTitle,
                  message: error.toString(),
                  action: OutlinedButton.icon(
                    onPressed: () => ref.invalidate(settingsControllerProvider),
                    icon: const Icon(Iconsax.refresh),
                    label: Text(context.t.retry),
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
