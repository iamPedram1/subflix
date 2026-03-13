import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class TranslationPreviewScreen extends StatelessWidget {
  const TranslationPreviewScreen({required this.jobId, super.key});

  final String jobId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translation preview')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ComingSoonPanel(
              title: 'Preview UI arrives in Phase 3',
              message:
                  'The route is receiving job id `$jobId` and will become a full subtitle preview screen shortly.',
            ),
          ),
        ),
      ),
    );
  }
}
