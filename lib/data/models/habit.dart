import 'package:freezed_annotation/freezed_annotation.dart';

import 'habit_color.dart';
import 'habit_icon.dart';
import 'habit_status.dart';
import 'reminder_time.dart';
import 'typed_ids.dart';
import 'weekday.dart';

part 'habit.freezed.dart';

@freezed
class Habit with _$Habit {
  const factory Habit({
    required HabitId id,
    required String name,
    required HabitColor color,
    required HabitIcon icon,
    required Set<Weekday> schedule,
    required ReminderTime? reminder,
    required HabitStatus status,
    required DateTime createdAt,
    required GroupId? groupId,
  }) = _Habit;
}
