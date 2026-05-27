import 'package:flutter/material.dart';
import 'app.dart';
import 'app_preferences.dart';
import 'data/repositories/drift_profile_repository.dart';
import 'data/services/app_database.dart';
import 'data/services/notification_service.dart';
import 'profile_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final profileRepo = DriftProfileRepository(db);
  final prefs = AppPreferences();
  final flag = HardcoreFlag();
  final notif = FlutterLocalNotificationsServiceImpl();
  await notif.initialize();
  await ProfileSync(profileRepo, prefs, flag).start();
  runApp(
    HabitiousApp(
      database: db,
      profileRepository: profileRepo,
      preferences: prefs,
      hardcoreFlag: flag,
      notifications: notif,
    ),
  );
}
