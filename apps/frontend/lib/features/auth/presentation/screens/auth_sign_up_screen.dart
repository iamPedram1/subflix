import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/auth/application/auth_controller.dart';
import 'package:subflix/features/auth/presentation/models/auth_confirm_email_args.dart';
import 'package:subflix/features/auth/presentation/widgets/auth_flow_scaffold.dart';

class AuthSignUpScreen extends ConsumerStatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  ConsumerState<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends ConsumerState<AuthSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final result = await ref
          .read(authControllerProvider.notifier)
          .signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _displayNameController.text.trim().isEmpty
                ? null
                : _displayNameController.text.trim(),
          );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            context.t.authSignUpSuccess,
            variant: AppTextVariant.bodyMedium,
          ),
        ),
      );
      if (result.verificationRequired) {
        context.go(
          AppRoutes.authConfirmEmail,
          extra: AuthConfirmEmailArgs(
            email: result.user.email,
            token: result.verificationToken,
          ),
        );
        return;
      }
      context.go(AppRoutes.authSignIn);
    } catch (error) {
      setState(() => _errorMessage = describeAuthError(error));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthFlowScaffold(
      icon: Icons.person_add_alt_1_rounded,
      eyebrow: context.t.authEyebrow,
      title: context.t.authSignUpTitle,
      subtitle: context.t.authSignUpSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                  controller: _displayNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.t.authDisplayNameLabel,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.t.authPasswordLabel,
                  ),
                  validator: (value) {
                    final password = value ?? '';
                    if (password.isEmpty) {
                      return context.t.authFieldRequired;
                    }
                    if (password.length < 8) {
                      return context.t.authPasswordTooShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleSignUp(),
                  decoration: InputDecoration(
                    labelText: context.t.authConfirmPasswordLabel,
                  ),
                  validator: (value) {
                    final confirmed = value ?? '';
                    if (confirmed.isEmpty) {
                      return context.t.authFieldRequired;
                    }
                    if (confirmed != _passwordController.text) {
                      return context.t.authPasswordMismatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                AppGradientButton(
                  label: context.t.authSignUpAction,
                  icon: Icons.arrow_forward_rounded,
                  mirrorIconInRtl: true,
                  onPressed: _isSubmitting ? null : _handleSignUp,
                  fullWidth: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: _isSubmitting
                ? null
                : () => context.push(AppRoutes.authSignIn),
            child: AppText(
              context.t.authHaveAccountLink,
              variant: AppTextVariant.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
