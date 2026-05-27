import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../../../data/models/theme_preference.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../core/command.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._repo) {
    toggleHardcoreModeCommand = Command<bool, void>((v) async =>
        _save((p) => p.copyWith(hardcoreMode: v)));
    setThemePreferenceCommand = Command<ThemePreference, void>((v) async =>
        _save((p) => p.copyWith(themePreference: v)));
    setLocaleCommand = Command<Locale, void>((v) async =>
        _save((p) => p.copyWith(locale: v)));
  }

  final ProfileRepository _repo;
  UserProfile? profile;
  StreamSubscription<UserProfile>? _sub;

  late final Command<bool, void> toggleHardcoreModeCommand;
  late final Command<ThemePreference, void> setThemePreferenceCommand;
  late final Command<Locale, void> setLocaleCommand;

  Future<void> load() async {
    _sub = _repo.watchProfile().listen((p) {
      profile = p;
      notifyListeners();
    });
  }

  Future<void> _save(UserProfile Function(UserProfile) tx) async {
    final cur = profile;
    if (cur == null) return;
    await _repo.updateProfile(tx(cur));
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
