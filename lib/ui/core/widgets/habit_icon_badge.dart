import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/habit_icon.dart';

class HabitIconBadge extends StatelessWidget {
  const HabitIconBadge({super.key, required this.color, required this.icon, this.size = 48});
  final HabitColor color;
  final HabitIcon icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.value.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(icon.iconData, color: color.value, size: size * 0.55),
    );
  }
}
