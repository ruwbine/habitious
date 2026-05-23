import 'package:flutter/material.dart';
import 'package:habitious/core/theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String frequency;
  final Color accentColor;
  final bool isCompleted;
  final VoidCallback onTap;

  const HabitCard({
    super.key,
    required this.title,
    required this.icon,
    required this.frequency,
    required this.accentColor,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.focusColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Icon(Icons.access_alarm),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? accentColor
                        : colorScheme.surfaceContainerHighest,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
              ],),

             Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Display'
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      frequency,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                      ),
                    ),

                    HabitProgressTracker(activeColor: accentColor)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class HabitProgressTracker extends StatefulWidget {
  final int totalDays; // Всего дней (например, 7)
  final int initialCompletedDays; // Сколько уже сделано на старте
  final Color activeColor; // Цвет выполненных дней

  const HabitProgressTracker({
    Key? key,
    this.totalDays = 7,
    this.initialCompletedDays = 0,
    required this.activeColor,
  }) : super(key: key);

  @override
  State<HabitProgressTracker> createState() => _HabitProgressTrackerState();
}

class _HabitProgressTrackerState extends State<HabitProgressTracker> {
  late int completedDays;

  @override
  void initState() {
    super.initState();
    completedDays = widget.initialCompletedDays;
  }

  void _incrementDay() {
    if (completedDays < widget.totalDays) {
      setState(() {
        completedDays++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Сама шкала с полосочками и текстом "X/7 дней"
        Row(
          children: [
            // Строим полосочки динамически
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.totalDays, (index) {
                  // Если текущий индекс меньше выполненных дней — красим в яркий
                  bool isDone = index < completedDays;
                  
                  return Expanded(
                    child: GestureDetector(
                      onTap: _incrementDay, // Нажатие на полоску увеличивает прогресс
                      child: Container(
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: isDone ? widget.activeColor : AppColors.darkBorder, // Серый неактивный
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 12),
            // Текст с прогрессом
            Text(
              '$completedDays/${widget.totalDays} дней',
              style: const TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}