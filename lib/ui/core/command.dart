import 'package:flutter/foundation.dart';

class Command<Arg, Result> extends ChangeNotifier {
  Command(this._action);
  final Future<Result> Function(Arg) _action;

  bool _running = false;
  Result? _lastResult;
  Object? _error;

  bool get running => _running;
  Result? get lastResult => _lastResult;
  Object? get error => _error;

  Future<Result?> run(Arg arg) async {
    if (_running) return null;
    _running = true;
    _error = null;
    notifyListeners();
    try {
      _lastResult = await _action(arg);
      return _lastResult;
    } catch (e) {
      _error = e;
      return null;
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}
