import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class SubtitleSourcesScreen extends StatelessWidget {
  const SubtitleSourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subtitle sources')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const ComingSoonPanel(
              title: 'Source selection arrives in Phase 2',
              message:
                  'This route is already wired so the next commit can focus on behavior and polish.',
            ),
          ),
        ),
      ),
    );
  }
}
