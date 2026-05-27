import 'package:flutter/material.dart';
import '../../../data/models/leaderboard_entry.dart';
import '../../../l10n/app_localizations.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries});
  final List<LeaderboardEntry> entries;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: List.generate(entries.length, (i) {
          final e = entries[i];
          final isLast = i == entries.length - 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                  child: Text(
                    '${e.rank}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: cs.surfaceContainerHighest,
                  child: Text(
                    e.displayName.isNotEmpty
                        ? e.displayName.characters.first
                        : '?',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    e.displayName,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                  ),
                ),
                Text(
                  l.weekProgress(e.completedThisWeek, e.scheduledThisWeek),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '🔥 ${e.currentStreak}',
                  style: const TextStyle(fontSize: 13),
                ),
                if (!isLast) const SizedBox(height: 1),
              ],
            ),
          );
        }),
      ),
    );
  }
}
