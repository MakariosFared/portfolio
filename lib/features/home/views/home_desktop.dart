import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/colors.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text('Home Desktop'),
      ),
    );
  }
}