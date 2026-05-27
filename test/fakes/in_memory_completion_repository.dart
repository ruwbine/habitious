import 'dart:async';
import 'package:habitious/data/models/date_range.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/streak_info.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekly_progress.dart';
import 'package:habitious/data/repositories/completion_repository.dart';
import 'package:habitious/data/repositories/drift_completion_repository.dart'
    show computeStreakPure;

class InMemoryCompletionRepository implements CompletionRepository {
  InMemoryCompletionRepository({
    required this.todayProvider,
    required this.habitLookup,
  });
  final DateTime Function() todayProvider;
  final Future<Habit?> Function(HabitId id) habitLookup;
  final Map<HabitId, Set<DateTime>> _dates = {};
  final StreamController<HabitId> _events = StreamController.broadcast();

  DateTime _norm(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range) async* {
    yield _filter(id, range);
    yield* _events.stream
        .where((x) => x == id)
        .map((_) => _filter(id, range));
  }

  Set<DateTime> _filter(HabitId id, DateRange range) =>
      (_dates[id] ?? const <DateTime>{})
          .where(
            (d) =>
                !d.isBefore(range.startInclusive) &&
                d.isBefore(range.endExclusive),
          )
          .toSet();

  @override
  Future<bool> isCompleted(HabitId id, DateTime date) async =>
      (_dates[id] ?? const <DateTime>{}).contains(_norm(date));

  @override
  Future<void> markCompleted(HabitId id, DateTime date) async {
    (_dates[id] ??= <DateTime>{}).add(_norm(date));
    _events.add(id);
  }

  @override
  Future<void> unmarkCompleted(HabitId id, DateTime date) async {
    _dates[id]?.remove(_norm(date));
    _events.add(id);
  }

  @override
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore}) async {
    final habit = await habitLookup(id);
    if (habit == null) {
      return const StreakInfo(
        currentStreak: 0,
        longestStreak: 0,
        freezesRemainingThisWeek: 0,
      );
    }
    return computeStreakPure(
      schedule: habit.schedule,
      completions: _dates[id] ?? const <DateTime>{},
      today: todayProvider(),
      hardcore: hardcore,
    );
  }

  @override
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    Future<WeeklyProgress> compute() async {
      final habit = await habitLookup(id);
      if (habit == null) {
        return const WeeklyProgress(completedDays: 0, scheduledDays: 0);
      }
      final today = todayProvider();
      final start = today.subtract(
        Duration(days: (today.weekday - DateTime.monday) % 7),
      );
      final end = start.add(const Duration(days: 7));
      final done = (_dates[id] ?? const <DateTime>{})
          .where((d) => !d.isBefore(start) && d.isBefore(end))
          .length;
      return WeeklyProgress(
        completedDays: done,
        scheduledDays: habit.schedule.length,
      );
    }

    yield await compute();
    yield* _events.stream.where((x) => x == id).asyncMap((_) => compute());
  }
}
