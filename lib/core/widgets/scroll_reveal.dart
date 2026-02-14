import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:animate_do/animate_do.dart';

enum ScrollRevealType { fadeSlideUp, fadeSlideRight, zoomFade }

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final ScrollRevealType type;
  final Duration duration;
  final Duration delay;
  final double offset;

  const ScrollReveal({
    super.key,
    required this.child,
    this.type = ScrollRevealType.fadeSlideUp,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = 50.0,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _hasAnimate = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    // Use a stable key that won't confuse JS interop on Web
    _visibilityKey = ValueKey('scroll_reveal_${identityHashCode(this)}');
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted || _hasAnimate) return;

    try {
      if (info.visibleFraction > 0.1) {
        setState(() {
          _hasAnimate = true;
        });
      }
    } catch (e) {
      // Catch potential JS/Web specific interop errors
      debugPrint('ScrollReveal: Visibility observation failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: _buildAnimation(),
    );
  }

  Widget _buildAnimation() {
    if (!_hasAnimate) {
      return Opacity(opacity: 0, child: widget.child);
    }

    final type = widget.type;
    switch (type) {
      case ScrollRevealType.fadeSlideUp:
        return FadeInUp(
          duration: widget.duration,
          delay: widget.delay,
          from: widget.offset,
          child: widget.child,
        );
      case ScrollRevealType.fadeSlideRight:
        return FadeInLeft(
          duration: widget.duration,
          delay: widget.delay,
          from: widget.offset,
          child: widget.child,
        );
      case ScrollRevealType.zoomFade:
        return FadeInDown(
          duration: widget.duration,
          delay: widget.delay,
          child: ZoomIn(
            duration: widget.duration,
            delay: widget.delay,
            child: widget.child,
          ),
        );
    }
  }
}
