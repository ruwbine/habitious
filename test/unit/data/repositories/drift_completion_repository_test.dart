import 'dart:ffi';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/data/repositories/drift_completion_repository.dart';
import 'package:habitious/data/repositories/drift_habit_repository.dart';
import 'package:habitious/data/services/app_database.dart';
import 'package:sqlite3/open.dart';

import '../../../fakes/fake_clock_service.dart';

void main() {
  setUpAll(() {
    open.overrideFor(
      OperatingSystem.linux,
      () => DynamicLibrary.open('libsqlite3.so.0'),
    );
  });

  late AppDatabase db;
  late DriftHabitRepository habits;
  late DriftCompletionRepository comps;
  late FakeClockService clock;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = FakeClockService(DateTime(2026, 5, 27));
    habits = DriftHabitRepository(db);
    comps = DriftCompletionRepository(db, clock);
    await habits.upsertHabit(
      Habit(
        id: const HabitId('h1'),
        name: 'Drink',
        color: HabitColor.purple,
        icon: HabitIcon.drop,
        schedule: Weekday.values.toSet(),
        reminder: null,
        status: HabitStatus.active,
        createdAt: DateTime(2026, 5, 1),
        groupId: null,
      ),
    );
  });
  tearDown(() => db.close());

  test('mark and unmark round-trip', () async {
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    expect(
      await comps.isCompleted(const HabitId('h1'), DateTime(2026, 5, 26)),
      isTrue,
    );
    await comps.unmarkCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    expect(
      await comps.isCompleted(const HabitId('h1'), DateTime(2026, 5, 26)),
      isFalse,
    );
  });

  test('hardcore mode resets streak on first miss', () async {
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 25));
    final s = await comps.computeStreak(
      const HabitId('h1'),
      hardcore: true,
    );
    expect(s.currentStreak, 2);
  });

  test('normal mode allows one freeze per week', () async {
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    // 2026-05-25 missed → consumes the freeze
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 24));
    final s = await comps.computeStreak(
      const HabitId('h1'),
      hardcore: false,
    );
    expect(s.currentStreak, 2);
  });
}
