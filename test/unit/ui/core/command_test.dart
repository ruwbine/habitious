import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/ui/core/command.dart';

void main() {
  test('reports running state and result on success', () async {
    final cmd = Command<int, int>((x) async => x * 2);
    expect(cmd.running, isFalse);
    final future = cmd.run(21);
    expect(cmd.running, isTrue);
    final result = await future;
    expect(result, 42);
    expect(cmd.running, isFalse);
    expect(cmd.lastResult, 42);
    expect(cmd.error, isNull);
  });

  test('captures errors without rethrowing', () async {
    final cmd = Command<void, void>((_) async => throw StateError('boom'));
    await cmd.run(null);
    expect(cmd.running, isFalse);
    expect(cmd.error, isA<StateError>());
  });
}
