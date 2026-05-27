import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/weekday.dart';
import '../../../l10n/app_localizations.dart';

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
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = (firstOfMonth.weekday - DateTime.monday) % 7;
    final weekdayLabels = [
      l.weekdayMon,
      l.weekdayTue,
      l.weekdayWed,
      l.weekdayThu,
      l.weekdayFri,
      l.weekdaySat,
      l.weekdaySun,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(7, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == 6 ? 0 : 4),
                child: Center(
                  child: Text(
                    weekdayLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        GridView.builder(
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
              (d) =>
                  d.year == day.year &&
                  d.month == day.month &&
                  d.day == day.day,
            );
            final Color bg;
            if (!isScheduled) {
              bg = cs.surfaceContainerHighest.withValues(alpha: 0.35);
            } else if (isCompleted) {
              bg = color.value;
            } else {
              bg = cs.surfaceContainerHighest;
            }
            return InkWell(
              onTap: () => onTapDay(day),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
