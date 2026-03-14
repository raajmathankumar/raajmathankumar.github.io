import 'package:flutter/material.dart';
import 'package:raajmathankumar/sections/awards_section.dart';
import 'package:raajmathankumar/sections/contact_section.dart';
import 'package:raajmathankumar/sections/experience_section.dart';
import 'package:raajmathankumar/sections/hero_section.dart';
import 'package:raajmathankumar/sections/projects_section.dart';
import 'package:raajmathankumar/sections/skills_section.dart';
import 'package:raajmathankumar/widgets/animated_bg.dart';
import 'package:raajmathankumar/widgets/nav_bar.dart';
import 'main.dart';


class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());
  int _activeSection = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero);
        if (pos.dy <= 140) {
          if (_activeSection != i) setState(() => _activeSection = i);
          break;
        }
      }
    }
  }

  void scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Animated gradient background
          const AnimatedBg(),

          // Main scroll content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(key: _sectionKeys[0], onViewWork: () => scrollToSection(3), onContact: () => scrollToSection(5)),
                SkillsSection(key: _sectionKeys[1]),
                ExperienceSection(key: _sectionKeys[2]),
                ProjectsSection(key: _sectionKeys[3]),
                AwardsSection(key: _sectionKeys[4]),
                ContactSection(key: _sectionKeys[5]),
                _buildFooter(),
              ],
            ),
          ),

          // Floating nav bar
          Positioned(
            top: 14,
            left: 0,
            right: 0,
            child: Center(
              child: NavBar(
                activeIndex: _activeSection,
                onTap: scrollToSection,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0x10FFFFFF))),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, fontFamily: 'Sora'),
          children: [
            const TextSpan(text: 'Crafted with 💙 by '),
            const TextSpan(text: 'Raaj Mathan Kumar', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600)),
            const TextSpan(text: ' · Senior Flutter Developer · Chennai · Built with Flutter Web'),
          ],
        ),
      ),
    );
  }
}
