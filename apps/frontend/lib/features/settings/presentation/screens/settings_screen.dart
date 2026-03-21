import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/auth/application/auth_controller.dart';
import 'package:subflix/features/auth/data/services/firebase_oauth_service.dart';
import 'package:subflix/features/auth/presentation/models/auth_confirm_email_args.dart';
import 'package:subflix/features/auth/presentation/widgets/auth_flow_scaffold.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';
import 'package:subflix/features/settings/presentation/widgets/settings_presentational.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/shared/domain/models/theme_preference.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
    try {
      final idToken = await ref
          .read(firebaseOAuthServiceProvider)
          .signInWithGoogleIdToken();
      await ref
          .read(authControllerProvider.notifier)
          .signInWithFirebase(idToken);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.authSignInSuccess)));
    } on FirebaseOAuthCancelledException {
      return;
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeAuthError(error))));
    }
  }

  Future<void> _handleRefreshProfile(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      await ref.read(authControllerProvider.notifier).refreshProfile();
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.authProfileRefreshed)));
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeAuthError(error))));
    }
  }

  Future<void> _handleSignOut(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authControllerProvider.notifier).signOut();
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.authSignOutSuccess)));
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeAuthError(error))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final authState = ref.watch(authControllerProvider);

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
                        SettingsProfileCard(
                          preference: preference,
                          authState: authState,
                          onSignIn: () => context.push(AppRoutes.authSignIn),
                          onSignUp: () => context.push(AppRoutes.authSignUp),
                          onGoogleSignIn: () =>
                              _handleGoogleSignIn(context, ref),
                          onSignOut: () => _handleSignOut(context, ref),
                        ),
                        if (authState.asData?.value
                            case final session?) ...<Widget>[
                          const SizedBox(height: 24),
                          SettingsSectionTitle(
                            title: context.t.authAccountSectionTitle,
                          ),
                          const SizedBox(height: 12),
                          AppSurfaceCard(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: <Widget>[
                                SettingsActionRow(
                                  icon: Icons.alternate_email_rounded,
                                  title: context.t.authEmailLabel,
                                  value: session.user.email,
                                ),
                                const SettingsDividerLine(),
                                SettingsActionRow(
                                  icon: session.user.emailVerified
                                      ? Icons.verified_rounded
                                      : Icons.mark_email_unread_outlined,
                                  title: context.t.authVerificationStatusTitle,
                                  value: session.user.emailVerified
                                      ? context.t.authVerifiedStatus
                                      : context.t.authUnverifiedStatus,
                                  onTap: session.user.emailVerified
                                      ? null
                                      : () => context.push(
                                          AppRoutes.authConfirmEmail,
                                          extra: AuthConfirmEmailArgs(
                                            email: session.user.email,
                                          ),
                                        ),
                                ),
                                const SettingsDividerLine(),
                                SettingsActionRow(
                                  icon: Icons.refresh_rounded,
                                  title: context.t.authRefreshProfileAction,
                                  subtitle:
                                      context.t.authRefreshProfileSubtitle,
                                  onTap: () =>
                                      _handleRefreshProfile(context, ref),
                                ),
                                const SettingsDividerLine(),
                                SettingsActionRow(
                                  icon: Icons.logout_rounded,
                                  title: context.t.authSignOutAction,
                                  subtitle: context.t.authSignOutSubtitle,
                                  onTap: () => _handleSignOut(context, ref),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        SettingsSectionTitle(
                          title: context.t.settingsThemeLabel,
                        ),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: SettingsActionRow(
                            icon: _resolvedThemeIcon(context, preference),
                            title: 'Theme',
                            subtitle: _resolvedThemeLabel(context, preference),
                            trailing: SettingsThemeToggle(
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
                        const SettingsSectionTitle(title: 'Preferences'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              SettingsActionRow(
                                icon: Icons.language_rounded,
                                title: 'App Language',
                                value: preference.preferredTargetLanguage.label,
                                onTap: () => _showLanguagePicker(
                                  context,
                                  ref,
                                  preference,
                                ),
                              ),
                              const SettingsDividerLine(),
                              SettingsActionRow(
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
                        const SettingsSectionTitle(title: 'Support'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              SettingsActionRow(
                                icon: Icons.help_outline_rounded,
                                title: context.t.settingsHelpCenterTitle,
                                onTap: () => context.push(
                                  AppRoutes.legal.replaceFirst(
                                    ':slug',
                                    'support',
                                  ),
                                ),
                              ),
                              const SettingsDividerLine(),
                              SettingsActionRow(
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
                        const SettingsSectionTitle(title: 'About'),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: <Widget>[
                              const SettingsActionRow(
                                icon: Icons.info_outline_rounded,
                                title: 'App Version',
                                value: '1.0.0',
                              ),
                              const SettingsDividerLine(),
                              SettingsActionRow(
                                icon: Icons.privacy_tip_outlined,
                                title: context.t.settingsPrivacyTitle,
                                onTap: () => context.push(
                                  AppRoutes.legal.replaceFirst(
                                    ':slug',
                                    'privacy',
                                  ),
                                ),
                              ),
                              const SettingsDividerLine(),
                              SettingsActionRow(
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
                        SettingsSectionTitle(
                          title: context.t.settingsMaintenanceTitle,
                        ),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: EdgeInsets.zero,
                          child: SettingsActionRow(
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
                        const SettingsFooter(),
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
                                      : AppColors.surfaceMutedFor(sheetContext),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.primary
                                        : Theme.of(sheetContext)
                                              .colorScheme
                                              .outline
                                              .withValues(alpha: 0.4),
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
