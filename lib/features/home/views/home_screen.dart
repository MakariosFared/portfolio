import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive/size_config.dart';
import '../../../core/utils/responsive/responsive_builder.dart';
import 'home_mobile.dart';
import 'home_tablet.dart';
import 'home_desktop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: ResponsiveBuilder(
        mobile: const HomeMobile(),
        tablet: const HomeTablet(),
        desktop: const HomeDesktop(),
      ),
    );
  }
}