import 'package:flutter/material.dart';

import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/radii.dart';

class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({
    required this.height,
    super.key,
    this.width = double.infinity,
    this.borderRadius = AppRadii.small,
  });

  final double width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              colors: <Color>[
                AppColors.surfaceMutedFor(context).withValues(alpha: 0.55),
                AppColors.outline.withValues(
                  alpha: 0.35 + (_controller.value * 0.2),
                ),
                AppColors.surfaceMutedFor(context).withValues(alpha: 0.55),
              ],
            ),
          ),
          child: SizedBox(width: widget.width, height: widget.height),
        );
      },
    );
  }
}
