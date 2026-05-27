import 'dart:ffi';
import 'dart:ui';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/theme_preference.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/data/repositories/drift_profile_repository.dart';
import 'package:habitious/data/services/app_database.dart';
import 'package:sqlite3/open.dart';

void main() {
  setUpAll(() {
    open.overrideFor(
      OperatingSystem.linux,
      () => DynamicLibrary.open('libsqlite3.so.0'),
    );
  });

  test('updateProfile emits new value', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = DriftProfileRepository(db);
    // Allow the _ensureRow() future + initial watch emission to complete.
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await repo.updateProfile(
      const UserProfile(
        displayName: 'Test',
        avatarPath: null,
        level: 1,
        xp: 0,
        hardcoreMode: true,
        themePreference: ThemePreference.dark,
        locale: Locale('en'),
      ),
    );
    // Allow the Drift watch listener to fire and update the BehaviorSubject.
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final p = await repo.watchProfile().first;
    expect(p.hardcoreMode, isTrue);
    expect(p.themePreference, ThemePreference.dark);
  });
}
