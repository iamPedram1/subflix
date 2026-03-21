import 'package:flutter/widgets.dart';

import 'package:subflix/core/styles/padding.dart';

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
  static const EdgeInsets page = AppPadding.page;
  static const EdgeInsets pageWithNav = AppPadding.page;
  static const EdgeInsets pageWithNavComfort = AppPadding.pageComfort;
  static const EdgeInsets card = AppPadding.card;
  static const EdgeInsets cardCompact = AppPadding.cardCompact;
  static const EdgeInsets cardLarge = AppPadding.cardLarge;
  static const EdgeInsets cardXL = AppPadding.cardXL;
  static const EdgeInsets bottomBar = AppPadding.bottomBar;
  static const EdgeInsets chip = AppPadding.chip;
  static const EdgeInsets button = AppPadding.button;
}
