import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/weekly_progress.dart';
part 'habit_list_item.freezed.dart';

@freezed
class HabitListItem with _$HabitListItem {
  const factory HabitListItem({
    required Habit habit,
    required WeeklyProgress progress,
    required int participantsCount,
  }) = _HabitListItem;
}

enum HabitsTab { all, active, archive }
