import 'package:flutter/material.dart';
import 'package:habitious/features/habits/presentation/pages/habits_page.dart';
import 'package:habitious/features/habits/presentation/widgets/habit_card.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  final bool isDarkMode;

  const App({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HabitsPage(),
    );
  }
}