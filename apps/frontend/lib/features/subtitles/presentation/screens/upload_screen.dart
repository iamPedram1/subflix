import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/subtitles/application/upload_controller.dart';
import 'package:subflix/features/subtitles/application/upload_state.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';

class UploadScreen extends ConsumerWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadControllerProvider);
    final controller = ref.read(uploadControllerProvider.notifier);

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
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  context.t.uploadSubtitleTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.t.uploadIntroSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: AppInsets.cardXL,
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.upload_file_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        context.t.uploadIntroTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        context.t.uploadSupportedFormatsSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppGradientButton(
                        label: uploadState.status == UploadStatus.picking
                            ? context.t.uploadOpeningPicker
                            : context.t.uploadChooseFileShort,
                        icon: Icons.upload_file_rounded,
                        gradient: const LinearGradient(
                          colors: <Color>[Colors.white, Colors.white],
                        ),
                        iconColor: AppColors.primary,
                        labelStyle: Theme.of(context).textTheme.labelLarge
                            ?.copyWith(color: AppColors.primary),
                        onPressed: uploadState.status == UploadStatus.picking
                            ? null
                            : () => controller.pickFile(),
                        fullWidth: true,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: uploadState.status == UploadStatus.picking
                            ? null
                            : () => controller.loadDemoFile(),
                        icon: const Icon(Icons.bolt_rounded),
                        label: Text(context.t.uploadUseDemoFile),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (uploadState.status == UploadStatus.failed)
                  StatePanel(
                    icon: Icons.error_outline_rounded,
                    title: context.t.uploadFailedTitle,
                    message:
                        uploadState.errorMessage ??
                        context.t.uploadFailedFallback,
                    action: OutlinedButton.icon(
                      onPressed: () => controller.pickFile(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(context.t.tryAgain),
                    ),
                  ),
                if (uploadState.file != null) ...<Widget>[
                  AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.t.uploadReadyTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          uploadState.file!.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            _Chip(label: uploadState.file!.format.label),
                            _Chip(
                              label: context.t.uploadLineCount(
                                uploadState.file!.lineCount,
                              ),
                            ),
                            _Chip(label: context.t.uploadEnglishSource),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppGradientButton(
                          label: context.t.uploadContinueSetup,
                          icon: Icons.arrow_forward_rounded,
                          onPressed: () => context.push(
                            AppRoutes.translateSetup,
                            extra: TranslationSetupArgs.upload(
                              file: uploadState.file!,
                            ),
                          ),
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedFor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondaryFor(context),
        ),
      ),
    );
  }
}
