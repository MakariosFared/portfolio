import 'package:flutter/material.dart';

void scrollToSection(BuildContext context, GlobalKey key) {
  // Only pop if we are actually in a drawer (which is a route)
  final scaffold = Scaffold.maybeOf(context);
  if (scaffold != null && scaffold.isDrawerOpen) {
    scaffold.closeDrawer();
  }

  final targetContext = key.currentContext;
  if (targetContext != null) {
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );
  }
}
