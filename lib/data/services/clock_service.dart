abstract interface class ClockService {
  DateTime now();

  /// Local midnight of today.
  DateTime today();
}

class SystemClockService implements ClockService {
  @override
  DateTime now() => DateTime.now();

  @override
  DateTime today() {
    final n = now();
    return DateTime(n.year, n.month, n.day);
  }
}
