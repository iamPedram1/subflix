import 'package:flutter/material.dart';

import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';

class RouteStateMissingScreen extends StatelessWidget {
  const RouteStateMissingScreen({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(title, variant: AppTextVariant.titleLarge)),
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: Padding(
              padding: AppInsets.card,
              child: StatePanel(
                icon: Iconsax.warning2,
                title: title,
                message: message,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
