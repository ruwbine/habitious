// lib/ui/core/themes/dark_theme.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

ThemeData buildDarkTheme() {
  const seed = HabitiousColors.brandPurple;
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
    surface: HabitiousColors.darkSurface,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: HabitiousColors.darkBackground,
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: HabitiousColors.textHighEmphasisDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: HabitiousColors.textHighEmphasisDark,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: HabitiousColors.textHighEmphasisDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: HabitiousColors.textHighEmphasisDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: HabitiousColors.textMediumEmphasisDark,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: HabitiousColors.textMediumEmphasisDark,
      ),
    ),
    cardTheme: CardThemeData(
      color: HabitiousColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
