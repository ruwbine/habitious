import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_info.freezed.dart';

@freezed
class StreakInfo with _$StreakInfo {
  const factory StreakInfo({
    required int currentStreak,
    required int longestStreak,
    required int freezesRemainingThisWeek,
  }) = _StreakInfo;
}
