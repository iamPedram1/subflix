import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/auth/application/auth_controller.dart';
import 'package:subflix/features/auth/presentation/models/auth_reset_password_args.dart';
import 'package:subflix/features/auth/presentation/widgets/auth_flow_scaffold.dart';

class AuthResetPasswordScreen extends ConsumerStatefulWidget {
  const AuthResetPasswordScreen({super.key, this.args});

  final AuthResetPasswordArgs? args;

  @override
  ConsumerState<AuthResetPasswordScreen> createState() =>
      _AuthResetPasswordScreenState();
}

class _AuthResetPasswordScreenState
    extends ConsumerState<AuthResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tokenController;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tokenController = TextEditingController(text: widget.args?.token ?? '');
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
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
          .resetPassword(
            token: _tokenController.text.trim(),
            password: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            context.t.authResetPasswordSuccess,
            variant: AppTextVariant.bodyMedium,
          ),
        ),
      );
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
    final email = widget.args?.email?.trim();

    return AuthFlowScaffold(
      icon: Icons.lock_reset_rounded,
      eyebrow: context.t.authEyebrow,
      title: context.t.authResetPasswordTitle,
      subtitle: context.t.authResetPasswordSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (email != null && email.isNotEmpty) ...<Widget>[
            Container(
              width: double.infinity,
              padding: AppInsets.card,
              decoration: BoxDecoration(
                color: AppColors.surfaceMutedFor(context),
                borderRadius: BorderRadius.circular(18),
              ),
              child: AppText(
                context.t.authResetPasswordHint(email),
                variant: AppTextVariant.bodyMedium,
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
                  controller: _tokenController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.t.authVerificationTokenLabel,
                  ),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return context.t.authFieldRequired;
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
                    labelText: context.t.authNewPasswordLabel,
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
                  onFieldSubmitted: (_) => _handleResetPassword(),
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
                  label: context.t.authResetPasswordAction,
                  icon: Icons.check_circle_rounded,
                  onPressed: _isSubmitting ? null : _handleResetPassword,
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
              context.t.authBackToSignIn,
              variant: AppTextVariant.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
