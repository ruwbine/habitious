import 'package:flutter/material.dart';
import 'package:habitious/core/theme/app_colors.dart';
import 'package:habitious/features/habits/presentation/widgets/habit_card.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HabitCard(
          title: "Сиськи",
          frequency: "1 3 5 7",
          accentColor: AppColors.green,
          icon: "❤️",
          isCompleted: false,
          onTap: () {},
        ),
      ),
    );
  }
} 