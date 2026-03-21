import 'package:flutter/widgets.dart';

class AppDirectionalIcon extends StatelessWidget {
  const AppDirectionalIcon({
    required this.icon,
    super.key,
    this.size,
    this.color,
  });

  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final child = Icon(icon, size: size, color: color);
    if (!isRtl) {
      return child;
    }
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.1415926535897932),
      child: child,
    );
  }
}
