import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/habit_list_item.dart';
import 'package:habitious/ui/habits/view_models/habits_list_view_model.dart';
import '../../../fakes/fake_clock_service.dart';
import '../../../fakes/in_memory_completion_repository.dart';
import '../../../fakes/in_memory_habit_repository.dart';

Habit _mk(String id, HabitStatus status) => Habit(
  id: HabitId(id),
  name: id,
  color: HabitColor.purple,
  icon: HabitIcon.drop,
  schedule: Weekday.values.toSet(),
  reminder: null,
  status: status,
  createdAt: DateTime(2026, 5, 1),
  groupId: null,
);

void main() {
  test('loads habits and exposes them filtered by tab', () async {
    final habits = InMemoryHabitRepository();
    await habits.upsertHabit(_mk('a', HabitStatus.active));
    await habits.upsertHabit(_mk('b', HabitStatus.archived));
    final clock = FakeClockService(DateTime(2026, 5, 27));
    final comps = InMemoryCompletionRepository(
      todayProvider: () => clock.today(),
      habitLookup: habits.findHabit,
    );
    final vm = HabitsListViewModel(habits, comps);
    await vm.load();
    // Give the stream a moment to emit.
    await Future<void>.delayed(Duration.zero);
    expect(vm.items.length, 2);
    vm.switchTab(HabitsTab.active);
    expect(vm.items.map((i) => i.habit.id.value), ['a']);
    vm.switchTab(HabitsTab.archive);
    expect(vm.items.map((i) => i.habit.id.value), ['b']);
  });
}
