import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../l10n/app_localizations.dart';
import '../../habits/view_models/habit_list_item.dart';
import 'habit_icon_badge.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
  });
  final HabitListItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HabitIconBadge(
                    color: item.habit.color,
                    icon: item.habit.icon,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.habit.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${item.participantsCount} ${l.myFriends.toLowerCase()}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    l.weekProgress(
                      item.progress.completedDays,
                      item.progress.scheduledDays,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _WeeklyDotsStrip(
                color: item.habit.color,
                completed: item.progress.completedDays,
                scheduled: item.progress.scheduledDays,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeeklyDotsStrip extends StatelessWidget {
  const _WeeklyDotsStrip({
    required this.color,
    required this.completed,
    required this.scheduled,
  });

  final HabitColor color;
  final int completed;
  final int scheduled;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final c = color.value;
    return Row(
      children: List.generate(7, (i) {
        final isCompleted = i < completed;
        final isScheduled = i < scheduled;
        final Color fill;
        if (isCompleted) {
          fill = c;
        } else if (isScheduled) {
          fill = c.withValues(alpha: 0.25);
        } else {
          fill = cs.surfaceContainerHighest;
        }
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == 6 ? 0 : 4),
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      }),
    );
  }
}
