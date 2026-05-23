import 'package:flutter/material.dart';
import 'package:habitious/core/theme/app_colors.dart';

class StatusButtons extends StatelessWidget {
  const StatusButtons({super.key});

  @override
  Widget build(BuildContext context){
    return Material(
      color: AppColors.darkBackground,
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          StatusButton(label: 'Все', color: AppColors.purple),
          StatusButton(label: 'Активные', color: AppColors.purple),
          StatusButton(label: 'Архив', color: AppColors.purple),
        ],)
      );
  }
}

class StatusButton extends StatelessWidget {
  final String label;
  final Color color;

  const StatusButton({
    super.key,
    required this.label,
    required this.color
  });

    @override
    Widget build(BuildContext context){
      return Material(
        color: AppColors.darkBackground,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(label, style: TextStyle(
              color: AppColors.darkTextPrimary
            ))
            )
        ));
    }
}