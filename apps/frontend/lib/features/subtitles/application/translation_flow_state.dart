import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/domain/models/translation_request.dart';

enum TranslationFlowStatus { idle, running, completed, failed }

class TranslationFlowState {
  const TranslationFlowState({
    required this.status,
    required this.progress,
    required this.stageLabel,
    this.job,
    this.errorMessage,
    this.request,
  });

  const TranslationFlowState.idle()
    : status = TranslationFlowStatus.idle,
      progress = 0,
      stageLabel = 'Waiting for a translation request',
      job = null,
      errorMessage = null,
      request = null;

  final TranslationFlowStatus status;
  final double progress;
  final String stageLabel;
  final TranslationJob? job;
  final String? errorMessage;
  final TranslationRequest? request;

  TranslationFlowState copyWith({
    TranslationFlowStatus? status,
    double? progress,
    String? stageLabel,
    TranslationJob? job,
    String? errorMessage,
    TranslationRequest? request,
    bool clearJob = false,
    bool clearError = false,
  }) {
    return TranslationFlowState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      stageLabel: stageLabel ?? this.stageLabel,
      job: clearJob ? null : job ?? this.job,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      request: request ?? this.request,
    );
  }
}
