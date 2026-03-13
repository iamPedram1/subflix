import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/styles/colors.dart';
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
      appBar: AppBar(title: const Text('Upload subtitle')),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              const SectionHeader(
                title: 'Bring your own subtitle file',
                subtitle:
                    'Import an English `.srt` or `.vtt` file, let the backend validate and parse it, then continue into translation setup.',
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
                                'Supported formats',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'English `.srt` and `.vtt` subtitle files',
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
                                ? 'Opening picker...'
                                : 'Choose file',
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
                            label: const Text('Use demo file'),
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
                  title: 'File import failed',
                  message:
                      uploadState.errorMessage ??
                      'Please try another subtitle file.',
                  action: OutlinedButton.icon(
                    onPressed: () => uploadController.pickFile(),
                    icon: const Icon(Iconsax.refresh),
                    label: const Text('Try again'),
                  ),
                ),
              if (uploadState.file != null) ...<Widget>[
                AppSurfaceCard(
                  child: Column(
                    spacing: 14,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Ready to translate',
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
                            label: '${uploadState.file!.lineCount} lines',
                          ),
                          const _MetaChip(label: 'English source'),
                        ],
                      ),
                      AppGradientButton(
                        label: 'Continue to translation setup',
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
