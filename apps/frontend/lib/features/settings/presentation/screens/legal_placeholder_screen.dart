import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';

class LegalPlaceholderScreen extends StatelessWidget {
  const LegalPlaceholderScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final title = _title(context);
    final body = _body(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: ListView(
              padding: AppInsets.card,
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
                              title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                      Text(body, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _title(BuildContext context) => switch (slug) {
    'privacy' => context.t.legalTitlePrivacy,
    'terms' => context.t.legalTitleTerms,
    'support' => context.t.legalTitleSupport,
    _ => context.t.legalTitleAbout,
  };

  String _body(BuildContext context) => switch (slug) {
    'privacy' => context.t.legalBodyPrivacy,
    'terms' => context.t.legalBodyTerms,
    'support' => context.t.legalBodySupport,
    _ => context.t.legalBodyAbout,
  };
}
