import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../models/theme_preference.dart';
import '../models/user_profile.dart';
import '../services/app_database.dart';
import 'profile_repository.dart';

class DriftProfileRepository implements ProfileRepository {
  DriftProfileRepository(this._db) {
    _ensureRow();
  }

  final AppDatabase _db;
  final _subject = BehaviorSubject<UserProfile>();

  Future<void> _ensureRow() async {
    final existing = await _db.select(_db.userProfileTable).getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.userProfileTable).insert(
            UserProfileTableCompanion.insert(
              displayName: 'Алексей',
            ),
          );
    }
    _db.select(_db.userProfileTable).watch().listen((rows) {
      if (rows.isEmpty) return;
      final r = rows.first;
      _subject.add(UserProfile(
        displayName: r.displayName,
        avatarPath: r.avatarPath,
        level: r.level,
        xp: r.xp,
        hardcoreMode: r.hardcoreMode,
        themePreference: ThemePreference.values[r.themePreferenceIndex],
        locale: Locale(r.localeTag),
      ));
    });
  }

  @override
  Stream<UserProfile> watchProfile() => _subject.stream;

  @override
  Future<void> updateProfile(UserProfile p) async {
    await _db.update(_db.userProfileTable).write(UserProfileTableCompanion(
      displayName: Value(p.displayName),
      avatarPath: Value(p.avatarPath),
      level: Value(p.level),
      xp: Value(p.xp),
      hardcoreMode: Value(p.hardcoreMode),
      themePreferenceIndex: Value(p.themePreference.index),
      localeTag: Value(p.locale.languageCode),
    ));
  }
}
