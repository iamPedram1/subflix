import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 28;
  static const double xxxl = 32;
  static const double navBarBottom = 120;
}

abstract final class AppInsets {
  static const EdgeInsets page = EdgeInsets.fromLTRB(20, 12, 20, 24);
  static const EdgeInsets pageWithNav = EdgeInsets.fromLTRB(
    20,
    16,
    20,
    AppSpacing.navBarBottom,
  );
  static const EdgeInsets pageWithNavComfort = EdgeInsets.fromLTRB(
    20,
    20,
    20,
    AppSpacing.navBarBottom,
  );
  static const EdgeInsets card = EdgeInsets.all(20);
  static const EdgeInsets cardCompact = EdgeInsets.all(18);
  static const EdgeInsets cardLarge = EdgeInsets.all(24);
  static const EdgeInsets cardXL = EdgeInsets.all(28);
  static const EdgeInsets bottomBar = EdgeInsets.fromLTRB(20, 8, 20, 20);
  static const EdgeInsets chip = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const EdgeInsets button = EdgeInsets.symmetric(horizontal: 20, vertical: 18);
}
