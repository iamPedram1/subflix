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
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
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
  bool _preserveTiming = true;
  bool _autoDetectFormat = true;

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(settingsControllerProvider).asData?.value;
    final selectedLanguage =
        _selectedLanguage ??
        preferences?.preferredTargetLanguage ??
        AppLanguage.english;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AppText(
                  context.t.translateSetupTitle,
                  variant: AppTextVariant.headlineMedium,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                AppText(
                  context.t.translateSetupSubtitle,
                  variant: AppTextVariant.bodyMedium,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 20),
                AppSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        context.t.translateSetupSourceTitle,
                        variant: AppTextVariant.labelLarge,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.textSecondaryFor(context),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: AppColors.accentGradient,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.subtitles_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText(
                                  widget.args.sourceName,
                                  variant: AppTextVariant.titleMedium,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                AppText(
                                  context.t.subtitleSourceFormatLabel(
                                    widget.args.format.label,
                                  ),
                                  variant: AppTextVariant.bodySmall,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondaryFor(
                                          context,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppText(
                  context.t.translateSetupLanguageTitle,
                  variant: AppTextVariant.labelLarge,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: AppInsets.card,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Column(
                    children: AppLanguage.values
                        .where(
                          (language) => AppLocalizations.supportedLocales.any(
                            (locale) => locale.languageCode == language.code,
                          ),
                        )
                        .map(
                          (language) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _LanguageRow(
                              language: language,
                              selected: language == selectedLanguage,
                              onTap: () {
                                setState(() => _selectedLanguage = language);
                              },
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
                const SizedBox(height: 16),
                if (_selectedLanguage != null || preferences != null)
                  Container(
                    padding: AppInsets.card,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.secondary.withValues(alpha: 0.12),
                          AppColors.tertiary.withValues(alpha: 0.10),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[
                                AppColors.secondary,
                                AppColors.tertiary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                context.t.translateSetupReadyTitle,
                                variant: AppTextVariant.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              AppText(
                                context.t.translateSetupReadyBody(
                                  selectedLanguage.label,
                                ),
                                variant: AppTextVariant.bodyMedium,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondaryFor(
                                        context,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                AppText(
                  context.t.translateSetupOptionsTitle,
                  variant: AppTextVariant.labelLarge,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
                const SizedBox(height: 10),
                _OptionTile(
                  title: context.t.translateSetupPreserveTiming,
                  subtitle: context.t.translateSetupPreserveTimingBody,
                  value: _preserveTiming,
                  onChanged: (value) => setState(() => _preserveTiming = value),
                ),
                const SizedBox(height: 10),
                _OptionTile(
                  title: context.t.translateSetupAutoDetect,
                  subtitle: context.t.translateSetupAutoDetectBody,
                  value: _autoDetectFormat,
                  onChanged: (value) =>
                      setState(() => _autoDetectFormat = value),
                ),
                const SizedBox(height: 20),
                AppGradientButton(
                  label: context.t.startTranslation,
                  icon: Icons.auto_awesome_rounded,
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
                  fullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        padding: AppInsets.cardCompact,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.10)
              : AppColors.surfaceMutedFor(context),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    language.label,
                    variant: AppTextVariant.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    language.nativeLabel,
                    variant: AppTextVariant.bodySmall,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondaryFor(context),
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(title, variant: AppTextVariant.titleMedium),
                const SizedBox(height: 4),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryFor(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
