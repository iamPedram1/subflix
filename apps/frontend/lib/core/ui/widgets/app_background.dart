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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const <Color>[
                  AppColors.midnight,
                  AppColors.abyss,
                  AppColors.midnight,
                ]
              : <Color>[
                  scheme.surface,
                  scheme.surface.withValues(alpha: 0.92),
                  scheme.surface,
                ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          if (isDark)
            const Positioned(
              top: 260,
              left: -90,
              child: _GlowOrb(
                size: 220,
                colors: <Color>[AppColors.emerald, Colors.transparent],
              ),
            ),
          if (isDark)
            const Positioned(
              bottom: -100,
              right: -30,
              child: _GlowOrb(
                size: 210,
                colors: <Color>[AppColors.primary, Colors.transparent],
              ),
            ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
        ),
      ),
    );
  }
}
