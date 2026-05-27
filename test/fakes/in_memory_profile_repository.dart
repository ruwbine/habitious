import 'package:rxdart/rxdart.dart';

import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/data/repositories/profile_repository.dart';

class InMemoryProfileRepository implements ProfileRepository {
  InMemoryProfileRepository(UserProfile seed) {
    _subject.add(seed);
  }

  final _subject = BehaviorSubject<UserProfile>();

  @override
  Stream<UserProfile> watchProfile() => _subject.stream;

  @override
  Future<void> updateProfile(UserProfile p) async => _subject.add(p);
}
