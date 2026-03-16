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
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/subtitles/application/translation_flow_controller.dart';
import 'package:subflix/features/subtitles/application/translation_flow_state.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

class TranslationProgressScreen extends ConsumerStatefulWidget {
  const TranslationProgressScreen({required this.request, super.key});

  final TranslationRequest request;

  @override
  ConsumerState<TranslationProgressScreen> createState() =>
      _TranslationProgressScreenState();
}

class _TranslationProgressScreenState
    extends ConsumerState<TranslationProgressScreen> {
  late final ProviderSubscription<TranslationFlowState> _subscription;
  bool _didStart = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _subscription = ref.listenManual<TranslationFlowState>(
      translationFlowControllerProvider,
      (_, next) {
        final job = next.job;
        if (_navigated ||
            next.status != TranslationFlowStatus.completed ||
            job == null) {
          return;
        }

        _navigated = true;
        Future<void>.delayed(const Duration(milliseconds: 350), () {
          if (!mounted) {
            return;
          }

          context.pushReplacement(
            AppRoutes.translationPreview.replaceFirst(':jobId', job.id),
          );
        });
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_didStart) {
        return;
      }
      _didStart = true;
      ref
          .read(translationFlowControllerProvider.notifier)
          .start(widget.request);
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(translationFlowControllerProvider);
    final stages = _localizedStages(context);
    final stageLabel = state.status == TranslationFlowStatus.idle
        ? context.t.translationStageIdle
        : state.stageLabel;

    return Scaffold(
      appBar: AppBar(title: Text(context.t.translationProgressTitle)),
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: AppInsets.page,
              children: <Widget>[
                AppSurfaceCard(
                  child: Column(
                    spacing: 18,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.t.translationProgressHeadline,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        stageLabel,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: state.progress,
                          minHeight: 12,
                          backgroundColor: AppColors.outline.withValues(
                            alpha: 0.3,
                          ),
                          color: AppColors.primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${(state.progress * 100).round()}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: AppColors.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (state.status == TranslationFlowStatus.failed)
                  StatePanel(
                    icon: Iconsax.warning2,
                    title: context.t.translationFailedTitle,
                    message:
                        state.errorMessage ?? context.t.translationFailedMessage,
                    action: AppGradientButton(
                      label: context.t.retryTranslation,
                      icon: Iconsax.refresh,
                      onPressed: () => ref
                          .read(translationFlowControllerProvider.notifier)
                          .retry(),
                    ),
                  )
                else
                  AppSurfaceCard(
                    child: Column(
                      spacing: 14,
                      children: stages
                          .asMap()
                          .entries
                          .map(
                            (entry) => _StageTile(
                              label: stages[entry.key].label,
                              isActive:
                                  stages[entry.key].backendLabel ==
                                  state.stageLabel,
                              isComplete:
                                  state.progress >=
                                  ((entry.key + 1) / stages.length),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_StageDefinition> _localizedStages(BuildContext context) {
    return <_StageDefinition>[
      _StageDefinition(
        backendLabel: 'Queued for translation',
        label: context.t.translationStageQueued,
      ),
      _StageDefinition(
        backendLabel: 'Preparing subtitle package',
        label: context.t.translationStagePreparing,
      ),
      _StageDefinition(
        backendLabel: 'Aligning timestamps and scene context',
        label: context.t.translationStageAligning,
      ),
      _StageDefinition(
        backendLabel: 'Generating subtitle translation',
        label: context.t.translationStageGenerating,
      ),
      _StageDefinition(
        backendLabel: 'Applying readability pass',
        label: context.t.translationStageReadability,
      ),
      _StageDefinition(
        backendLabel: 'Translation ready',
        label: context.t.translationStageReady,
      ),
    ];
  }
}

class _StageDefinition {
  const _StageDefinition({required this.backendLabel, required this.label});

  final String backendLabel;
  final String label;
}

class _StageTile extends StatelessWidget {
  const _StageTile({
    required this.label,
    required this.isActive,
    required this.isComplete,
  });

  final String label;
  final bool isActive;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? AppColors.primary
        : isComplete
        ? AppColors.emerald
        : AppColors.textMuted;

    return Row(
      spacing: 12,
      children: <Widget>[
        Icon(isComplete ? Iconsax.tickCircle : Iconsax.clock, color: color),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isActive
                  ? Theme.of(context).colorScheme.onSurface
                  : AppColors.textSecondary,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
