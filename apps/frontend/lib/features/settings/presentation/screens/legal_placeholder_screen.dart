import 'package:flutter/material.dart';

import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';

class LegalPlaceholderScreen extends StatelessWidget {
  const LegalPlaceholderScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleFromSlug(slug))),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StatePanel(
              icon: Iconsax.book,
              title: _titleFromSlug(slug),
              message:
                  'This placeholder page will be replaced with mock legal and support content in Phase 3.',
            ),
          ),
        ),
      ),
    );
  }

  String _titleFromSlug(String value) {
    return switch (value) {
      'privacy' => 'Privacy Policy',
      'terms' => 'Terms of Service',
      'about' => 'About SubFlix',
      _ => 'Legal',
    };
  }
}
