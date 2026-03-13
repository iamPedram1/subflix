import 'package:flutter/material.dart';

import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';

class ComingSoonPanel extends StatelessWidget {
  const ComingSoonPanel({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return StatePanel(icon: Iconsax.magicStar, title: title, message: message);
  }
}
