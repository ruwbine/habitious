import 'package:habitious/data/services/clock_service.dart';

class FakeClockService implements ClockService {
  FakeClockService(this._now);
  DateTime _now;

  void advance(Duration d) => _now = _now.add(d);
  void setTo(DateTime t) => _now = t;

  @override
  DateTime now() => _now;

  @override
  DateTime today() => DateTime(_now.year, _now.month, _now.day);
}
