import 'package:flutter/foundation.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/habit_icon.dart';
import '../../../data/models/habit_status.dart';
import '../../../data/models/reminder_time.dart';
import '../../../data/models/typed_ids.dart';
import '../../../data/models/weekday.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/services/notification_service.dart';
import '../../core/command.dart';

class CreateHabitViewModel extends ChangeNotifier {
  CreateHabitViewModel(this._habits, this._notifications) {
    submitCommand = Command<void, HabitId?>((_) async {
      if (!canSubmit) return null;
      final id = HabitId('h_${DateTime.now().microsecondsSinceEpoch}');
      final habit = Habit(
        id: id,
        name: _name.trim(),
        color: _color,
        icon: _icon,
        schedule: _schedule,
        reminder: _reminder,
        status: HabitStatus.active,
        createdAt: DateTime.now(),
        groupId: null,
      );
      await _habits.upsertHabit(habit);
      await _notifications.scheduleHabitReminders(habit);
      return id;
    });
  }

  final HabitRepository _habits;
  final NotificationService _notifications;

  String _name = '';
  Set<Weekday> _schedule = Weekday.values.toSet();
  ReminderTime? _reminder;
  HabitColor _color = HabitColor.purple;
  HabitIcon _icon = HabitIcon.drop;

  String get name => _name;
  Set<Weekday> get schedule => _schedule;
  ReminderTime? get reminder => _reminder;
  HabitColor get color => _color;
  HabitIcon get icon => _icon;

  bool get canSubmit => _name.trim().isNotEmpty && _schedule.isNotEmpty;

  late final Command<void, HabitId?> submitCommand;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setSchedule(Set<Weekday> value) {
    _schedule = value;
    notifyListeners();
  }

  void setReminder(ReminderTime? value) {
    _reminder = value;
    notifyListeners();
  }

  void setColor(HabitColor value) {
    _color = value;
    notifyListeners();
  }

  void setIcon(HabitIcon value) {
    _icon = value;
    notifyListeners();
  }
}
