import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/app_preferences.dart';

void main() {
  test('starts with system theme and Russian locale', () {
    final prefs = AppPreferences();
    expect(prefs.themeMode, ThemeMode.system);
    expect(prefs.locale, const Locale('ru'));
  });

  test('setTheme notifies and stores value', () {
    final prefs = AppPreferences();
    var calls = 0;
    prefs.addListener(() => calls++);
    prefs.setTheme(ThemeMode.dark);
    expect(prefs.themeMode, ThemeMode.dark);
    expect(calls, 1);
  });

  test('setLocale notifies and stores value', () {
    final prefs = AppPreferences();
    var calls = 0;
    prefs.addListener(() => calls++);
    prefs.setLocale(const Locale('en'));
    expect(prefs.locale, const Locale('en'));
    expect(calls, 1);
  });
}
