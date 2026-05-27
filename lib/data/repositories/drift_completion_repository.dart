import 'package:drift/drift.dart';

import '../models/date_range.dart';
import '../models/habit.dart';
import '../models/habit_color.dart';
import '../models/habit_icon.dart';
import '../models/habit_status.dart';
import '../models/streak_info.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';
import '../models/weekly_progress.dart';
import '../services/app_database.dart';
import '../services/clock_service.dart';
import 'completion_repository.dart';

class DriftCompletionRepository implements CompletionRepository {
  DriftCompletionRepository(this._db, this._clock);
  final AppDatabase _db;
  final ClockService _clock;

  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range) {
    final q = _db.select(_db.habitCompletions)
      ..where(
        (t) =>
            t.habitId.equals(id.value) &
            t.date.isBiggerOrEqualValue(range.startInclusive) &
            t.date.isSmallerThanValue(range.endExclusive),
      );
    return q.watch().map((rows) => rows.map((r) => _normalize(r.date)).toSet());
  }

  @override
  Future<bool> isCompleted(HabitId id, DateTime date) async {
    final r = await (_db.select(_db.habitCompletions)
          ..where(
            (t) =>
                t.habitId.equals(id.value) &
                t.date.equals(_normalize(date)),
          ))
        .getSingleOrNull();
    return r != null;
  }

  @override
  Future<void> markCompleted(HabitId id, DateTime date) async {
    await _db.into(_db.habitCompletions).insertOnConflictUpdate(
      HabitCompletionsCompanion.insert(
        habitId: id.value,
        date: _normalize(date),
        markedAt: _clock.now(),
      ),
    );
  }

  @override
  Future<void> unmarkCompleted(HabitId id, DateTime date) async {
    await (_db.delete(_db.habitCompletions)
          ..where(
            (t) =>
                t.habitId.equals(id.value) &
                t.date.equals(_normalize(date)),
          ))
        .go();
  }

  @override
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore}) async {
    final habit = await _fetchHabit(id);
    if (habit == null) {
      return const StreakInfo(
        currentStreak: 0,
        longestStreak: 0,
        freezesRemainingThisWeek: 0,
      );
    }
    final completions = await _allDates(id);
    return computeStreakPure(
      schedule: habit.schedule,
      completions: completions,
      today: _clock.today(),
      hardcore: hardcore,
    );
  }

  @override
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    final start = _startOfWeek(_clock.today());
    final end = start.add(const Duration(days: 7));
    await for (final dates in watchCompletionDates(
      id,
      DateRange(start, end),
    )) {
      final habit = await _fetchHabit(id);
      if (habit == null) {
        yield const WeeklyProgress(completedDays: 0, scheduledDays: 0);
        continue;
      }
      yield WeeklyProgress(
        completedDays: dates.length,
        scheduledDays: habit.schedule.length,
      );
    }
  }

  Future<Habit?> _fetchHabit(HabitId id) async {
    final row = await (_db.select(_db.habits)
          ..where((t) => t.id.equals(id.value)))
        .getSingleOrNull();
    if (row == null) return null;
    return Habit(
      id: HabitId(row.id),
      name: row.name,
      color: HabitColor.values[row.colorIndex],
      icon: HabitIcon.values[row.iconIndex],
      schedule: Weekday.fromMask(row.scheduleBitmask),
      reminder: null,
      status: HabitStatus.values[row.statusIndex],
      createdAt: row.createdAt,
      groupId: null,
    );
  }

  Future<Set<DateTime>> _allDates(HabitId id) async {
    final rows = await (_db.select(_db.habitCompletions)
          ..where((t) => t.habitId.equals(id.value)))
        .get();
    return rows.map((r) => _normalize(r.date)).toSet();
  }

  DateTime _startOfWeek(DateTime day) {
    final delta = (day.weekday - DateTime.monday) % 7;
    return day.subtract(Duration(days: delta));
  }
}

/// Pure function — exposed for direct unit testing.
StreakInfo computeStreakPure({
  required Set<Weekday> schedule,
  required Set<DateTime> completions,
  required DateTime today,
  required bool hardcore,
}) {
  int currentStreak = 0;
  int longestStreak = 0;
  int? lastWeekStartEpoch;

  // Walk back through scheduled days only.
  bool streakStillRunning = true;
  var cursor = today.subtract(const Duration(days: 1));
  int freezesAvailableThisWeek = hardcore ? 0 : 1;

  for (int i = 0; i < 365 && streakStillRunning; i++) {
    final dayOfWeek = Weekday.values[cursor.weekday - 1];
    final weekStart = cursor.subtract(
      Duration(days: (cursor.weekday - DateTime.monday) % 7),
    );
    final weekStartEpoch = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    ).millisecondsSinceEpoch;

    if (lastWeekStartEpoch != null && weekStartEpoch != lastWeekStartEpoch) {
      // Crossed a week boundary walking backward — reset freeze budget for the
      // new (older) week.
      freezesAvailableThisWeek = hardcore ? 0 : 1;
    }
    lastWeekStartEpoch = weekStartEpoch;

    if (schedule.contains(dayOfWeek)) {
      final completed = completions.any(
        (d) =>
            d.year == cursor.year &&
            d.month == cursor.month &&
            d.day == cursor.day,
      );
      if (completed) {
        currentStreak++;
        if (currentStreak > longestStreak) longestStreak = currentStreak;
      } else if (hardcore) {
        streakStillRunning = false;
      } else if (freezesAvailableThisWeek > 0) {
        freezesAvailableThisWeek--;
      } else {
        streakStillRunning = false;
      }
    }
    cursor = cursor.subtract(const Duration(days: 1));
  }

  // Report the user's CURRENT-week freeze budget (not the historical walk's).
  return StreakInfo(
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    freezesRemainingThisWeek: hardcore ? 0 : 1,
  );
}
