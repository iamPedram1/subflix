import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
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
          child: ResponsiveCenter(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => context.go(AppRoutes.home),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.t.settingsTitle,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context.t.settingsSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondaryFor(context),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _ProfileCard(),
                const SizedBox(height: 16),
                settings.when(
                  data: (preference) => Column(
                    children: <Widget>[
                      _SectionTitle(title: context.t.settingsThemeLabel),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<ThemePreference>(
                            showSelectedIcon: false,
                            segments: ThemePreference.values
                                .map(
                                  (value) => ButtonSegment<ThemePreference>(
                                    value: value,
                                    label: Text(value.label(context)),
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(title: context.t.settingsLanguageLabel),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: AppLanguage.values
                              .where(
                                (language) =>
                                    AppLocalizations.supportedLocales.any(
                                      (locale) =>
                                          locale.languageCode == language.code,
                                    ),
                              )
                              .map(
                                (language) => ChoiceChip(
                                  selected:
                                      language ==
                                      preference.preferredTargetLanguage,
                                  label: Text(language.label),
                                  onSelected: (_) => ref
                                      .read(settingsControllerProvider.notifier)
                                      .setPreferredTargetLanguage(language),
                                ),
                              )
                              .toList(growable: false),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(title: context.t.settingsPremiumTitle),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: _SettingsRow(
                          icon: Icons.workspace_premium_rounded,
                          title: context.t.settingsPremiumTitle,
                          subtitle: context.t.settingsPremiumSubtitle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(title: context.t.settingsSupportTitle),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: Column(
                          children: <Widget>[
                            _SettingsRow(
                              icon: Icons.notifications_none_rounded,
                              title: context.t.settingsNotificationsTitle,
                              subtitle: context.t.settingsNotificationsSubtitle,
                            ),
                            const Divider(height: 24),
                            _SettingsRow(
                              icon: Icons.help_outline_rounded,
                              title: context.t.settingsHelpCenterTitle,
                              subtitle: context.t.settingsSupportSubtitle,
                              onTap: () => context.push(
                                AppRoutes.legal.replaceFirst(
                                  ':slug',
                                  'support',
                                ),
                              ),
                            ),
                            const Divider(height: 24),
                            _SettingsRow(
                              icon: Icons.mail_outline_rounded,
                              title: context.t.settingsContactTitle,
                              subtitle: context.t.settingsSupportSubtitle,
                              onTap: () => context.push(
                                AppRoutes.legal.replaceFirst(
                                  ':slug',
                                  'support',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(title: context.t.settingsAboutTitle),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: Column(
                          children: <Widget>[
                            _SettingsRow(
                              icon: Icons.info_outline_rounded,
                              title: context.t.settingsAboutTitle,
                              subtitle: context.t.settingsVersion('1.0.0+1'),
                              onTap: () => context.push(
                                AppRoutes.legal.replaceFirst(':slug', 'about'),
                              ),
                            ),
                            const Divider(height: 24),
                            _SettingsRow(
                              icon: Icons.shield_outlined,
                              title: context.t.settingsPrivacyTitle,
                              subtitle: context.t.settingsPrivacySubtitle,
                              onTap: () => context.push(
                                AppRoutes.legal.replaceFirst(
                                  ':slug',
                                  'privacy',
                                ),
                              ),
                            ),
                            const Divider(height: 24),
                            _SettingsRow(
                              icon: Icons.description_outlined,
                              title: context.t.settingsTermsTitle,
                              subtitle: context.t.settingsTermsSubtitle,
                              onTap: () => context.push(
                                AppRoutes.legal.replaceFirst(':slug', 'terms'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(title: context.t.settingsMaintenanceTitle),
                      const SizedBox(height: 10),
                      AppSurfaceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              context.t.settingsMaintenanceSubtitle,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondaryFor(context),
                                  ),
                            ),
                            const SizedBox(height: 14),
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
                              icon: const Icon(Icons.delete_outline_rounded),
                              label: Text(context.t.settingsClearCache),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  error: (error, stackTrace) => StatePanel(
                    icon: Icons.error_outline_rounded,
                    title: context.t.settingsFailedTitle,
                    message: '$error',
                    action: OutlinedButton.icon(
                      onPressed: () =>
                          ref.invalidate(settingsControllerProvider),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(context.t.retry),
                    ),
                  ),
                  loading: () => Column(
                    children: const <Widget>[
                      LoadingSkeleton(height: 160),
                      SizedBox(height: 12),
                      LoadingSkeleton(height: 140),
                      SizedBox(height: 12),
                      LoadingSkeleton(height: 140),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.cardLarge,
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.t.settingsProfileName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  context.t.settingsProfileTier,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppColors.textSecondaryFor(context),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondaryDark,
            ),
        ],
      ),
    );
  }
}
