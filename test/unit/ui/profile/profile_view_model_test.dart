import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/theme_preference.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/ui/profile/view_models/profile_view_model.dart';
import '../../../fakes/in_memory_profile_repository.dart';

void main() {
  test('toggleHardcoreMode persists to repository', () async {
    final repo = InMemoryProfileRepository(const UserProfile(
      displayName: 'A',
      avatarPath: null,
      level: 1,
      xp: 0,
      hardcoreMode: false,
      themePreference: ThemePreference.system,
      locale: Locale('ru'),
    ));
    final vm = ProfileViewModel(repo);
    await vm.load();
    // Allow the stream subscription to emit the initial value into the VM.
    await Future<void>.delayed(Duration.zero);
    await vm.toggleHardcoreModeCommand.run(true);
    final updated = await repo.watchProfile().first;
    expect(updated.hardcoreMode, isTrue);
  });
}
