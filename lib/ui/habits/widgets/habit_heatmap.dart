import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/weekday.dart';

class HabitHeatmap extends StatelessWidget {
  const HabitHeatmap({
    super.key,
    required this.month,
    required this.completedDates,
    required this.scheduledDays,
    required this.color,
    required this.onTapDay,
  });

  final DateTime month; // any day inside the visible month
  final Set<DateTime> completedDates;
  final Set<Weekday> scheduledDays;
  final HabitColor color;
  final ValueChanged<DateTime> onTapDay;

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = (firstOfMonth.weekday - DateTime.monday) % 7;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: leadingBlanks + daysInMonth,
      itemBuilder: (_, i) {
        if (i < leadingBlanks) return const SizedBox.shrink();
        final dayNumber = i - leadingBlanks + 1;
        final day = DateTime(month.year, month.month, dayNumber);
        final dow = Weekday.values[(day.weekday - 1)];
        final isScheduled = scheduledDays.contains(dow);
        final isCompleted = completedDates.any(
          (d) => d.year == day.year && d.month == day.month && d.day == day.day,
        );
        final bg = !isScheduled
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : isCompleted
            ? color.value
            : color.value.withValues(alpha: 0.18);
        return InkWell(
          onTap: () => onTapDay(day),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              '$dayNumber',
              style: TextStyle(
                color: isCompleted ? Colors.white : null,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }
}
