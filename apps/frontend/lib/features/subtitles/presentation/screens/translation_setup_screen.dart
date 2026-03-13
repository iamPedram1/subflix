import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class TranslationSetupScreen extends StatelessWidget {
  const TranslationSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translate setup')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const ComingSoonPanel(
              title: 'Translation setup is staged',
              message:
                  'Preferred language defaults and job launch controls will land in the next commit.',
            ),
          ),
        ),
      ),
    );
  }
}
