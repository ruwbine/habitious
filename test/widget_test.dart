import 'dart:ffi';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/app.dart';
import 'package:habitious/app_preferences.dart';
import 'package:habitious/data/models/theme_preference.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/data/services/app_database.dart';
import 'package:habitious/profile_sync.dart';
import 'package:sqlite3/open.dart';
import 'fakes/fake_notification_service.dart';
import 'fakes/in_memory_profile_repository.dart';

void main() {
  setUpAll(() {
    open.overrideFor(
      OperatingSystem.linux,
      () => DynamicLibrary.open('libsqlite3.so.0'),
    );
  });

  testWidgets('app builds without throwing', (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final repo = InMemoryProfileRepository(const UserProfile(
      displayName: 'Test',
      avatarPath: null,
      level: 1,
      xp: 0,
      hardcoreMode: false,
      themePreference: ThemePreference.system,
      locale: Locale('ru'),
    ));
    await tester.pumpWidget(HabitiousApp(
      database: db,
      profileRepository: repo,
      preferences: AppPreferences(),
      hardcoreFlag: HardcoreFlag(),
      notifications: FakeNotificationService(),
    ));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(Scaffold), findsAtLeastNWidgets(1));

    // Close the database before the test ends. Drift uses Timer.run() to
    // debounce stream-cache cleanup; closing the db sets
    // _closeStreamsSynchronously=true which eliminates those timers.
    await db.close();
  });
}
