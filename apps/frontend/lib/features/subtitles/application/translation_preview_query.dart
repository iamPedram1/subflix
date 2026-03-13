import 'package:flutter/foundation.dart';

@immutable
class TranslationPreviewQuery {
  const TranslationPreviewQuery({
    required this.jobId,
    this.query = '',
    this.page = 1,
    this.limit = 100,
  });

  final String jobId;
  final String query;
  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TranslationPreviewQuery &&
            runtimeType == other.runtimeType &&
            jobId == other.jobId &&
            query == other.query &&
            page == other.page &&
            limit == other.limit;
  }

  @override
  int get hashCode => Object.hash(jobId, query, page, limit);
}
