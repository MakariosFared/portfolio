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
  final Key _visibilityKey = UniqueKey();

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimate && info.visibleFraction > 0.1) {
      setState(() {
        _hasAnimate = true;
      });
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

    switch (widget.type) {
      case ScrollRevealType.fadeSlideUp:
        return FadeInUp(
          duration: widget.duration,
          delay: widget.delay,
          from: widget.offset,
          child: widget.child,
        );
      case ScrollRevealType.fadeSlideRight:
        return FadeInLeft(
          // AnimateDo's FadeInLeft slides from left to right
          duration: widget.duration,
          delay: widget.delay,
          from: widget.offset,
          child: widget.child,
        );
      case ScrollRevealType.zoomFade:
        return FadeInDown(
          // Use ZoomIn from animate_do
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
