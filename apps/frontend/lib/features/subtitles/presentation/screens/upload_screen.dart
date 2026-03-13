import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload subtitle')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const ComingSoonPanel(
              title: 'Upload flow lands in Phase 3',
              message:
                  'File validation, parsing, and translated export are scaffolded and ready for the next phase.',
            ),
          ),
        ),
      ),
    );
  }
}
