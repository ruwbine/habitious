import 'package:drift/drift.dart';

import '../models/habit.dart';
import '../models/habit_color.dart';
import '../models/habit_icon.dart';
import '../models/habit_status.dart';
import '../models/reminder_time.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';
import '../services/app_database.dart';
import 'habit_repository.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Habit>> watchHabits({HabitStatus? status}) {
    final query = _db.select(_db.habits);
    if (status != null) {
      query.where((tbl) => tbl.statusIndex.equals(status.index));
    }
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Future<Habit?> findHabit(HabitId id) async {
    final row = await (_db.select(_db.habits)
          ..where((t) => t.id.equals(id.value)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<void> upsertHabit(Habit habit) async {
    await _db.into(_db.habits).insertOnConflictUpdate(_toCompanion(habit));
  }

  @override
  Future<void> archiveHabit(HabitId id) async {
    await (_db.update(_db.habits)..where((t) => t.id.equals(id.value)))
        .write(HabitsCompanion(statusIndex: Value(HabitStatus.archived.index)));
  }

  @override
  Future<void> deleteHabit(HabitId id) async {
    await (_db.delete(_db.habits)..where((t) => t.id.equals(id.value))).go();
  }

  Habit _fromRow(HabitRow row) => Habit(
    id: HabitId(row.id),
    name: row.name,
    color: HabitColor.values[row.colorIndex],
    icon: HabitIcon.values[row.iconIndex],
    schedule: Weekday.fromMask(row.scheduleBitmask),
    reminder: (row.reminderMinutes == null || !row.reminderEnabled)
        ? null
        : ReminderTime(
            hour: row.reminderMinutes! ~/ 60,
            minute: row.reminderMinutes! % 60,
          ),
    status: HabitStatus.values[row.statusIndex],
    createdAt: row.createdAt,
    groupId: row.groupId == null ? null : GroupId(row.groupId!),
  );

  HabitsCompanion _toCompanion(Habit h) => HabitsCompanion.insert(
    id: h.id.value,
    name: h.name,
    colorIndex: h.color.index,
    iconIndex: h.icon.index,
    scheduleBitmask: Weekday.toMask(h.schedule),
    reminderMinutes: h.reminder == null
        ? const Value.absent()
        : Value(h.reminder!.hour * 60 + h.reminder!.minute),
    reminderEnabled: Value(h.reminder != null),
    statusIndex: h.status.index,
    createdAt: h.createdAt,
    groupId: h.groupId == null ? const Value.absent() : Value(h.groupId!.value),
  );
}
