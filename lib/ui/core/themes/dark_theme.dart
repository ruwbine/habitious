// lib/ui/core/themes/dark_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_tokens.dart';

ThemeData buildDarkTheme() {
  const seed = HabitiousColors.brandPurple;
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
    surface: HabitiousColors.darkSurface,
  );
  const onSurface = HabitiousColors.textHighEmphasisDark;
  const onSurfaceMuted = HabitiousColors.textMediumEmphasisDark;
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme.copyWith(
      primary: HabitiousColors.brandPurple,
      surface: HabitiousColors.darkSurface,
      surfaceContainerHighest: HabitiousColors.darkSurfaceAlt,
    ),
    scaffoldBackgroundColor: HabitiousColors.darkBackground,
  );
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
      headlineLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceMuted,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: onSurfaceMuted,
      ),
    ),
    cardTheme: CardThemeData(
      color: HabitiousColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: HabitiousColors.darkBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: onSurface,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: onSurface),
    dividerTheme: const DividerThemeData(
      color: HabitiousColors.darkSurfaceAlt,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: HabitiousColors.darkSurfaceAlt,
      hintStyle: GoogleFonts.inter(color: onSurfaceMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: HabitiousColors.brandPurple,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),
  );
}
