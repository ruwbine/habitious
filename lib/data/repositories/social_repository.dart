import '../models/friend.dart';
import '../models/friend_request.dart';
import '../models/group.dart';
import '../models/leaderboard_entry.dart';
import '../models/typed_ids.dart';

abstract interface class SocialRepository {
  Stream<List<Friend>> watchFriends();
  Stream<List<FriendRequest>> watchIncomingRequests();
  Future<List<Friend>> searchByUsername(String query);
  Stream<Group?> watchGroupForHabit(HabitId habitId);
  Stream<List<LeaderboardEntry>> watchLeaderboard(GroupId groupId);
  Future<void> nudgeLazyMembers(GroupId groupId);
  Future<void> acceptFriendRequest(FriendId id);
  Future<void> declineFriendRequest(FriendId id);
}
