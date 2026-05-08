import 'package:json_annotation/json_annotation.dart';

import 'package:subflix/features/shared/domain/models/translation_job.dart';

part 'translation_job_page_response.g.dart';

/// Transport model for paginated translation job summaries.
@JsonSerializable(createToJson: false)
class TranslationJobPageResponse {
  const TranslationJobPageResponse({required this.items});

  factory TranslationJobPageResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationJobPageResponseFromJson(json);

  final List<TranslationJob> items;
}
