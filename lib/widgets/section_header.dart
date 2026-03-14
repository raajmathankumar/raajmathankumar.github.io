import 'package:flutter/material.dart';
import '../main.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String gradientPart;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.gradientPart,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final fullTitle = '$title $gradientPart';
    final start = title.length + 1;

    return Column(
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            color: AppColors.cyan,
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) {
            // Gradient only on the last word
            return LinearGradient(
              colors: [Colors.white, Colors.white, AppColors.blue, AppColors.cyan],
              stops: [
                0,
                start / fullTitle.length,
                start / fullTitle.length,
                1,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            fullTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _titleSize(context),
              fontWeight: FontWeight.w800,
              letterSpacing: -0.02,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.5,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }

  double _titleSize(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    if (w < 500) return 28;
    if (w < 800) return 36;
    return 46;
  }
}
