import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:ui';

class NavBar extends StatelessWidget {
  final int activeIndex;
  final void Function(int) onTap;

  const NavBar({super.key, required this.activeIndex, required this.onTap});

  static const _labels = ['Home', 'Skills', 'Work', 'Projects', 'Awards', 'Contact'];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white.withOpacity(0.13)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.45), blurRadius: 28, offset: const Offset(0, 4)),
          ],
        ),
        child: BackdropFilter(
          filter: _blurFilter(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_labels.length, (i) {
                final active = activeIndex == i;
                final isLast = i == _labels.length - 1;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavItem(
                      label: _labels[i],
                      active: active,
                      onTap: () => onTap(i),
                      compact: isMobile,
                    ),
                    if (!isLast)
                      Container(
                        width: 4, height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.16),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  final bool compact;

  const _NavItem({required this.label, required this.active, required this.onTap, required this.compact});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final show = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: widget.compact ? 8 : 14, vertical: 7),
          decoration: BoxDecoration(
            color: show ? Colors.white.withOpacity(0.11) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.compact ? 11 : 12.5,
              fontWeight: FontWeight.w500,
              color: show ? Colors.white : AppColors.textSecondary,
              letterSpacing: 0.02,
            ),
          ),
        ),
      ),
    );
  }
}

ImageFilter _blurFilter(double sigma) => ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
