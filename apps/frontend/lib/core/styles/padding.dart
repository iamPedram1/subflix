import 'package:flutter/widgets.dart';

import 'package:subflix/core/styles/spacing.dart';

abstract final class AppPadding {
  static const EdgeInsets page = EdgeInsets.fromLTRB(
    AppSpacing.md,
    AppSpacing.md,
    AppSpacing.md,
    AppSpacing.pageBottom,
  );
  static const EdgeInsets pageComfort = EdgeInsets.fromLTRB(
    AppSpacing.md,
    AppSpacing.lg,
    AppSpacing.md,
    AppSpacing.pageBottom,
  );
  static const EdgeInsets card = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets cardCompact = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets cardLarge = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets cardXL = EdgeInsets.all(AppSpacing.xl);
  static const EdgeInsets chip = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xs,
  );
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: 18,
    vertical: AppSpacing.md,
  );
  static const EdgeInsets bottomBar = EdgeInsets.fromLTRB(
    AppSpacing.md,
    AppSpacing.xs,
    AppSpacing.md,
    AppSpacing.lg,
  );
}
