import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadCV() async {
  final Uri url = Uri.parse('assets/my_cv.pdf');
  await launchUrl(url, mode: LaunchMode.platformDefault);
}

Future<void> launchLink(String url) async {
  final Uri uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

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
