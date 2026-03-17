import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double pageBottom = 28;
}

abstract final class AppInsets {
  static const EdgeInsets page = EdgeInsets.fromLTRB(
    16,
    16,
    16,
    AppSpacing.pageBottom,
  );
  static const EdgeInsets pageWithNav = page;
  static const EdgeInsets pageWithNavComfort = EdgeInsets.fromLTRB(
    16,
    20,
    16,
    AppSpacing.pageBottom,
  );
  static const EdgeInsets card = EdgeInsets.all(16);
  static const EdgeInsets cardCompact = EdgeInsets.all(14);
  static const EdgeInsets cardLarge = EdgeInsets.all(20);
  static const EdgeInsets cardXL = EdgeInsets.all(24);
  static const EdgeInsets bottomBar = EdgeInsets.fromLTRB(16, 8, 16, 20);
  static const EdgeInsets chip = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 16,
  );
}
