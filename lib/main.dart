import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raaj Mathan Kumar — Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.soraTextTheme(
          ThemeData.dark().textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.blue,
          secondary: AppColors.cyan,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class AppColors {
  static const bg = Color(0xFF04040F);
  static const bg2 = Color(0xFF08081A);
  static const blue = Color(0xFF007AFF);
  static const cyan = Color(0xFF32D6FE);
  static const purple = Color(0xFFBF5AF2);
  static const green = Color(0xFF30D158);
  static const orange = Color(0xFFFF9F0A);
  static const red = Color(0xFFFF453A);
  static const textPrimary = Color(0xF2FFFFFF);
  static const textSecondary = Color(0x88FFFFFF);
  static const glassBg = Color(0x14FFFFFF);
  static const glassBorder = Color(0x2AFFFFFF);
}
