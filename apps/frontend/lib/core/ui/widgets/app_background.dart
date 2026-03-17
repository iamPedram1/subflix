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
              ? const <Color>[
                  AppColors.backgroundDark,
                  Color(0xFF13131B),
                  AppColors.backgroundDark,
                ]
              : const <Color>[
                  AppColors.backgroundLight,
                  Color(0xFFF7F7FB),
                  AppColors.backgroundLight,
                ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -120,
            right: -80,
            child: _GlowOrb(
              size: isDark ? 260 : 220,
              colors: <Color>[
                (isDark ? AppColors.primaryDark : AppColors.primary).withValues(
                  alpha: isDark ? 0.18 : 0.10,
                ),
                Colors.transparent,
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: -70,
            child: _GlowOrb(
              size: isDark ? 220 : 180,
              colors: <Color>[
                AppColors.secondary.withValues(alpha: isDark ? 0.16 : 0.08),
                Colors.transparent,
              ],
            ),
          ),
          Positioned(
            bottom: -120,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _GlowOrb(
                size: isDark ? 320 : 260,
                colors: <Color>[
                  AppColors.tertiary.withValues(alpha: isDark ? 0.10 : 0.05),
                  Colors.transparent,
                ],
              ),
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
