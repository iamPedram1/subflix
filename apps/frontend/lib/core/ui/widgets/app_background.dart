import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const Positioned.fill(
          child: RepaintBoundary(child: _BackgroundLayer()),
        ),
        child,
      ],
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  const _BackgroundLayer();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const <Color>[Color(0xFF0D0F14), Color(0xFF0D0F14)]
              : const <Color>[
                  AppColors.backgroundLight,
                  Color(0xFFF7F7FB),
                  AppColors.backgroundLight,
                ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}
