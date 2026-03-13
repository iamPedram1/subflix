import 'package:flutter/material.dart';

import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';

class LegalPlaceholderScreen extends StatelessWidget {
  const LegalPlaceholderScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              AppSurfaceCard(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      spacing: 12,
                      children: <Widget>[
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF5D8BFF,
                            ).withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Iconsax.book,
                            color: Color(0xFF5D8BFF),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    Text(_body, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _title => switch (slug) {
    'privacy' => 'Privacy Policy',
    'terms' => 'Terms of Service',
    'support' => 'Support',
    _ => 'About SubFlix',
  };

  String get _body => switch (slug) {
    'privacy' =>
      'SubFlix currently stores only mock preferences and translation history on device through local persistence. A future backend integration can replace this with authenticated storage, audit trails, and server-managed retention policies.',
    'terms' =>
      'This mock build is intended to exercise product flows, UI states, and architecture boundaries. When a production NestJS and Postgres backend is connected later, the legal surface can be expanded with real service terms and data processing language.',
    'support' =>
      'Support is a placeholder for now. In a production release this section can connect to email, issue reporting, and premium account help while keeping the app shell unchanged.',
    _ =>
      'SubFlix is a premium-style Flutter client for AI subtitle translation. This build uses mock repositories, artificial latency, and local persistence so the UI and architecture can evolve before a real backend is attached.',
  };
}
