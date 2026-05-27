import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_time.freezed.dart';

@freezed
class ReminderTime with _$ReminderTime {
  const factory ReminderTime({required int hour, required int minute}) =
      _ReminderTime;
}
