import 'package:flutter/material.dart';
import '../../../data/models/leaderboard_entry.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries});
  final List<LeaderboardEntry> entries;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries
          .map((e) => ListTile(
                leading: CircleAvatar(child: Text('${e.rank}')),
                title: Text(e.displayName),
                subtitle: Text('${e.completedThisWeek}/${e.scheduledThisWeek}'),
                trailing: Text('🔥 ${e.currentStreak}'),
              ))
          .toList(),
    );
  }
}
