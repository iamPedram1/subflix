import 'package:flutter/material.dart';

import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/coming_soon_panel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const ComingSoonPanel(
              title: 'Search flow is queued next',
              message:
                  'Phase 2 will add debounced search, subtitle source selection, and translation setup.',
            ),
          ),
        ),
      ),
    );
  }
}
