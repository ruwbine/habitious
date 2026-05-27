import 'dart:ffi';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/data/repositories/drift_habit_repository.dart';
import 'package:habitious/data/services/app_database.dart';
import 'package:sqlite3/open.dart';

void main() {
  setUpAll(() {
    open.overrideFor(
      OperatingSystem.linux,
      () => DynamicLibrary.open('libsqlite3.so.0'),
    );
  });

  late AppDatabase db;
  late DriftHabitRepository repo;
  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = DriftHabitRepository(db);
  });
  tearDown(() => db.close());

  Habit makeHabit({String id = 'h1', String name = 'Drink water'}) => Habit(
    id: HabitId(id),
    name: name,
    color: HabitColor.purple,
    icon: HabitIcon.drop,
    schedule: Weekday.values.toSet(),
    reminder: null,
    status: HabitStatus.active,
    createdAt: DateTime(2026, 5, 1),
    groupId: null,
  );

  test('upsert then findHabit returns the same habit', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    final found = await repo.findHabit(h.id);
    expect(found, h);
  });

  test('watchHabits emits inserts and updates', () async {
    final stream = repo.watchHabits();
    final emissions = <int>[];
    final sub = stream.listen((list) => emissions.add(list.length));

    await repo.upsertHabit(makeHabit(id: 'a'));
    await repo.upsertHabit(makeHabit(id: 'b'));
    await Future<void>.delayed(Duration.zero);
    expect(emissions.last, 2);
    await sub.cancel();
  });

  test('archiveHabit flips status', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    await repo.archiveHabit(h.id);
    final found = await repo.findHabit(h.id);
    expect(found?.status, HabitStatus.archived);
  });

  test('deleteHabit removes the row', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    await repo.deleteHabit(h.id);
    expect(await repo.findHabit(h.id), isNull);
  });
}
