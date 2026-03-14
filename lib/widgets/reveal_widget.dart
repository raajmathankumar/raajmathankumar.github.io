import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RevealWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const RevealWidget({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<RevealWidget> createState() => _RevealWidgetState();
}

class _RevealWidgetState extends State<RevealWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key:  UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) _trigger();
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => FadeTransition(
          opacity: _opacity,
          child: SlideTransition(position: _slide, child: child),
        ),
        child: widget.child,
      ),
    );
  }
}
