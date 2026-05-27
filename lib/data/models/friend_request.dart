import 'package:freezed_annotation/freezed_annotation.dart';

import 'friend.dart';

part 'friend_request.freezed.dart';

@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required Friend friend,
    required DateTime sentAt,
    required bool incoming,
  }) = _FriendRequest;
}
