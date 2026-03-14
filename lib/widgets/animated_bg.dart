import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';

class AnimatedBg extends StatefulWidget {
  const AnimatedBg({super.key});

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> with TickerProviderStateMixin {
  late AnimationController _orb1, _orb2, _orb3;
  late Animation<Offset> _anim1, _anim2, _anim3;

  @override
  void initState() {
    super.initState();
    _orb1 = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(reverse: true);
    _orb2 = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(reverse: true);
    _orb3 = AnimationController(vsync: this, duration: const Duration(seconds: 14))..repeat(reverse: true);

    _anim1 = Tween<Offset>(begin: Offset.zero, end: const Offset(30, -40))
        .animate(CurvedAnimation(parent: _orb1, curve: Curves.easeInOut));
    _anim2 = Tween<Offset>(begin: Offset.zero, end: const Offset(-25, 30))
        .animate(CurvedAnimation(parent: _orb2, curve: Curves.easeInOut));
    _anim3 = Tween<Offset>(begin: Offset.zero, end: const Offset(20, -25))
        .animate(CurvedAnimation(parent: _orb3, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _orb1.dispose();
    _orb2.dispose();
    _orb3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Base gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF04040F), Color(0xFF080818), Color(0xFF040410)],
              ),
            ),
          ),
          // Orb 1 - Blue
          AnimatedBuilder(
            animation: _anim1,
            builder: (_, __) => Positioned(
              top: -120 + _anim1.value.dy,
              left: -120 + _anim1.value.dx,
              child: _Orb(color: AppColors.blue.withOpacity(0.22), size: 520),
            ),
          ),
          // Orb 2 - Purple
          AnimatedBuilder(
            animation: _anim2,
            builder: (_, __) => Positioned(
              top: MediaQuery.of(context).size.height * 0.28 + _anim2.value.dy,
              right: -90 + _anim2.value.dx,
              child: _Orb(color: AppColors.purple.withOpacity(0.18), size: 420),
            ),
          ),
          // Orb 3 - Cyan
          AnimatedBuilder(
            animation: _anim3,
            builder: (_, __) => Positioned(
              bottom: MediaQuery.of(context).size.height * 0.08 + _anim3.value.dy,
              left: MediaQuery.of(context).size.width * 0.18 + _anim3.value.dx,
              child: _Orb(color: AppColors.cyan.withOpacity(0.13), size: 360),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  final Color color;
  final double size;
  const _Orb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
