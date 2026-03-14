import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';

class AnimatedBg extends StatefulWidget {
  const AnimatedBg({super.key});

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> with TickerProviderStateMixin {
  // Orb float controllers
  late AnimationController _orb1, _orb2, _orb3;
  // Gradient color shift controller
  late AnimationController _gradCtrl;
  // Radial pulse
  late AnimationController _pulseCtrl;

  late Animation<Offset> _anim1, _anim2, _anim3;
  late Animation<double> _gradAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _orb1 = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(reverse: true);
    _orb2 = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(reverse: true);
    _orb3 = AnimationController(vsync: this, duration: const Duration(seconds: 15))..repeat(reverse: true);
    _gradCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat(reverse: true);

    _anim1 = Tween<Offset>(begin: Offset.zero, end: const Offset(40, -50))
        .animate(CurvedAnimation(parent: _orb1, curve: Curves.easeInOut));
    _anim2 = Tween<Offset>(begin: Offset.zero, end: const Offset(-30, 40))
        .animate(CurvedAnimation(parent: _orb2, curve: Curves.easeInOut));
    _anim3 = Tween<Offset>(begin: Offset.zero, end: const Offset(25, -30))
        .animate(CurvedAnimation(parent: _orb3, curve: Curves.easeInOut));

    _gradAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _gradCtrl, curve: Curves.easeInOut));
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _orb1.dispose(); _orb2.dispose(); _orb3.dispose();
    _gradCtrl.dispose(); _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned.fill(
      child: AnimatedBuilder(
        animation: Listenable.merge([_gradAnim, _pulseAnim, _anim1, _anim2, _anim3]),
        builder: (_, __) {
          final t = _gradAnim.value;
          // Smoothly interpolate background accent colours
          final topColor = Color.lerp(
            const Color(0xFF007AFF).withOpacity(0.22),
            const Color(0xFFBF5AF2).withOpacity(0.20),
            t,
          )!;
          final midColor = Color.lerp(
            const Color(0xFFBF5AF2).withOpacity(0.16),
            const Color(0xFF32D6FE).withOpacity(0.16),
            t,
          )!;
          final bottomColor = Color.lerp(
            const Color(0xFF32D6FE).withOpacity(0.12),
            const Color(0xFF007AFF).withOpacity(0.18),
            t,
          )!;

          return Stack(children: [
            // Animated base gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(const Color(0xFF04040F), const Color(0xFF06050F), t)!,
                    Color.lerp(const Color(0xFF080818), const Color(0xFF070818), t)!,
                    const Color(0xFF040410),
                  ],
                ),
              ),
            ),

            // Top-left radial — colour-shifting
            Positioned(
              top: -130 + _anim1.value.dy,
              left: -130 + _anim1.value.dx,
              child: _GradOrb(color: topColor, size: 560),
            ),

            // Top-right radial — purple→cyan shift
            Positioned(
              top: size.height * 0.22 + _anim2.value.dy,
              right: -100 + _anim2.value.dx,
              child: _GradOrb(color: midColor, size: 440),
            ),

            // Bottom-center — cyan→blue shift
            Positioned(
              bottom: size.height * 0.06 + _anim3.value.dy,
              left: size.width * 0.16 + _anim3.value.dx,
              child: _GradOrb(color: bottomColor, size: 380),
            ),

            // Pulsing center glow (subtle depth)
            Positioned(
              top: size.height * 0.35,
              left: size.width * 0.3,
              child: Opacity(
                opacity: 0.06 * _pulseAnim.value,
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.lerp(AppColors.cyan, AppColors.purple, t)!,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Diagonal shimmer line (very subtle)
            Positioned.fill(
              child: Opacity(
                opacity: 0.03,
                child: CustomPaint(painter: _DiagonalLinePainter(t)),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class _GradOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GradOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}

// Draws subtle animated diagonal shimmer lines across the bg
class _DiagonalLinePainter extends CustomPainter {
  final double t;
  _DiagonalLinePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const gap = 120.0;
    final offset = t * gap;

    for (double x = -size.height + offset; x < size.width + size.height; x += gap) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DiagonalLinePainter old) => old.t != t;
}
