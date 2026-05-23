import 'package:flutter/material.dart';
import 'package:habitious/core/theme/app_colors.dart';
import 'package:habitious/core/theme/app_theme.dart';
import 'package:habitious/features/habits/presentation/widgets/habit_card.dart';
import 'package:habitious/features/habits/presentation/widgets/status_buttons.dart';
import 'package:habitious/shared/widgets/bottom_navigation_bar.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои привычки', style: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 30,
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w500,
          )
        ),
        actions: [
          Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(10)
          ),
          child: IconButton(
            icon: Icon(Icons.notifications, color: AppColors.lightBorder),
            padding: EdgeInsets.zero,
            onPressed: () => "Meow",
          )
        ),
          Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(10)
          ),
          child: IconButton(
            icon: Icon(Icons.add, color: AppColors.lightBorder),
            padding: EdgeInsets.zero,
            onPressed: () => "Meow",
          )
        ),
        ], 
        backgroundColor: AppColors.darkBackground,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            spacing: 15,
            children: [
              StatusButtons(),
              HabitCard(
                accentColor: AppColors.lightAccent,
                title: 'Пить воду',
                icon: Icon(Icons.water),
                frequency: 'daily',
                onTap:() => 'meow',
                isCompleted: false, ),
                HabitCard(
                accentColor: AppColors.lightAccent,
                title: 'Пить воду',
                icon: Icon(Icons.water),
                frequency: 'daily',
                onTap:() => 'meow',
                isCompleted: false, ),
                HabitCard(
                accentColor: AppColors.lightAccent,
                title: 'Пить воду',
                icon: Icon(Icons.water),
                frequency: 'daily',
                onTap:() => 'meow',
                isCompleted: false, )
            ],),
      )),
      bottomNavigationBar: AppBottomBar(currentIndex: 0)
    );
  }
} 