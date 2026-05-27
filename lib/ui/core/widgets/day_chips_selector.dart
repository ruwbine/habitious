import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Indexes: 0=Mon ... 6=Sun.
class DayChipsSelector extends StatelessWidget {
  const DayChipsSelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  final Set<int> selectedDays;
  final ValueChanged<Set<int>> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final labels = [
      l.weekdayMon,
      l.weekdayTue,
      l.weekdayWed,
      l.weekdayThu,
      l.weekdayFri,
      l.weekdaySat,
      l.weekdaySun,
    ];
    return Row(
      children: List.generate(7, (i) {
        final isSelected = selectedDays.contains(i);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == 6 ? 0 : 6),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final next = {...selectedDays};
                if (isSelected) {
                  next.remove(i);
                } else {
                  next.add(i);
                }
                onChanged(next);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? cs.primary
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? cs.onPrimary
                        : cs.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
