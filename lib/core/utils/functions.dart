import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';

Future<void> downloadCV() async {
  try {
    final Uri url = Uri.parse(AppConfig.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to local asset if configured
      final Uri assetUri = Uri.parse('assets/my_cv.pdf');
      await launchUrl(assetUri, mode: LaunchMode.platformDefault);
    }
  } catch (e) {
    debugPrint('Could not launch CV: $e');
  }
}

Future<void> launchLink(String url) async {
  try {
    String formattedUrl = url.trim();
    if (formattedUrl.contains('demos/') && !formattedUrl.endsWith('/') && !formattedUrl.endsWith('.html')) {
      formattedUrl = '$formattedUrl/';
    }

    Uri uri = Uri.parse(formattedUrl);
    if (!uri.hasScheme && uri.path.isNotEmpty) {
      uri = Uri.base.resolve(formattedUrl);
    }

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
    if (!launched) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  } catch (e) {
    debugPrint('Error launching URL $url: $e');
  }
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
