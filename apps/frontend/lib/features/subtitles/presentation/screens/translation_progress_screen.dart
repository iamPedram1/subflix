import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
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
        Future<void>.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) {
            return;
          }

          context.pushReplacement(
            AppRoutes.translationResult.replaceFirst(':jobId', job.id),
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

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 28),
              children: <Widget>[
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 108,
                    height: 108,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.30),
                          blurRadius: 30,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AppText(
                  context.t.translationProgressHeadline,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                AppText(
                  state.status == TranslationFlowStatus.idle
                      ? context.t.translationStageIdle
                      : state.stageLabel,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.center,
                  color: AppColors.textSecondaryFor(context),
                ),
                const SizedBox(height: 24),
                AppSurfaceCard(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AppText(
                            context.t.translationProgressTitle,
                            variant: AppTextVariant.titleMedium,
                          ),
                          const Spacer(),
                          AppText(
                            '${(state.progress * 100).round()}%',
                            variant: AppTextVariant.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: state.progress,
                          minHeight: 10,
                          backgroundColor: AppColors.surfaceMutedFor(context),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (state.status == TranslationFlowStatus.failed)
                  StatePanel(
                    icon: Icons.error_outline_rounded,
                    title: context.t.translationFailedTitle,
                    message:
                        state.errorMessage ??
                        context.t.translationFailedMessage,
                    action: OutlinedButton.icon(
                      onPressed: () => ref
                          .read(translationFlowControllerProvider.notifier)
                          .retry(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: AppText(
                        context.t.retryTranslation,
                        variant: AppTextVariant.labelLarge,
                      ),
                    ),
                  )
                else
                  ...stages.asMap().entries.map((entry) {
                    final stage = entry.value;
                    final isActive = stage.backendLabel == state.stageLabel;
                    final isComplete =
                        state.progress >= ((entry.key + 1) / stages.length);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ProgressStageTile(
                        label: stage.label,
                        isActive: isActive,
                        isComplete: isComplete,
                      ),
                    );
                  }),
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

class _ProgressStageTile extends StatelessWidget {
  const _ProgressStageTile({
    required this.label,
    required this.isActive,
    required this.isComplete,
  });

  final String label;
  final bool isActive;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final bgColor = isComplete
        ? AppColors.emerald.withValues(alpha: 0.10)
        : isActive
        ? AppColors.primary.withValues(alpha: 0.10)
        : Theme.of(context).colorScheme.surface;
    final iconColor = isComplete
        ? AppColors.emerald
        : isActive
        ? AppColors.primary
        : AppColors.textSecondaryFor(context);

    return AppSurfaceCard(
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isComplete
                  ? Icons.check_circle_rounded
                  : Icons.auto_awesome_rounded,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.titleMedium,
              color: isActive || isComplete
                  ? Theme.of(context).colorScheme.onSurface
                  : AppColors.textSecondaryFor(context),
            ),
          ),
          if (isActive)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }
}
