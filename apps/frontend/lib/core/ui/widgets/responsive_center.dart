import 'package:flutter/widgets.dart';

class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({super.key, required this.child});

  final Widget child;

  double _maxWidthFor(double width) {
    if (width >= 1200) return 920;
    if (width >= 960) return 840;
    if (width >= 840) return 760;
    if (width >= 720) return 680;
    return double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = _maxWidthFor(constraints.maxWidth);
        if (maxWidth == double.infinity) {
          return child;
        }
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}
