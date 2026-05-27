import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../models/habit.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';

abstract interface class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> scheduleHabitReminders(Habit habit);
  Future<void> cancelHabitReminders(HabitId id);
}

class FlutterLocalNotificationsServiceImpl implements NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(initSettings);
  }

  @override
  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    final bool? aResult = await android?.requestNotificationsPermission();
    final bool? iResult = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    final a = aResult ?? true;
    final i = iResult ?? true;
    return a && i;
  }

  static int _stableId(HabitId id, Weekday day) =>
      (id.value.hashCode ^ day.index) & 0x7fffffff;

  @override
  Future<void> scheduleHabitReminders(Habit habit) async {
    await cancelHabitReminders(habit.id);
    if (habit.reminder == null) return;
    final r = habit.reminder!;
    for (final day in habit.schedule) {
      final next = _nextInstance(day, r.hour, r.minute);
      await _plugin.zonedSchedule(
        _stableId(habit.id, day),
        habit.name,
        '⏰',
        next,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'habits',
            'Habit reminders',
            importance: Importance.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  @override
  Future<void> cancelHabitReminders(HabitId id) async {
    for (final day in Weekday.values) {
      await _plugin.cancel(_stableId(id, day));
    }
  }

  tz.TZDateTime _nextInstance(Weekday day, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    final targetWeekday = day.index + 1; // Mon=1...Sun=7
    while (scheduled.weekday != targetWeekday || !scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
