import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/subtitles/application/translation_flow_state.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

part 'translation_flow_controller.g.dart';

@Riverpod(keepAlive: true)
class TranslationFlowController extends _$TranslationFlowController {
  StreamSubscription? _subscription;

  @override
  TranslationFlowState build() {
    ref.onDispose(() => _subscription?.cancel());
    return const TranslationFlowState.idle();
  }

  Future<void> start(TranslationRequest request) async {
    await _subscription?.cancel();
    state = TranslationFlowState(
      status: TranslationFlowStatus.running,
      progress: 0.04,
      stageLabel: 'Queued for translation',
      request: request,
    );

    _subscription = ref
        .read(translationRepositoryProvider)
        .startTranslation(request)
        .listen(
          (update) async {
            if (update.job != null) {
              await ref.read(historyRepositoryProvider).saveJob(update.job!);
              ref.invalidate(historyControllerProvider);
              state = state.copyWith(
                status: TranslationFlowStatus.completed,
                progress: update.progress,
                stageLabel: update.stageLabel,
                job: update.job,
                clearError: true,
              );
              return;
            }

            state = state.copyWith(
              status: TranslationFlowStatus.running,
              progress: update.progress,
              stageLabel: update.stageLabel,
              clearError: true,
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            state = state.copyWith(
              status: TranslationFlowStatus.failed,
              errorMessage: error.toString().replaceFirst('Exception: ', ''),
            );
          },
        );
  }

  Future<void> retry() async {
    final request = state.request;
    if (request == null) {
      return;
    }
    await start(request);
  }

  void reset() {
    state = const TranslationFlowState.idle();
  }
}
