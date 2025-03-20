import 'package:flutter/material.dart';
import 'colors.dart';
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary, // Main color theme
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.text,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 16),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.navigation, // Change to desired color
      selectedItemColor: AppColors.text, // Color of selected item
      unselectedItemColor: AppColors.text, // Color of unselected items
    ),

  );
}
