import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';

part 'translation_job_provider.g.dart';

@riverpod
Future<TranslationJob?> translationJob(Ref ref, String jobId) {
  return ref.watch(historyRepositoryProvider).getJobById(jobId);
}
