import 'package:freezed_annotation/freezed_annotation.dart';

import 'typed_ids.dart';

part 'friend.freezed.dart';

@freezed
class Friend with _$Friend {
  const factory Friend({
    required FriendId id,
    required String displayName,
    required String? avatarPath,
    required int sharedHabitsCount,
  }) = _Friend;
}
