import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/reminder_time.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/create_habit_view_model.dart';
import '../../../fakes/in_memory_habit_repository.dart';

void main() {
  test('canSubmit requires non-empty name and at least one weekday', () {
    final vm = CreateHabitViewModel(InMemoryHabitRepository());
    expect(vm.canSubmit, isFalse);
    vm.setName('Drink water');
    expect(vm.canSubmit, isTrue);
    vm.setSchedule(<Weekday>{});
    expect(vm.canSubmit, isFalse);
  });

  test('submit persists a habit with the chosen fields', () async {
    final habits = InMemoryHabitRepository();
    final vm = CreateHabitViewModel(habits);
    vm.setName('Drink water');
    vm.setColor(HabitColor.teal);
    vm.setIcon(HabitIcon.drop);
    vm.setReminder(const ReminderTime(hour: 9, minute: 0));
    final id = await vm.submitCommand.run(null);
    expect(id, isNotNull);
    final saved = await habits.findHabit(id!);
    expect(saved!.name, 'Drink water');
    expect(saved.color, HabitColor.teal);
    expect(saved.reminder, const ReminderTime(hour: 9, minute: 0));
  });
}
