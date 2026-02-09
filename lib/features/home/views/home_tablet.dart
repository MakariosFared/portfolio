import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/colors.dart';

class HomeTablet extends StatelessWidget {
  const HomeTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text('Home Tablet'),
      ),
    );
  }
}