import 'dart:async';
import 'package:flutter/foundation.dart';
import 'app_preferences.dart';
import 'data/repositories/profile_repository.dart';

/// Latest-value cache of the user's hardcore-mode toggle, for synchronous reads.
class HardcoreFlag extends ChangeNotifier {
  bool _value = false;
  bool get value => _value;
  void update(bool v) {
    if (_value == v) return;
    _value = v;
    notifyListeners();
  }
}

/// Subscribes to ProfileRepository and pushes preferences into AppPreferences
/// and HardcoreFlag. Returns a Future that resolves after the first emission so
/// startup can await it.
class ProfileSync {
  ProfileSync(this._repo, this._prefs, this._flag);
  final ProfileRepository _repo;
  final AppPreferences _prefs;
  final HardcoreFlag _flag;
  StreamSubscription<Object?>? _sub;

  Future<void> start() async {
    final completer = Completer<void>();
    _sub = _repo.watchProfile().listen((p) {
      _prefs.setTheme(p.themePreference.mode);
      _prefs.setLocale(p.locale);
      _flag.update(p.hardcoreMode);
      if (!completer.isCompleted) completer.complete();
    });
    return completer.future;
  }

  Future<void> dispose() async => _sub?.cancel();
}
