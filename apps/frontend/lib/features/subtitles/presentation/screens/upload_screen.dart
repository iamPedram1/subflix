import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/subtitles/application/upload_controller.dart';
import 'package:subflix/features/subtitles/application/upload_state.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';

class UploadScreen extends ConsumerWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadControllerProvider);
    final uploadController = ref.read(uploadControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.uploadSubtitleTitle)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: AppInsets.page,
            children: <Widget>[
              SectionHeader(
                title: context.t.uploadIntroTitle,
                subtitle: context.t.uploadIntroSubtitle,
              ),
              const SizedBox(height: 16),
              AppSurfaceCard(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      spacing: 12,
                      children: <Widget>[
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.emerald.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Iconsax.documentUpload,
                            color: AppColors.emerald,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.t.uploadSupportedFormatsTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                context.t.uploadSupportedFormatsSubtitle,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 12,
                      children: <Widget>[
                        Expanded(
                          child: AppGradientButton(
                            label: uploadState.status == UploadStatus.picking
                                ? context.t.uploadOpeningPicker
                                : context.t.uploadChooseFileShort,
                            icon: Iconsax.documentUpload,
                            onPressed:
                                uploadState.status == UploadStatus.picking
                                ? null
                                : () => uploadController.pickFile(),
                          ),
                        ),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed:
                                uploadState.status == UploadStatus.picking
                                ? null
                                : () => uploadController.loadDemoFile(),
                            icon: const Icon(Iconsax.magicStar),
                            label: Text(context.t.uploadUseDemoFile),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (uploadState.status == UploadStatus.failed)
                StatePanel(
                  icon: Iconsax.warning2,
                  title: context.t.uploadFailedTitle,
                  message:
                      uploadState.errorMessage ??
                      context.t.uploadFailedFallback,
                  action: OutlinedButton.icon(
                    onPressed: () => uploadController.pickFile(),
                    icon: const Icon(Iconsax.refresh),
                    label: Text(context.t.tryAgain),
                  ),
                ),
              if (uploadState.file != null) ...<Widget>[
                AppSurfaceCard(
                  child: Column(
                    spacing: 14,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.t.uploadReadyTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        uploadState.file!.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: <Widget>[
                          _MetaChip(label: uploadState.file!.format.label),
                          _MetaChip(
                            label: context.t.uploadLineCount(
                              uploadState.file!.lineCount,
                            ),
                          ),
                          _MetaChip(label: context.t.uploadEnglishSource),
                        ],
                      ),
                      AppGradientButton(
                        label: context.t.uploadContinueSetup,
                        icon: Iconsax.arrowRight,
                        onPressed: () => context.push(
                          AppRoutes.translateSetup,
                          extra: TranslationSetupArgs.upload(
                            file: uploadState.file!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: AppInsets.chip,
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
