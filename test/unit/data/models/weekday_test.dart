import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/weekday.dart';

void main() {
  test('toMask and fromMask round-trip', () {
    final days = {Weekday.mon, Weekday.wed, Weekday.fri};
    final mask = Weekday.toMask(days);
    expect(Weekday.fromMask(mask), days);
  });

  test('empty set maps to 0 and back', () {
    expect(Weekday.toMask(const {}), 0);
    expect(Weekday.fromMask(0), isEmpty);
  });
}
