import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.darkAccent,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.darkAccent,
        secondary: AppColors.darkAccent,
        surface: AppColors.darkCard,
      ),
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.darkBorder,
      textTheme: _textThemeDark(),
      useMaterial3: true,
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.lightAccent,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.lightAccent,
        secondary: AppColors.lightAccent,
        surface: AppColors.lightCard,
      ),
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightBorder,
      textTheme: _textThemeLight(),
      useMaterial3: true,
    );
  }

  static TextTheme _textThemeDark() {
    return const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, color: AppColors.darkTextPrimary),
      bodyLarge: TextStyle(fontSize: 16,color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
    );
  }

  static TextTheme _textThemeLight() {
    return const TextTheme(
      headlineLarge: TextStyle(fontSize: 28,color: AppColors.lightTextPrimary),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightTextSecondary),
    );
  }
}