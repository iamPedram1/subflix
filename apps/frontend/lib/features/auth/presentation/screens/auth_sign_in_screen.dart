import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/auth/application/auth_controller.dart';
import 'package:subflix/features/auth/data/services/firebase_oauth_service.dart';
import 'package:subflix/features/auth/presentation/widgets/auth_flow_scaffold.dart';

class AuthSignInScreen extends ConsumerStatefulWidget {
  const AuthSignInScreen({super.key});

  @override
  ConsumerState<AuthSignInScreen> createState() => _AuthSignInScreenState();
}

class _AuthSignInScreenState extends ConsumerState<AuthSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSubmitting = false;
  bool _isGoogleSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            context.t.authSignInSuccess,
            variant: AppTextVariant.bodyMedium,
          ),
        ),
      );
      context.go(AppRoutes.settings);
    } catch (error) {
      setState(() => _errorMessage = describeAuthError(error));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isGoogleSubmitting = true;
      _errorMessage = null;
    });

    try {
      final idToken = await ref
          .read(firebaseOAuthServiceProvider)
          .signInWithGoogleIdToken();
      await ref
          .read(authControllerProvider.notifier)
          .signInWithFirebase(idToken);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            context.t.authSignInSuccess,
            variant: AppTextVariant.bodyMedium,
          ),
        ),
      );
      context.go(AppRoutes.settings);
    } on FirebaseOAuthCancelledException {
      return;
    } catch (error) {
      setState(() => _errorMessage = describeAuthError(error));
    } finally {
      if (mounted) {
        setState(() => _isGoogleSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(authControllerProvider).asData?.value;

    return AuthFlowScaffold(
      icon: Icons.lock_open_rounded,
      eyebrow: context.t.authEyebrow,
      title: context.t.authSignInTitle,
      subtitle: context.t.authSignInSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (session != null) ...<Widget>[
            StatePanel(
              icon: Icons.verified_user_rounded,
              title: context.t.authAlreadySignedInTitle,
              message: context.t.authAlreadySignedInMessage(session.user.email),
              action: OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.settings),
                icon: const Icon(Icons.settings_rounded),
                label: AppText(
                  context.t.authBackToAccount,
                  variant: AppTextVariant.labelLarge,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_errorMessage != null) ...<Widget>[
            StatePanel(
              icon: Icons.error_outline_rounded,
              title: context.t.translationFailedTitle,
              message: _errorMessage!,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.t.authEmailLabel,
                    hintText: 'name@example.com',
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return context.t.authFieldRequired;
                    }
                    if (!isLikelyEmail(email)) {
                      return context.t.authInvalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleSignIn(),
                  decoration: InputDecoration(
                    labelText: context.t.authPasswordLabel,
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return context.t.authFieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                AppGradientButton(
                  label: context.t.authSignInAction,
                  icon: Icons.login_rounded,
                  onPressed: _isSubmitting || _isGoogleSubmitting
                      ? null
                      : _handleSignIn,
                  fullWidth: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _isSubmitting || _isGoogleSubmitting
                  ? null
                  : _handleGoogleSignIn,
              icon: _isGoogleSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.g_mobiledata_rounded, size: 26),
              label: AppText(
                context.t.authContinueWithGoogle,
                variant: AppTextVariant.labelLarge,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppText(
            context.t.authGoogleHelper,
            variant: AppTextVariant.bodySmall,
            color: AppColors.textSecondaryFor(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: AppText(
                  context.t.authOrDivider,
                  variant: AppTextVariant.labelMedium,
                  color: AppColors.textSecondaryFor(context),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: _isSubmitting || _isGoogleSubmitting
                ? null
                : () => context.push(AppRoutes.authForgotPassword),
            child: AppText(
              context.t.authForgotPasswordLink,
              variant: AppTextVariant.labelLarge,
            ),
          ),
          TextButton(
            onPressed: _isSubmitting || _isGoogleSubmitting
                ? null
                : () => context.push(AppRoutes.authSignUp),
            child: AppText(
              context.t.authNoAccountLink,
              variant: AppTextVariant.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
