import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class TranslationProgressScreen extends StatelessWidget {
  const TranslationProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translation progress')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const ComingSoonPanel(
              title: 'Live progress comes next',
              message:
                  'Phase 2 will stream mock progress updates and route into preview when complete.',
            ),
          ),
        ),
      ),
    );
  }
}
