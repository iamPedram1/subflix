import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/padding.dart';
import 'package:subflix/core/ui/widgets/app_icon_button.dart';
import 'package:subflix/core/ui/widgets/app_text_field.dart';

class SearchTopBar extends StatelessWidget {
  const SearchTopBar({
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
    super.key,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).scaffoldBackgroundColor.withValues(alpha: 0.94),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        children: <Widget>[
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () => context.go(AppRoutes.home),
            variant: AppIconButtonVariant.ghost,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextField(
              controller: controller,
              onChanged: onChanged,
              autofocus: true,
              hintText: context.t.searchHintText,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.surfaceMutedFor(context),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.textSecondaryLight,
              ),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: onClear,
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimaryLight,
              ),
              contentPadding: AppPadding.button,
            ),
          ),
        ],
      ),
    );
  }
}
