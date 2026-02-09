import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/colors.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text('Home Mobile'),
      ),
    );
  }
}