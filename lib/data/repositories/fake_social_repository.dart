import 'package:rxdart/rxdart.dart';
import '../models/friend.dart';
import '../models/friend_request.dart';
import '../models/group.dart';
import '../models/leaderboard_entry.dart';
import '../models/typed_ids.dart';
import 'social_repository.dart';

class FakeSocialRepository implements SocialRepository {
  factory FakeSocialRepository.seeded() {
    final repo = FakeSocialRepository._();
    repo._friends.add(const [
      Friend(
        id: FriendId('f1'),
        displayName: 'Амир',
        avatarPath: null,
        sharedHabitsCount: 2,
      ),
      Friend(
        id: FriendId('f2'),
        displayName: 'Nurseltan',
        avatarPath: null,
        sharedHabitsCount: 1,
      ),
      Friend(
        id: FriendId('f3'),
        displayName: 'Дина',
        avatarPath: null,
        sharedHabitsCount: 4,
      ),
      Friend(
        id: FriendId('f4'),
        displayName: 'Мария',
        avatarPath: null,
        sharedHabitsCount: 1,
      ),
    ]);
    final now = DateTime(2026, 5, 25);
    repo._requests.add([
      FriendRequest(
        friend: const Friend(
          id: FriendId('r1'),
          displayName: 'Мария',
          avatarPath: null,
          sharedHabitsCount: 0,
        ),
        sentAt: now,
        incoming: true,
      ),
      FriendRequest(
        friend: const Friend(
          id: FriendId('r2'),
          displayName: 'Илья',
          avatarPath: null,
          sharedHabitsCount: 0,
        ),
        sentAt: now,
        incoming: true,
      ),
    ]);
    return repo;
  }

  FakeSocialRepository._();
  final _friends = BehaviorSubject<List<Friend>>.seeded(const []);
  final _requests = BehaviorSubject<List<FriendRequest>>.seeded(const []);

  @override
  Stream<List<Friend>> watchFriends() => _friends.stream;

  @override
  Stream<List<FriendRequest>> watchIncomingRequests() => _requests.stream;

  @override
  Future<List<Friend>> searchByUsername(String query) async => _friends.value
      .where((f) => f.displayName.toLowerCase().contains(query.toLowerCase()))
      .toList();

  @override
  Stream<Group?> watchGroupForHabit(HabitId habitId) => Stream.value(
    Group(
      id: GroupId('g_${habitId.value}'),
      habitId: habitId,
      completionPercentThisWeek: 78,
      members: const [
        GroupMember(
          id: FriendId('me'),
          displayName: 'Вы',
          avatarPath: null,
          currentStreak: 14,
          completedThisWeek: 6,
          scheduledThisWeek: 7,
        ),
        GroupMember(
          id: FriendId('f1'),
          displayName: 'Амир',
          avatarPath: null,
          currentStreak: 5,
          completedThisWeek: 6,
          scheduledThisWeek: 7,
        ),
        GroupMember(
          id: FriendId('f2'),
          displayName: 'Nurseltan',
          avatarPath: null,
          currentStreak: 3,
          completedThisWeek: 2,
          scheduledThisWeek: 7,
        ),
        GroupMember(
          id: FriendId('f3'),
          displayName: 'Дина',
          avatarPath: null,
          currentStreak: 1,
          completedThisWeek: 1,
          scheduledThisWeek: 7,
        ),
      ],
    ),
  );

  @override
  Stream<List<LeaderboardEntry>> watchLeaderboard(GroupId groupId) =>
      Stream.value(const [
        LeaderboardEntry(
          rank: 1,
          memberId: FriendId('me'),
          displayName: 'Вы',
          avatarPath: null,
          currentStreak: 14,
          completedThisWeek: 6,
          scheduledThisWeek: 7,
        ),
        LeaderboardEntry(
          rank: 2,
          memberId: FriendId('f1'),
          displayName: 'Амир',
          avatarPath: null,
          currentStreak: 5,
          completedThisWeek: 6,
          scheduledThisWeek: 7,
        ),
        LeaderboardEntry(
          rank: 3,
          memberId: FriendId('f2'),
          displayName: 'Nurseltan',
          avatarPath: null,
          currentStreak: 3,
          completedThisWeek: 2,
          scheduledThisWeek: 7,
        ),
        LeaderboardEntry(
          rank: 4,
          memberId: FriendId('f3'),
          displayName: 'Дина',
          avatarPath: null,
          currentStreak: 1,
          completedThisWeek: 1,
          scheduledThisWeek: 7,
        ),
      ]);

  @override
  Future<void> nudgeLazyMembers(GroupId groupId) async {
    // No-op stub.
  }

  @override
  Future<void> acceptFriendRequest(FriendId id) async {
    _requests.add(_requests.value.where((r) => r.friend.id != id).toList());
  }

  @override
  Future<void> declineFriendRequest(FriendId id) async {
    _requests.add(_requests.value.where((r) => r.friend.id != id).toList());
  }
}
