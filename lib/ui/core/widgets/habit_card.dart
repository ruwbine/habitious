import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../habits/view_models/habit_list_item.dart';
import 'habit_icon_badge.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.item, this.onTap, this.onLongPress});
  final HabitListItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              HabitIconBadge(color: item.habit.color, icon: item.habit.icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.habit.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('${item.participantsCount} ${l.myFriends.toLowerCase()}', style: Theme.of(context).textTheme.bodyMedium),
                ]),
              ),
              Text(l.weekProgress(item.progress.completedDays, item.progress.scheduledDays),
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
