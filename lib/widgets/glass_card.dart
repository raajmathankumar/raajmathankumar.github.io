import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final bool hoverable;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 22,
    this.hoverable = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _lift;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _lift = Tween<double>(begin: 0, end: -6).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    if (!widget.hoverable) return;
    setState(() => _hovered = true);
    _ctrl.forward();
  }

  void _onExit(_) {
    if (!widget.hoverable) return;
    setState(() => _hovered = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _lift,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, _lift.value),
            child: child,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 26, sigmaY: 26),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: widget.padding ?? const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _hovered
                      ? Colors.white.withOpacity(0.1)
                      : AppColors.glassBg,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: _hovered
                        ? Colors.white.withOpacity(0.22)
                        : AppColors.glassBorder,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_hovered ? 0.35 : 0.25),
                      blurRadius: _hovered ? 40 : 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
