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
import 'package:subflix/features/settings/domain/models/user_preference.dart';
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
            child: settings.when(
              data: (preference) => CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.92),
                    titleSpacing: 0,
                    leading: IconButton(
                      onPressed: () => context.go(AppRoutes.home),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.t.settingsTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          context.t.settingsSubtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondaryFor(context),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                    sliver: SliverList.list(
                      children: <Widget>[
                        _ProfileCard(preference: preference),
                        const SizedBox(height: 24),
                        _SectionTitle(title: context.t.settingsThemeLabel),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: _SettingsActionRow(
                            icon: _resolvedThemeIcon(context, preference),
                            title: 'Theme',
                            subtitle: _resolvedThemeLabel(context, preference),
                            trailing: _ThemeToggle(
                              enabled: _isDarkThemeEnabled(context, preference),
                            ),
                            onTap: () {
                              final nextTheme =
                                  _isDarkThemeEnabled(context, preference)
                                  ? ThemePreference.light
                                  : ThemePreference.dark;
                              ref
                                  .read(settingsControllerProvider.notifier)
                                  .setThemePreference(nextTheme);
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle(title: 'Preferences'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              _SettingsActionRow(
                                icon: Icons.language_rounded,
                                title: 'App Language',
                                value: preference.preferredTargetLanguage.label,
                                onTap: () => _showLanguagePicker(
                                  context,
                                  ref,
                                  preference,
                                ),
                              ),
                              _DividerLine(),
                              _SettingsActionRow(
                                icon: Icons.notifications_none_rounded,
                                title: context.t.settingsNotificationsTitle,
                                subtitle:
                                    context.t.settingsNotificationsSubtitle,
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.t.settingsNotificationsSubtitle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle(title: 'Support'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              _SettingsActionRow(
                                icon: Icons.help_outline_rounded,
                                title: context.t.settingsHelpCenterTitle,
                                onTap: () => context.push(
                                  AppRoutes.legal.replaceFirst(
                                    ':slug',
                                    'support',
                                  ),
                                ),
                              ),
                              _DividerLine(),
                              _SettingsActionRow(
                                icon: Icons.mail_outline_rounded,
                                title: context.t.settingsContactTitle,
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
                        const SizedBox(height: 24),
                        _SectionTitle(title: 'About'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              _SettingsActionRow(
                                icon: Icons.info_outline_rounded,
                                title: 'App Version',
                                value: '1.0.0',
                              ),
                              _DividerLine(),
                              _SettingsActionRow(
                                icon: Icons.privacy_tip_outlined,
                                title: context.t.settingsPrivacyTitle,
                                onTap: () => context.push(
                                  AppRoutes.legal.replaceFirst(
                                    ':slug',
                                    'privacy',
                                  ),
                                ),
                              ),
                              _DividerLine(),
                              _SettingsActionRow(
                                icon: Icons.description_outlined,
                                title: context.t.settingsTermsTitle,
                                onTap: () => context.push(
                                  AppRoutes.legal.replaceFirst(
                                    ':slug',
                                    'terms',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle(
                          title: context.t.settingsMaintenanceTitle,
                        ),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: _SettingsActionRow(
                            icon: Icons.delete_outline_rounded,
                            title: context.t.settingsClearCache,
                            subtitle: context.t.settingsMaintenanceSubtitle,
                            onTap: () async {
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
                          ),
                        ),
                        const SizedBox(height: 32),
                        const _SettingsFooter(),
                      ],
                    ),
                  ),
                ],
              ),
              error: (error, stackTrace) => _ErrorState(
                error: error,
                onRetry: () => ref.invalidate(settingsControllerProvider),
              ),
              loading: () => const _LoadingState(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    UserPreference preference,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final languages = AppLanguage.values
            .where(
              (language) => AppLocalizations.supportedLocales.any(
                (locale) => locale.languageCode == language.code,
              ),
            )
            .toList(growable: false);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.t.settingsLanguageLabel,
                  style: Theme.of(
                    sheetContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  context.t.settingsSubtitle,
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(sheetContext),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List<Widget>.generate(languages.length, (
                        index,
                      ) {
                        final language = languages[index];
                        final selected =
                            language == preference.preferredTargetLanguage;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == languages.length - 1 ? 0 : 8,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                await ref
                                    .read(settingsControllerProvider.notifier)
                                    .setPreferredTargetLanguage(language);
                                if (sheetContext.mounted) {
                                  Navigator.of(sheetContext).pop();
                                }
                              },
                              child: Ink(
                                padding: AppInsets.card,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.primary.withValues(
                                          alpha: 0.10,
                                        )
                                      : AppColors.surfaceMutedFor(
                                          sheetContext,
                                        ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.primary
                                        : Theme.of(
                                            sheetContext,
                                          ).colorScheme.outline.withValues(
                                            alpha: 0.4,
                                          ),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            language.label,
                                            style: Theme.of(
                                              sheetContext,
                                            ).textTheme.titleMedium,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            language.nativeLabel,
                                            style: Theme.of(sheetContext)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color:
                                                      AppColors.textSecondaryFor(
                                                        sheetContext,
                                                      ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (selected)
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColors.primary,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.preference});

  final UserPreference preference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.white.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text('👤', style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.t.settingsProfileName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.t.settingsProfileTier,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        preference.preferredTargetLanguage.label,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondaryFor(context),
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsActionRow extends StatelessWidget {
  const _SettingsActionRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final rowChild = Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ] else if (value != null) ...<Widget>[
                const SizedBox(height: 2),
                Text(
                  value!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null)
          trailing!
        else if (onTap != null)
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondaryFor(context),
          )
        else if (value != null)
          Text(
            value!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryFor(context),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: rowChild,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 50,
      height: 28,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: enabled ? AppColors.primary : AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Align(
        alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _SettingsFooter extends StatelessWidget {
  const _SettingsFooter();

  @override
  Widget build(BuildContext context) {
    final shader = AppColors.heroGradient.createShader(
      const Rect.fromLTWH(0, 0, 180, 40),
    );

    return Column(
      children: <Widget>[
        Text(
          context.t.appTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            foreground: Paint()..shader = shader,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          context.t.brandSubtitleFull,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondaryFor(context),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          context.t.settingsVersion('1.0.0'),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.textSecondaryFor(context),
          ),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: const <Widget>[
        LoadingSkeleton(height: 88),
        SizedBox(height: 16),
        LoadingSkeleton(height: 132),
        SizedBox(height: 16),
        LoadingSkeleton(height: 156),
        SizedBox(height: 16),
        LoadingSkeleton(height: 132),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StatePanel(
          icon: Icons.error_outline_rounded,
          title: context.t.settingsFailedTitle,
          message: '$error',
          action: OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.t.retry),
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 70,
      endIndent: 16,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.35),
    );
  }
}

bool _isDarkThemeEnabled(BuildContext context, UserPreference preference) {
  final brightness = Theme.of(context).brightness;
  return switch (preference.themePreference) {
    ThemePreference.dark => true,
    ThemePreference.light => false,
    ThemePreference.system => brightness == Brightness.dark,
  };
}

String _resolvedThemeLabel(BuildContext context, UserPreference preference) {
  return _isDarkThemeEnabled(context, preference)
      ? context.t.themeDark
      : context.t.themeLight;
}

IconData _resolvedThemeIcon(BuildContext context, UserPreference preference) {
  return _isDarkThemeEnabled(context, preference)
      ? Icons.dark_mode_outlined
      : Icons.wb_sunny_outlined;
}
