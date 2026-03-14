import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal_widget.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const _bullets = [
    'Developed and published 5 production Flutter apps on App Store & Play Store across Android, iOS, Web and Desktop — serving 50K+ users with an average 4.3★ rating.',
    'Integrated REST APIs, GraphQL endpoints and WebSocket services enabling real-time data sync across 5+ microservices.',
    'Built complete In-App Purchase flows for iOS & Android including auto-renewable subscriptions with server-side receipt validation via Node.js Cloud Functions.',
    'Implemented CI/CD pipelines using GitHub Actions and Codemagic, reducing deployment time from 4 hours to 15 minutes — a 94% improvement.',
    'Optimised performance using lazy loading and advanced state management (GetX, Riverpod, BLoC, Provider), improving load times by 45%.',
    'Worked with MongoDB and Firebase Firestore for cloud persistence; SQLite and Hive for offline-first data handling.',
    'Collaborated in Agile sprints with backend engineers and designers, delivering 20+ features within roadmaps.',
    'Mentored junior developers, conducted code reviews and enforced Flutter best practices team-wide.',
  ];

  static const _metrics = [
    '5 Published Apps',
    '50K+ Users',
    '4h → 15min Deploy',
    '45% Load Time ↓',
    'Senior · Jul 2024',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              RevealWidget(child: const SectionHeader(
                eyebrow: '// Career',
                title: 'Work',
                gradientPart: 'Experience',
              )),
              const SizedBox(height: 48),
              RevealWidget(
                delay: const Duration(milliseconds: 100),
                child: GlassCard(
                  padding: const EdgeInsets.all(34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildDuration(),
                      const SizedBox(height: 18),
                      ..._bullets.map((b) => _BulletItem(text: b)),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: _metrics.map((m) => _MetricChip(label: m)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 16, runSpacing: 12,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Senior Flutter Developer',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            SizedBox(height: 4),
            Text('Datayaan Solutions Private Limited · Chennai, Tamil Nadu',
                style: TextStyle(fontSize: 13, color: AppColors.cyan, fontWeight: FontWeight.w500)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.green.withOpacity(0.14),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.green.withOpacity(0.28)),
          ),
          child: const Text('🟢 Current Role',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.green)),
        ),
      ],
    );
  }

  Widget _buildDuration() {
    return Text(
      '📅  July 2021 – Present  ·  Promoted to Senior Engineer · Jul 2024',
      style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.textSecondary),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 6, height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.blue, AppColors.cyan]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 13, color: Color(0xAAFFFFFF), height: 1.65)),
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label;
  const _MetricChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.blue.withOpacity(0.22)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.cyan)),
    );
  }
}
