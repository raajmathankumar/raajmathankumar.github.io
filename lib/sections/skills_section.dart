import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal_widget.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    _SkillData('📱', 'Mobile · Web · Desktop', AppColors.blue,
        ['Flutter', 'Dart', 'Android', 'iOS', 'Flutter Web', 'Flutter Desktop']),
    _SkillData('⚡', 'State Management', AppColors.cyan,
        ['GetX', 'Riverpod', 'BLoC', 'Provider']),
    _SkillData('🔗', 'Backend & APIs', AppColors.purple,
        ['REST APIs', 'GraphQL', 'WebSocket', 'Node.js', 'Firebase Cloud Functions']),
    _SkillData('🗄️', 'Databases', AppColors.orange,
        ['Firebase Firestore', 'MongoDB', 'SQLite', 'Hive']),
    _SkillData('🚀', 'DevOps & CI/CD', AppColors.green,
        ['GitHub Actions', 'Codemagic', 'AWS CodeCommit']),
    _SkillData('💳', 'In-App Purchases & Payments', Color(0xFF5AC8FA),
        ['IAP iOS', 'IAP Android', 'Auto-Renewable Subs', 'Node.js Cloud Functions', 'Razorpay']),
    _SkillData('🔧', 'SDKs & Integrations', AppColors.red,
        ['Twilio Video', 'Zendesk SDK', 'Zebra RFID', 'Google Maps API', 'Method Channels', 'Push Notifications']),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 900 ? 3 : w > 600 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              RevealWidget(child: const SectionHeader(
                eyebrow: '// Technical Stack',
                title: 'Skills &',
                gradientPart: 'Expertise',
                subtitle: 'Technologies mastered across mobile, web, desktop, backend & DevOps',
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
    for (int i = 0; i < _skills.length; i += cols) {
      final rowItems = _skills.sublist(i, (i + cols).clamp(0, _skills.length));
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems.asMap().entries.map((e) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? 13 : 0),
                  child: RevealWidget(
                    delay: Duration(milliseconds: 100 * e.key),
                    child: _SkillCard(data: e.value),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _SkillCard extends StatelessWidget {
  final _SkillData data;
  const _SkillCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [BoxShadow(color: data.color.withOpacity(0.28), blurRadius: 12)],
            ),
            child: Center(child: Text(data.icon, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(height: 12),
          Text(data.category,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: data.tags.map((t) => _Tag(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatefulWidget {
  final String label;
  const _Tag({required this.label});

  @override
  State<_Tag> createState() => _TagState();
}

class _TagState extends State<_Tag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.blue.withOpacity(0.18) : Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? AppColors.blue.withOpacity(0.38) : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(widget.label,
            style: TextStyle(
              fontSize: 10.5, fontWeight: FontWeight.w500,
              color: _hovered ? Colors.white : AppColors.textSecondary,
            )),
      ),
    );
  }
}

class _SkillData {
  final String icon;
  final String category;
  final Color color;
  final List<String> tags;
  const _SkillData(this.icon, this.category, this.color, this.tags);
}
