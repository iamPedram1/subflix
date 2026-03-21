import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/features/auth/domain/models/auth_session.dart';
import 'package:subflix/features/settings/domain/models/user_preference.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({
    required this.preference,
    required this.authState,
    required this.onSignIn,
    required this.onSignUp,
    required this.onGoogleSignIn,
    required this.onSignOut,
    super.key,
  });

  final UserPreference preference;
  final AsyncValue<AuthSession?> authState;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;
  final Future<void> Function() onGoogleSignIn;
  final Future<void> Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    final session = authState.asData?.value;
    final isSignedIn = session != null;
    final displayName = session?.user.displayName?.trim().isNotEmpty == true
        ? session!.user.displayName!.trim()
        : session?.user.email;
    final subtitle = isSignedIn
        ? context.t.authSignedInCardSubtitle(session.user.email)
        : context.t.authSignedOutCardSubtitle;
    final badgeLabel = isSignedIn
        ? (session.user.emailVerified
              ? context.t.authVerifiedStatus
              : context.t.authUnverifiedStatus)
        : preference.preferredTargetLanguage.label;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.person_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  isSignedIn
                      ? (displayName ?? context.t.settingsProfileName)
                      : context.t.authSignedOutCardTitle,
                  variant: AppTextVariant.titleLarge,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 4),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodyMedium,
                  color: Colors.white.withValues(alpha: 0.82),
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
                  child: AppText(
                    badgeLabel,
                    variant: AppTextVariant.labelMedium,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                if (authState.isLoading)
                  const LoadingSkeleton(height: 54)
                else if (isSignedIn) ...<Widget>[
                  AppButton(
                    label: context.t.authSignOutAction,
                    onPressed: () => onSignOut(),
                    variant: AppButtonVariant.outlined,
                    leadingIcon: Icons.logout_rounded,
                    fullWidth: true,
                    foregroundColor: Colors.white,
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.24),
                    ),
                  ),
                ] else ...<Widget>[
                  AppButton(
                    label: context.t.authSignInAction,
                    onPressed: onSignIn,
                    variant: AppButtonVariant.gradient,
                    leadingIcon: Icons.login_rounded,
                    fullWidth: true,
                    gradient: const LinearGradient(
                      colors: <Color>[Colors.white, Colors.white],
                    ),
                    foregroundColor: AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AppButton(
                          label: context.t.authCreateAccountAction,
                          onPressed: onSignUp,
                          variant: AppButtonVariant.outlined,
                          foregroundColor: Colors.white,
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          label: context.t.authGoogleShortAction,
                          onPressed: () => onGoogleSignIn(),
                          variant: AppButtonVariant.outlined,
                          leadingIcon: Icons.g_mobiledata_rounded,
                          foregroundColor: Colors.white,
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: AppText(
        title.toUpperCase(),
        variant: AppTextVariant.labelMedium,
        color: AppColors.textSecondaryFor(context),
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

class SettingsActionRow extends StatelessWidget {
  const SettingsActionRow({
    required this.icon,
    required this.title,
    super.key,
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
              AppText(
                title,
                variant: AppTextVariant.titleMedium,
                fontWeight: FontWeight.w600,
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 2),
                AppText(
                  subtitle!,
                  variant: AppTextVariant.bodySmall,
                  color: AppColors.textSecondaryFor(context),
                ),
              ] else if (value != null) ...<Widget>[
                const SizedBox(height: 2),
                AppText(
                  value!,
                  variant: AppTextVariant.bodySmall,
                  color: AppColors.textSecondaryFor(context),
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
          AppText(
            value!,
            variant: AppTextVariant.bodyMedium,
            color: AppColors.textSecondaryFor(context),
            fontWeight: FontWeight.w500,
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

class SettingsThemeToggle extends StatelessWidget {
  const SettingsThemeToggle({required this.enabled, super.key});

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

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final shader = AppColors.heroGradient.createShader(
      const Rect.fromLTWH(0, 0, 180, 40),
    );

    return Column(
      children: <Widget>[
        AppText(
          context.t.appTitle,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w800,
          style: TextStyle(foreground: Paint()..shader = shader),
        ),
        const SizedBox(height: 6),
        AppText(
          context.t.brandSubtitleFull,
          variant: AppTextVariant.bodySmall,
          textAlign: TextAlign.center,
          color: AppColors.textSecondaryFor(context),
        ),
        const SizedBox(height: 14),
        AppText(
          context.t.settingsVersion('1.0.0'),
          variant: AppTextVariant.labelMedium,
          color: AppColors.textSecondaryFor(context),
        ),
      ],
    );
  }
}

class SettingsDividerLine extends StatelessWidget {
  const SettingsDividerLine({super.key});

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
