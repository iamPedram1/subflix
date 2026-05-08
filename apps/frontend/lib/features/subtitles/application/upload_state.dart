import 'package:subflix/features/subtitles/domain/models/subtitle_file.dart';

enum UploadStatus { idle, picking, ready, failed }

class UploadState {
  const UploadState({required this.status, this.file, this.errorMessage});

  const UploadState.idle()
    : status = UploadStatus.idle,
      file = null,
      errorMessage = null;

  final UploadStatus status;
  final SubtitleFile? file;
  final String? errorMessage;

  UploadState copyWith({
    UploadStatus? status,
    SubtitleFile? file,
    String? errorMessage,
    bool clearFile = false,
    bool clearError = false,
  }) {
    return UploadState(
      status: status ?? this.status,
      file: clearFile ? null : file ?? this.file,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
