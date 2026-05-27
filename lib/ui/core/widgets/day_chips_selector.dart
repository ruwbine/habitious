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
    final labels = [
      l.weekdayMon,
      l.weekdayTue,
      l.weekdayWed,
      l.weekdayThu,
      l.weekdayFri,
      l.weekdaySat,
      l.weekdaySun,
    ];
    return Wrap(
      spacing: 8,
      children: List.generate(7, (i) {
        final isSelected = selectedDays.contains(i);
        return ChoiceChip(
          label: Text(labels[i]),
          selected: isSelected,
          onSelected: (sel) {
            final next = {...selectedDays};
            if (sel) {
              next.add(i);
            } else {
              next.remove(i);
            }
            onChanged(next);
          },
        );
      }),
    );
  }
}
