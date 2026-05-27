import '../models/user_profile.dart';

abstract interface class ProfileRepository {
  Stream<UserProfile> watchProfile();
  Future<void> updateProfile(UserProfile profile);
}
