import 'package:flutter/material.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  const ResponsivePadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: margin(constraints.maxWidth)),
            SizedBox(
              width: bodySize(constraints.maxWidth),
              child: Center(child: child),
            ),
            SizedBox(width: margin(constraints.maxWidth)),
          ],
        );
      },
    );
  }

  double margin(double width) {
    switch (width) {
      case < 600:
        return 16;
      case >= 600 && < 905:
        return 32;
      case >= 905 && < 1240:
        return (width - 840) / 2;
      case >= 1240 && < 1440:
        return 200;
      case >= 1440:
        return (width - 1040) / 2;
      default:
        return 16;
    }
  }

  double bodySize(double width) {
    switch (width) {
      case < 600:
        return width - 16 * 2;
      case >= 600 && < 905:
        return width - (32 * 2);
      case >= 905 && < 1240:
        return 840;
      case >= 1240 && < 1440:
        return width - (200 * 2);
      case >= 1440:
        return 1040;
      default:
        return 16;
    }
  }
}
