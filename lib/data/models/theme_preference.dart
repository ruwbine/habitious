import 'package:flutter/material.dart';

enum ThemePreference {
  system(ThemeMode.system),
  light(ThemeMode.light),
  dark(ThemeMode.dark);

  const ThemePreference(this.mode);
  final ThemeMode mode;
}
