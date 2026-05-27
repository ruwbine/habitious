import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/habit_detail_view_model.dart';
import '../../../fakes/fake_clock_service.dart';
import '../../../fakes/in_memory_completion_repository.dart';
import '../../../fakes/in_memory_habit_repository.dart';

void main() {
  test('toggles day and refreshes month completions', () async {
    final habits = InMemoryHabitRepository();
    const habitId = HabitId('h1');
    await habits.upsertHabit(Habit(
      id: habitId,
      name: 'Drink',
      color: HabitColor.purple,
      icon: HabitIcon.drop,
      schedule: Weekday.values.toSet(),
      reminder: null,
      status: HabitStatus.active,
      createdAt: DateTime(2026, 5, 1),
      groupId: null,
    ));
    final clock = FakeClockService(DateTime(2026, 5, 27));
    final comps = InMemoryCompletionRepository(
      todayProvider: () => clock.today(),
      habitLookup: habits.findHabit,
    );

    final vm = HabitDetailViewModel(
      habits,
      comps,
      clock,
      habitId: habitId,
      hardcoreProvider: () => false,
    );
    await vm.load();
    await vm.toggleDayCommand.run(DateTime(2026, 5, 26));
    // Give the stream time to emit.
    await Future<void>.delayed(Duration.zero);
    expect(vm.monthCompletions.contains(DateTime(2026, 5, 26)), isTrue);
    await vm.toggleDayCommand.run(DateTime(2026, 5, 26));
    await Future<void>.delayed(Duration.zero);
    expect(vm.monthCompletions.contains(DateTime(2026, 5, 26)), isFalse);
  });
}
