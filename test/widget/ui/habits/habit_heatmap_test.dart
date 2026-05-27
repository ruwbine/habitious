import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/widgets/habit_heatmap.dart';

void main() {
  testWidgets('renders cells for each day of the month and reports taps', (
    tester,
  ) async {
    DateTime? tapped;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HabitHeatmap(
            month: DateTime(2026, 5),
            completedDates: {DateTime(2026, 5, 1), DateTime(2026, 5, 2)},
            scheduledDays: Weekday.values.toSet(),
            color: HabitColor.purple,
            onTapDay: (d) => tapped = d,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    await tester.tap(find.text('15'));
    expect(tapped, DateTime(2026, 5, 15));
  });
}
