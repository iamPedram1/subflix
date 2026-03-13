import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
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

  static const List<String> _stages = <String>[
    'Queued for translation',
    'Preparing subtitle package',
    'Aligning timestamps and scene context',
    'Generating subtitle translation',
    'Applying readability pass',
    'Translation ready',
  ];

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

    return Scaffold(
      appBar: AppBar(title: const Text('Translation progress')),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              AppSurfaceCard(
                child: Column(
                  spacing: 18,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'AI subtitle translation in progress',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      state.stageLabel,
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
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
                  title: 'Translation could not finish',
                  message: state.errorMessage ?? 'Something went wrong.',
                  action: AppGradientButton(
                    label: 'Retry translation',
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
                    children: _stages
                        .asMap()
                        .entries
                        .map(
                          (entry) => _StageTile(
                            label: entry.value,
                            isActive: entry.value == state.stageLabel,
                            isComplete:
                                state.progress >=
                                ((entry.key + 1) / _stages.length),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
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
