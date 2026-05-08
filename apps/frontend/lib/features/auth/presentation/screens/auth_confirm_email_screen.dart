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
import 'package:subflix/features/auth/presentation/models/auth_confirm_email_args.dart';
import 'package:subflix/features/auth/presentation/widgets/auth_flow_scaffold.dart';

class AuthConfirmEmailScreen extends ConsumerStatefulWidget {
  const AuthConfirmEmailScreen({super.key, this.args});

  final AuthConfirmEmailArgs? args;

  @override
  ConsumerState<AuthConfirmEmailScreen> createState() =>
      _AuthConfirmEmailScreenState();
}

class _AuthConfirmEmailScreenState
    extends ConsumerState<AuthConfirmEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tokenController;

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
    super.dispose();
  }

  Future<void> _handleConfirmEmail() async {
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
          .confirmEmail(_tokenController.text.trim());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            context.t.authConfirmEmailSuccess,
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
      icon: Icons.mark_email_read_rounded,
      eyebrow: context.t.authEyebrow,
      title: context.t.authConfirmEmailTitle,
      subtitle: context.t.authConfirmEmailSubtitle,
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
                context.t.authConfirmEmailHint(email),
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
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleConfirmEmail(),
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
                const SizedBox(height: AppSpacing.lg),
                AppGradientButton(
                  label: context.t.authConfirmEmailAction,
                  icon: Icons.verified_rounded,
                  onPressed: _isSubmitting ? null : _handleConfirmEmail,
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
