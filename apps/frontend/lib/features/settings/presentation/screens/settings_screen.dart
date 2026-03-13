import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: const ComingSoonPanel(
              title: 'Settings lands in Phase 3',
              message:
                  'Theme controls, language defaults, legal pages, and premium placeholders are scaffolded for the next commit.',
            ),
          ),
        ),
      ),
    );
  }
}
