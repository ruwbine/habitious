import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  IntColumn get colorIndex => integer()();
  IntColumn get iconIndex => integer()();
  IntColumn get scheduleBitmask => integer()();
  IntColumn get reminderMinutes => integer().nullable()();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get statusIndex => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get groupId => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class HabitCompletions extends Table {
  TextColumn get habitId =>
      text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get markedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {habitId, date};
}

class UserProfileTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get displayName => text()();
  TextColumn get avatarPath => text().nullable()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  BoolColumn get hardcoreMode =>
      boolean().withDefault(const Constant(false))();
  IntColumn get themePreferenceIndex =>
      integer().withDefault(const Constant(0))();
  TextColumn get localeTag => text().withDefault(const Constant('ru'))();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Habits, HabitCompletions, UserProfileTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'habitious'));
  // ignore: use_super_parameters
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
