import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color green = Color(0xFF2E7D32);
  static const Color greenLight = Color(0xFFE8F5E9);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color greyBorder = Color(0xFFE0E0E0);
  static const Color greyText = Color(0xFF757575);
  static const Color background = Color(0xFFF8F8F8);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorSchemeSeed: green,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: greyBorder, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
    );
  }
}
