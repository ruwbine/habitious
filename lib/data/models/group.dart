import 'package:freezed_annotation/freezed_annotation.dart';

import 'typed_ids.dart';

part 'group.freezed.dart';

@freezed
class GroupMember with _$GroupMember {
  const factory GroupMember({
    required FriendId id,
    required String displayName,
    required String? avatarPath,
    required int currentStreak,
    required int completedThisWeek,
    required int scheduledThisWeek,
  }) = _GroupMember;
}

@freezed
class Group with _$Group {
  const factory Group({
    required GroupId id,
    required HabitId habitId,
    required List<GroupMember> members,
    required int completionPercentThisWeek,
  }) = _Group;
}
