import 'package:freezed_annotation/freezed_annotation.dart';

import 'typed_ids.dart';

part 'habit_completion.freezed.dart';

@freezed
class HabitCompletion with _$HabitCompletion {
  const factory HabitCompletion({
    required HabitId habitId,
    required DateTime date,
    required DateTime markedAt,
  }) = _HabitCompletion;
}
