import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/features/history/application/history_controller.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

part 'home_providers.g.dart';

@riverpod
AsyncValue<List<TranslationJob>> recentJobs(Ref ref) {
  final history = ref.watch(historyControllerProvider);
  return history.whenData((jobs) => jobs.take(3).toList(growable: false));
}
