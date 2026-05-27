import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/habit_icon.dart';
import '../../../l10n/app_localizations.dart';
import '../../core/widgets/habit_icon_badge.dart';

class GroupCompletionHeader extends StatelessWidget {
  const GroupCompletionHeader({
    super.key,
    required this.percent,
    required this.streak,
    required this.color,
    required this.icon,
  });
  final int percent;
  final int streak;
  final HabitColor color;
  final HabitIcon icon;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          HabitIconBadge(color: color, icon: icon, size: 56),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.groupCompletion(percent).replaceAll(' $percent%', ''),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$percent%',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 4),
                  Text(
                    '$streak',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                l.streakDays(streak),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
