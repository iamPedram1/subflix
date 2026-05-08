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

class AuthForgotPasswordScreen extends ConsumerStatefulWidget {
  const AuthForgotPasswordScreen({super.key});

  @override
  ConsumerState<AuthForgotPasswordScreen> createState() =>
      _AuthForgotPasswordScreenState();
}

class _AuthForgotPasswordScreenState
    extends ConsumerState<AuthForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;
  String? _successMessage;
  String? _resetToken;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleForgotPassword() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _successMessage = null;
      _resetToken = null;
    });

    try {
      final result = await ref
          .read(authControllerProvider.notifier)
          .forgotPassword(_emailController.text.trim());
      if (!mounted) {
        return;
      }

      if (result.resetToken != null && result.resetToken!.trim().isNotEmpty) {
        setState(() {
          _resetToken = result.resetToken!.trim();
          _successMessage = context.t.authForgotPasswordDebugMessage;
        });
        return;
      }

      setState(() {
        _successMessage = context.t.authForgotPasswordSuccess;
      });
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
      icon: Icons.password_rounded,
      eyebrow: context.t.authEyebrow,
      title: context.t.authForgotPasswordTitle,
      subtitle: context.t.authForgotPasswordSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_successMessage != null) ...<Widget>[
            StatePanel(
              icon: Icons.mark_email_read_rounded,
              title: context.t.authCheckInboxTitle,
              message: _successMessage!,
              action: _resetToken == null
                  ? null
                  : OutlinedButton.icon(
                      onPressed: () => context.push(
                        AppRoutes.authResetPassword,
                        extra: AuthResetPasswordArgs(
                          email: _emailController.text.trim(),
                          token: _resetToken,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: AppText(
                        context.t.authContinueToReset,
                        variant: AppTextVariant.labelLarge,
                      ),
                    ),
            ),
            if (_resetToken != null) ...<Widget>[
              const SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                padding: AppInsets.card,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMutedFor(context),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: AppText(
                  context.t.authDebugTokenLabel(_resetToken!),
                  variant: AppTextVariant.bodyMedium,
                ),
              ),
            ],
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
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleForgotPassword(),
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
                const SizedBox(height: AppSpacing.lg),
                AppGradientButton(
                  label: context.t.authForgotPasswordAction,
                  icon: Icons.send_rounded,
                  onPressed: _isSubmitting ? null : _handleForgotPassword,
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
