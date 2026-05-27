import 'package:freezed_annotation/freezed_annotation.dart';

import 'typed_ids.dart';

part 'leaderboard_entry.freezed.dart';

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required int rank,
    required FriendId memberId,
    required String displayName,
    required String? avatarPath,
    required int currentStreak,
    required int completedThisWeek,
    required int scheduledThisWeek,
  }) = _LeaderboardEntry;
}
