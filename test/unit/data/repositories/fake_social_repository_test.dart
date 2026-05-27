import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/repositories/fake_social_repository.dart';

void main() {
  test('seeded fake exposes 4 friends and 2 requests', () async {
    final repo = FakeSocialRepository.seeded();
    final friends = await repo.watchFriends().first;
    final reqs = await repo.watchIncomingRequests().first;
    expect(friends.length, 4);
    expect(reqs.length, 2);
  });

  test('searchByUsername filters case-insensitively', () async {
    final repo = FakeSocialRepository.seeded();
    final results = await repo.searchByUsername('ам');
    expect(results.map((f) => f.displayName), contains('Амир'));
  });
}
