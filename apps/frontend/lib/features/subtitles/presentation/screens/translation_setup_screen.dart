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
import 'package:subflix/features/settings/application/settings_controller.dart';
import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/presentation/models/translation_setup_args.dart';

class TranslationSetupScreen extends ConsumerStatefulWidget {
  const TranslationSetupScreen({required this.args, super.key});

  final TranslationSetupArgs args;

  @override
  ConsumerState<TranslationSetupScreen> createState() =>
      _TranslationSetupScreenState();
}

class _TranslationSetupScreenState
    extends ConsumerState<TranslationSetupScreen> {
  AppLanguage? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(settingsControllerProvider).asData?.value;
    final selectedLanguage =
        _selectedLanguage ??
        preferences?.preferredTargetLanguage ??
        AppLanguage.spanish;

    return Scaffold(
      appBar: AppBar(title: const Text('Translate setup')),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              SectionHeader(
                title: widget.args.title,
                subtitle:
                    'Choose the target language, review the subtitle source, and start the mock translation job.',
              ),
              const SizedBox(height: 16),
              AppSurfaceCard(
                child: Column(
                  spacing: 14,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      spacing: 12,
                      children: <Widget>[
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Iconsax.subtitle,
                            color: AppColors.primary,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.args.sourceName,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '${widget.args.format.label} subtitle source',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Target language',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: AppLanguage.values
                          .map(
                            (language) => ChoiceChip(
                              selected: language == selectedLanguage,
                              label: Text(language.label),
                              onSelected: (_) {
                                setState(() => _selectedLanguage = language);
                              },
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppGradientButton(
                label: 'Start translation',
                icon: Iconsax.magicStar,
                onPressed: () async {
                  await ref
                      .read(settingsControllerProvider.notifier)
                      .setPreferredTargetLanguage(selectedLanguage);
                  if (!context.mounted) {
                    return;
                  }

                  context.push(
                    AppRoutes.translationProgress,
                    extra: widget.args.toRequest(selectedLanguage),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
