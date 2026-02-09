import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive/size_config.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    if (SizeConfig.isMobile) return mobile;
    if (SizeConfig.isTablet) return tablet;
    return desktop;
  }
}
