import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';

enum SearchMediaType { movie, series }

extension SearchMediaTypeLabel on SearchMediaType {
  String label(BuildContext context) => switch (this) {
    SearchMediaType.movie => context.t.mediaTypeMovie,
    SearchMediaType.series => context.t.mediaTypeSeries,
  };
}
