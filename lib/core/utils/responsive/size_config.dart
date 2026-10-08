import 'package:flutter/material.dart';

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;

  static double width = 1200;
  static double height = 800;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    height = size.height;
    width = size.width;
  }

  static bool get isMobile => width < tablet;
  static bool get isTablet => width >= tablet && width < desktop;
  static bool get isDesktop => width >= desktop;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isMobile => screenWidth < SizeConfig.tablet;
  bool get isTablet =>
      screenWidth >= SizeConfig.tablet && screenWidth < SizeConfig.desktop;
  bool get isDesktop => screenWidth >= SizeConfig.desktop;
}


