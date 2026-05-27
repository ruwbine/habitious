import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_progress.freezed.dart';

@freezed
class WeeklyProgress with _$WeeklyProgress {
  const factory WeeklyProgress({
    required int completedDays,
    required int scheduledDays,
  }) = _WeeklyProgress;
}
