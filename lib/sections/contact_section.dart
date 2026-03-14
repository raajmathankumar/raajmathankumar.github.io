import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal_widget.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static final _contacts = [
    _ContactData('📧', 'Email', 'raajmathankumar@gmail.com', 'mailto:raajmathankumar@gmail.com', AppColors.blue),
    _ContactData('📞', 'Mobile', '+91 7358998293', 'tel:+917358998293', AppColors.green),
    _ContactData('💼', 'LinkedIn', 'raaj-mathan-kumar-465030182', 'https://www.linkedin.com/in/raaj-mathan-kumar-465030182/', AppColors.cyan),
    _ContactData('📍', 'Location', 'Chennai, Tamil Nadu, India', null, AppColors.red),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 700 ? 2 : 1;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 80, 24, 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            children: [
              RevealWidget(child: const SectionHeader(
                eyebrow: "// Let's Connect",
                title: 'Get In',
                gradientPart: 'Touch',
                subtitle: 'Open to exciting Flutter & cross-platform opportunities globally',
              )),
              const SizedBox(height: 28),

              // Flutter web note
              RevealWidget(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.blue.withOpacity(0.22)),
                  ),
                  child: Row(
                    children: [
                      const Text('💙', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary, height: 1.5),
                            children: [
                              TextSpan(text: 'This portfolio is built with '),
                              TextSpan(text: 'Flutter Web', style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w600)),
                              TextSpan(text: ' — built by a Flutter developer, for a Flutter developer. '),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Contact grid
              _buildGrid(cols),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(int cols) {
    final rows = <Widget>[];
    for (int i = 0; i < _contacts.length; i += cols) {
      final rowItems = _contacts.sublist(i, (i + cols).clamp(0, _contacts.length));
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Row(
          children: rowItems.asMap().entries.map((e) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? 13 : 0),
              child: RevealWidget(
                delay: Duration(milliseconds: 80 * (i + e.key)),
                child: _ContactCard(data: e.value),
              ),
            ),
          )).toList(),
        ),
      ));
    }
    return Column(children: rows);
  }
}

class _ContactCard extends StatefulWidget {
  final _ContactData data;
  const _ContactCard({required this.data});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final hasUrl = widget.data.url != null;
    return MouseRegion(
      cursor: hasUrl ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit: (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: GestureDetector(
        onTap: hasUrl ? () => launchUrl(Uri.parse(widget.data.url!), mode: LaunchMode.externalApplication) : null,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, -4 * _ctrl.value),
            child: child,
          ),
          child: GlassCard(
            hoverable: false,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(
                    color: widget.data.color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [BoxShadow(color: widget.data.color.withOpacity(0.18), blurRadius: 14)],
                  ),
                  child: Center(child: Text(widget.data.icon, style: const TextStyle(fontSize: 18))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.label,
                          style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, letterSpacing: 0.1, color: AppColors.textSecondary)),
                      const SizedBox(height: 3),
                      Text(widget.data.value,
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactData {
  final String icon, label, value;
  final String? url;
  final Color color;
  const _ContactData(this.icon, this.label, this.value, this.url, this.color);
}
