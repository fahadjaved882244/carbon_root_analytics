import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  bool get isPhone => width < 600;
  bool get isTablet => width >= 600 && width < 1440;
  bool get isDesktop => width >= 1440;

  bool get showRail => isTablet || isDesktop;
}
