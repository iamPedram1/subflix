import 'package:flutter/widgets.dart';

/// Shared corner radii for cards, sheets, and inputs.
abstract final class AppRadii {
  static const BorderRadius card = BorderRadius.all(Radius.circular(28));
  static const BorderRadius large = BorderRadius.all(Radius.circular(24));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(20));
  static const BorderRadius small = BorderRadius.all(Radius.circular(16));
  static const BorderRadius pill = BorderRadius.all(Radius.circular(999));
}
