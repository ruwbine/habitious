import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/services/notification_service.dart';

class FakeNotificationService implements NotificationService {
  int initCalls = 0;
  int permCalls = 0;
  final List<Habit> scheduled = [];
  final List<HabitId> cancelled = [];
  bool permissionResponse = true;

  @override
  Future<void> initialize() async {
    initCalls++;
  }

  @override
  Future<bool> requestPermission() async {
    permCalls++;
    return permissionResponse;
  }

  @override
  Future<void> scheduleHabitReminders(Habit h) async {
    scheduled.add(h);
  }

  @override
  Future<void> cancelHabitReminders(HabitId id) async {
    cancelled.add(id);
  }
}
