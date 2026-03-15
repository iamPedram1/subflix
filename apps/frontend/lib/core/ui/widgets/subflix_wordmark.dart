import 'package:flutter/material.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/brand.dart';

class SubflixWordmark extends StatelessWidget {
  const SubflixWordmark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final titleStyle = compact
        ? Theme.of(context).textTheme.titleLarge
        : Theme.of(context).textTheme.headlineMedium;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: compact ? 10 : 14,
      children: <Widget>[
        Container(
          width: compact ? 42 : 56,
          height: compact ? 42 : 56,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(compact ? 16 : 20),
          ),
          alignment: Alignment.center,
          child: Icon(
            BrandIcons.spark,
            color: Colors.white,
            size: compact ? 22 : 28,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.t.appTitle,
              style: titleStyle?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              compact
                  ? context.t.brandSubtitleCompact
                  : context.t.brandSubtitleFull,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
