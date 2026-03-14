import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal_widget.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final _projects = [
    _ProjectData(
      icon: '💰',
      title: 'EnExpense',
      subtitle: 'AI Personal Finance Tracker',
      region: '🇲🇾 Malaysia',
      regionColor: AppColors.orange,
      glowColor: AppColors.blue,
      desc: 'Subscription-based AI expense tracker with ML receipt scanning & OCR, SQLite offline storage, recurring expense management and full In-App Purchase flows (iOS & Android) with auto-renewable subscriptions via Node.js Cloud Functions.',
      tech: ['Flutter', 'ML / OCR', 'SQLite', 'Node.js', 'IAP iOS', 'IAP Android', 'Auto-Renewable'],
      androidUrl: 'https://play.google.com/store/apps/details?id=com.enexpense.com',
      iosUrl: null,
    ),
    _ProjectData(
      icon: '🚗',
      title: 'Yaantrac',
      subtitle: 'Real-time Vehicle Tracking',
      region: '📦 Product',
      regionColor: AppColors.purple,
      glowColor: AppColors.purple,
      desc: 'Real-time vehicle tracking and route optimisation with WebSocket, Google Maps API geofencing, background location services and Firebase push notifications for live status alerts.',
      tech: ['Flutter', 'WebSocket', 'Google Maps API', 'Geofencing', 'Firebase'],
      androidUrl: 'https://play.google.com/store/apps/details?id=com.datayaan.tracking',
      iosUrl: 'https://apps.apple.com/in/app/yaantrac/id1440080726',
    ),
    _ProjectData(
      icon: '🏥',
      title: 'MedYaan Health',
      subtitle: 'Telemedicine & Healthcare',
      region: '🇦🇪 UAE',
      regionColor: AppColors.cyan,
      glowColor: AppColors.cyan,
      desc: 'Telemedicine platform enabling patients to book and attend video consultations with doctors. Integrated Twilio Video SDK for live consultations and Razorpay for secure appointment payment processing.',
      tech: ['Flutter', 'Twilio Video SDK', 'Razorpay', 'Telemedicine', 'Firebase'],
      androidUrl: 'https://play.google.com/store/apps/details?id=com.app.vogo_health',
      iosUrl: 'https://apps.apple.com/in/app/medyaan-health/id6746411425',
    ),
    _ProjectData(
      icon: '💪',
      title: 'Athics',
      subtitle: 'Fitness Chain Member App',
      region: '🇮🇳 India',
      regionColor: AppColors.green,
      glowColor: AppColors.green,
      desc: 'Gym member management serving 1500+ active members across 6 Chennai locations. Local SQLite for offline workout plans with Firebase real-time sync and live member data across all branches.',
      tech: ['Flutter', 'SQLite', 'Firebase', '1500+ Members', '6 Locations'],
      androidUrl: 'https://play.google.com/store/apps/details?id=com.fitness.athics',
      iosUrl: 'https://apps.apple.com/in/app/athics/id6739993893',
    ),
    _ProjectData(
      icon: '🗺️',
      title: 'Autoplanner Driver',
      subtitle: 'Driver Route Planning App',
      region: '📦 Product',
      regionColor: AppColors.purple,
      glowColor: AppColors.orange,
      desc: 'Driver-side companion to Yaantrac for automated route planning and delivery management. Real-time location tracking, route assignment and status updates via WebSocket integration.',
      tech: ['Flutter', 'WebSocket', 'Google Maps API', 'Background Location', 'Firebase'],
      androidUrl: 'https://play.google.com/store/apps/details?id=com.tracking.autoplanner',
      iosUrl: 'https://apps.apple.com/in/app/yaantrac-autoplanner/id6754154398',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 900 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              RevealWidget(child: const SectionHeader(
                eyebrow: '// Published Apps',
                title: 'Live on',
                gradientPart: 'App Stores',
                subtitle: '5 published apps available on App Store & Google Play',
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
    for (int i = 0; i < _projects.length; i += cols) {
      final rowItems = _projects.sublist(i, (i + cols).clamp(0, _projects.length));
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems.asMap().entries.map((e) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? 16 : 0),
                  child: RevealWidget(
                    delay: Duration(milliseconds: 100 * e.key),
                    child: _ProjectCard(data: e.value),
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

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;
  const _ProjectCard({required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _lift;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _lift = Tween<double>(begin: 0, end: -8).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: AnimatedBuilder(
        animation: _lift,
        builder: (_, child) => Transform.translate(offset: Offset(0, _lift.value), child: child),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // Glow
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: _hovered ? -20 : 10,
                right: _hovered ? -10 : 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _hovered ? 0.26 : 0,
                  child: Container(
                    width: 170, height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.data.glowColor,
                    ),
                  ),
                ),
              ),
              // Card
              GlassCard(
                hoverable: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.data.icon, style: const TextStyle(fontSize: 26)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.data.regionColor.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: widget.data.regionColor.withOpacity(0.28)),
                          ),
                          child: Text(widget.data.region,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: widget.data.regionColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(widget.data.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(widget.data.subtitle,
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 12),
                    Text(widget.data.desc,
                        style: const TextStyle(fontSize: 12.5, color: Color(0xA0FFFFFF), height: 1.65)),
                    const SizedBox(height: 14),
                    Wrap(spacing: 5, runSpacing: 5,
                        children: widget.data.tech.map((t) => _TechTag(label: t)).toList()),
                    const SizedBox(height: 16),
                    // Store buttons
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      if (widget.data.iosUrl != null)
                        _StoreButton(label: 'App Store', icon: '🍎', url: widget.data.iosUrl!, isIos: true),
                      if (widget.data.androidUrl != null)
                        _StoreButton(label: 'Google Play', icon: '▶', url: widget.data.androidUrl!, isIos: false),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, color: Color(0x99FFFFFF))),
    );
  }
}

class _StoreButton extends StatefulWidget {
  final String label;
  final String icon;
  final String url;
  final bool isIos;
  const _StoreButton({required this.label, required this.icon, required this.url, required this.isIos});

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -1 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: widget.isIos
                ? Colors.white.withOpacity(_hovered ? 0.13 : 0.07)
                : AppColors.green.withOpacity(_hovered ? 0.18 : 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isIos
                  ? Colors.white.withOpacity(0.16)
                  : AppColors.green.withOpacity(0.28),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.icon, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 6),
              Text(widget.label,
                  style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600,
                    color: widget.isIos ? Colors.white.withOpacity(0.82) : AppColors.green,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectData {
  final String icon, title, subtitle, region, desc;
  final Color regionColor, glowColor;
  final List<String> tech;
  final String? androidUrl, iosUrl;

  const _ProjectData({
    required this.icon, required this.title, required this.subtitle,
    required this.region, required this.regionColor, required this.glowColor,
    required this.desc, required this.tech,
    required this.androidUrl, required this.iosUrl,
  });
}
