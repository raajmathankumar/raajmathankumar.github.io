import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal_widget.dart';
import '../widgets/section_header.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  static const _awards = [
    _AwardData('🌟', 'Senior Promotion', 'Jul 2024',
        'Advanced to Senior Flutter Developer in just 2.5 years through outstanding performance in engineering, CI/CD and technical leadership.'),
    _AwardData('🏅', 'Valuable Contributor Award', '2024',
        'Recognised for consistently delivering projects within deadline and scope, driving measurable improvements in product quality and team velocity.'),
    _AwardData('⚡', 'Spot Excellence Award', '2023',
        'Fast-tracked to production projects in 3 months versus the standard 6-month onboarding timeline through exceptional technical ramp-up.'),
    _AwardData('🚀', 'CI/CD Impact Award', '2023',
        'Recognised for reducing team deployment time by 94% — from 4 hours to 15 minutes — through GitHub Actions and Codemagic pipeline design.'),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 900 ? 4 : w > 600 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              RevealWidget(child: const SectionHeader(
                eyebrow: '// Recognition',
                title: 'Awards &',
                gradientPart: 'Honors',
              )),
              const SizedBox(height: 48),
              _buildGrid(cols),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(int cols) {
    final rows = <Widget>[];
    for (int i = 0; i < _awards.length; i += cols) {
      final rowItems = _awards.sublist(i, (i + cols).clamp(0, _awards.length));
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowItems.asMap().entries.map((e) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? 13 : 0),
              child: RevealWidget(
                delay: Duration(milliseconds: 80 * e.key),
                child: _AwardCard(data: e.value),
              ),
            ),
          )).toList(),
        ),
      ));
    }
    return Column(children: rows);
  }
}

class _AwardCard extends StatefulWidget {
  final _AwardData data;
  const _AwardCard({required this.data});

  @override
  State<_AwardCard> createState() => _AwardCardState();
}

class _AwardCardState extends State<_AwardCard> with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: 0, end: -6).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _floatCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _floatAnim,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _floatAnim.value),
              child: child,
            ),
            child: Text(widget.data.emoji, style: const TextStyle(fontSize: 36)),
          ),
          const SizedBox(height: 10),
          Text(widget.data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 5),
          Text(widget.data.year,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: AppColors.cyan)),
          const SizedBox(height: 7),
          Text(widget.data.desc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, height: 1.55)),
        ],
      ),
    );
  }
}

class _AwardData {
  final String emoji, title, year, desc;
  const _AwardData(this.emoji, this.title, this.year, this.desc);
}
