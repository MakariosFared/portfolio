import 'package:flutter/material.dart';

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;

  static late double width, height;

  static init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
  }

  static bool get isMobile => width < tablet;
  static bool get isTablet => width >= tablet && width < desktop;
  static bool get isDesktop => width >= desktop;
}

