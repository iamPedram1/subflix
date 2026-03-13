import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: const ComingSoonPanel(
              title: 'History is next in line',
              message:
                  'Phase 3 will replace this shell placeholder with a full translation history experience.',
            ),
          ),
        ),
      ),
    );
  }
}
