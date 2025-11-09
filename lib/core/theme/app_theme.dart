import 'package:flutter/material.dart';

class AppTheme {
  // Brown Color Palette
  static const Color primaryBrown = Color(0xFF4A3728);
  static const Color accentGold = Color(0xFFD4A574);
  static const Color backgroundCream = Color(0xFFF5F1ED);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2C2416);
  static const Color textSecondary = Color(0xFF6B5D52);
  static const Color badgeGreen = Color(0xFF7A9B6C);
  static const Color badgeOrange = Color(0xFFD4A574);
  static const Color badgeGray = Color(0xFFA89B8F);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryBrown,
    scaffoldBackgroundColor: backgroundCream,
    colorScheme: const ColorScheme.light(
      primary: primaryBrown,
      secondary: accentGold,
      surface: cardWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBrown,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryBrown,
      selectedItemColor: accentGold,
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGold,
        foregroundColor: primaryBrown,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accentGold, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: cardWhite,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static BoxDecoration gradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primaryBrown, Color(0xFF5D4537)],
    ),
  );
}
