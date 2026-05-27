import '../models/habit.dart';
import '../models/habit_status.dart';
import '../models/typed_ids.dart';

abstract interface class HabitRepository {
  Stream<List<Habit>> watchHabits({HabitStatus? status});
  Future<Habit?> findHabit(HabitId id);
  Future<void> upsertHabit(Habit habit);
  Future<void> archiveHabit(HabitId id);
  Future<void> deleteHabit(HabitId id);
}
