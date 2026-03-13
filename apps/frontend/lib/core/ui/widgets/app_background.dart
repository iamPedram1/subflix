import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            AppColors.midnight,
            AppColors.abyss,
            AppColors.midnight,
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          const Positioned(
            top: -120,
            right: -40,
            child: _GlowOrb(
              size: 240,
              colors: <Color>[AppColors.secondary, AppColors.primary],
            ),
          ),
          const Positioned(
            top: 260,
            left: -90,
            child: _GlowOrb(
              size: 220,
              colors: <Color>[AppColors.emerald, Colors.transparent],
            ),
          ),
          const Positioned(
            bottom: -100,
            right: -30,
            child: _GlowOrb(
              size: 210,
              colors: <Color>[AppColors.primary, Colors.transparent],
            ),
          ),
          child,
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
