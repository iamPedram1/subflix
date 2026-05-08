import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/subtitles/application/upload_state.dart';
import 'package:subflix/features/subtitles/data/repositories/local_subtitle_import_repository.dart';

part 'upload_controller.g.dart';

@riverpod
class UploadController extends _$UploadController {
  @override
  UploadState build() {
    return const UploadState.idle();
  }

  Future<void> pickFile() async {
    state = state.copyWith(status: UploadStatus.picking, clearError: true);

    try {
      final file = await ref
          .read(subtitleImportRepositoryProvider)
          .pickSubtitleFile();
      state = UploadState(status: UploadStatus.ready, file: file);
    } on SubtitleImportCancelledException {
      state = state.copyWith(status: UploadStatus.idle, clearError: true);
    } catch (error) {
      state = UploadState(
        status: UploadStatus.failed,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> loadDemoFile() async {
    state = state.copyWith(status: UploadStatus.picking, clearError: true);

    try {
      final file = await ref
          .read(subtitleImportRepositoryProvider)
          .loadDemoFile();
      state = UploadState(status: UploadStatus.ready, file: file);
    } catch (error) {
      state = UploadState(
        status: UploadStatus.failed,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void clearSelection() {
    state = const UploadState.idle();
  }
}
