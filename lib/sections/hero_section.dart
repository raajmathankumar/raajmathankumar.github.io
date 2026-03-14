import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import '../widgets/glass_card.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({super.key, required this.onViewWork, required this.onContact});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _ringCtrl;
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _ringCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ringCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 700;

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: EdgeInsets.fromLTRB(24, isMobile ? 120 : 130, 24, 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              // Available badge
              _AvailableBadge(pulseCtrl: _pulseCtrl)
                  .animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0, delay: 200.ms),

              const SizedBox(height: 26),

              // Avatar ring
              _AvatarRing(ringCtrl: _ringCtrl)
                  .animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.8, 0.8), delay: 100.ms),

              const SizedBox(height: 22),

              // Name
              Column(
                children: [
                  Text(
                    'Raaj Mathan',
                    style: TextStyle(
                      fontSize: isMobile ? 44 : 72,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.03,
                      height: 1,
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.blue, AppColors.cyan, AppColors.purple],
                    ).createShader(bounds),
                    child: Text(
                      'Kumar',
                      style: TextStyle(
                        fontSize: isMobile ? 44 : 72,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.03,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0, delay: 300.ms),

              const SizedBox(height: 14),

              // Title mono
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: '< ', style: TextStyle(color: AppColors.cyan)),
                  const TextSpan(text: 'Senior Flutter Developer  ·  Cross-Platform Engineer '),
                  TextSpan(text: '/>', style: TextStyle(color: AppColors.cyan)),
                ]),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.12,
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 22),

              Text(
                'Senior Flutter Developer with 4+ years crafting scalable apps for Android, iOS, Web & Desktop. Published 5 live apps on the App Store & Play Store serving 50K+ users with an average 4.3★ rating.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.75,
                ),
              ).animate().fadeIn(delay: 500.ms),

              const SizedBox(height: 36),

              // Stats row
              _StatsRow(isMobile: isMobile)
                  .animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0, delay: 600.ms),

              const SizedBox(height: 36),

              // CTA buttons
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _PrimaryButton(label: 'View Live Apps', onTap: widget.onViewWork),
                  _SecondaryButton(label: 'Get In Touch', onTap: widget.onContact),
                ],
              ).animate().fadeIn(delay: 700.ms),

              const SizedBox(height: 50),

              // Scroll indicator
              Column(
                children: [
                  Container(
                    width: 1, height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0.5), Colors.transparent],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text('SCROLL', style: TextStyle(fontSize: 9, letterSpacing: 0.14, color: AppColors.textSecondary)),
                ],
              ).animate().fadeIn(delay: 1200.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  final AnimationController pulseCtrl;
  const _AvailableBadge({required this.pulseCtrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.13),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.blue.withOpacity(0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, __) => Container(
              width: 7, height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.green,
                boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.5 + 0.5 * pulseCtrl.value), blurRadius: 8)],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'OPEN TO GLOBAL OPPORTUNITIES',
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.1, color: AppColors.cyan),
          ),
        ],
      ),
    );
  }
}

class _AvatarRing extends StatelessWidget {
  final AnimationController ringCtrl;
  const _AvatarRing({required this.ringCtrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, height: 120,
      child: AnimatedBuilder(
        animation: ringCtrl,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: ringCtrl.value * 2 * pi,
              child: Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [AppColors.blue, AppColors.purple, AppColors.cyan, AppColors.blue],
                  ),
                ),
              ),
            ),
            Container(
              width: 112, height: 112,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF08081A),
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [AppColors.blue, AppColors.cyan],
                  ).createShader(b),
                  child: const Text(
                    'RM',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final bool isMobile;
  const _StatsRow({required this.isMobile});

  static const _stats = [
    ('4+', 'Years Exp.'),
    ('5', 'Live Apps'),
    ('50K+', 'Active Users'),
    ('4.3★', 'Avg. Rating'),
    ('45%', 'Perf. Boost'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _stats.map((s) => _StatCard(value: s.$1, label: s.$2)).toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hoverable: false,
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [Colors.white, AppColors.cyan],
                ).createShader(b),
                child: Text(widget.value,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
              const SizedBox(height: 3),
              Text(widget.label,
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, letterSpacing: 0.04)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(colors: [AppColors.blue, AppColors.purple]),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withOpacity(_hovered ? 0.5 : 0.38),
                blurRadius: _hovered ? 32 : 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(widget.label,
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white.withOpacity(_hovered ? 0.13 : 0.08),
            border: Border.all(color: Colors.white.withOpacity(0.17)),
          ),
          child: Text(widget.label,
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }
}
