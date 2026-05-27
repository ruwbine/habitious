// lib/ui/core/themes/light_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_tokens.dart';

ThemeData buildLightTheme() {
  const seed = HabitiousColors.brandPurple;
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
    surface: HabitiousColors.lightSurface,
  );
  const onSurface = HabitiousColors.textHighEmphasisLight;
  const onSurfaceMuted = HabitiousColors.textMediumEmphasisLight;
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme.copyWith(
      primary: HabitiousColors.brandPurple,
      surface: HabitiousColors.lightSurface,
      surfaceContainerHighest: HabitiousColors.lightSurfaceAlt,
    ),
    scaffoldBackgroundColor: HabitiousColors.lightBackground,
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
      color: HabitiousColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: HabitiousColors.lightBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: onSurface,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: onSurface),
    dividerTheme: const DividerThemeData(
      color: HabitiousColors.lightSurfaceAlt,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: HabitiousColors.lightSurfaceAlt,
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
