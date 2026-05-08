import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

part 'history_controller.g.dart';

@Riverpod(keepAlive: true)
class HistoryController extends _$HistoryController {
  @override
  Future<List<TranslationJob>> build() {
    return ref.watch(historyRepositoryProvider).fetchJobs();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      ref.watch(historyRepositoryProvider).fetchJobs,
    );
  }

  Future<void> clear() async {
    final repository = ref.watch(historyRepositoryProvider);
    final previous = state;
    state = const AsyncValue.data(<TranslationJob>[]);
    try {
      await repository.clear();
    } catch (_) {
      state = previous;
    }
  }
}
