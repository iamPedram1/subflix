import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: onPressed == null
            ? LinearGradient(
                colors: <Color>[
                  AppColors.outline.withValues(alpha: 0.5),
                  AppColors.outline.withValues(alpha: 0.4),
                ],
              )
            : AppColors.accentGradient,
        borderRadius: AppRadii.medium,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.medium),
        ),
      ),
    );
  }
}
