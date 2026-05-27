import 'dart:async';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/repositories/habit_repository.dart';

class InMemoryHabitRepository implements HabitRepository {
  final Map<HabitId, Habit> _byId = {};
  final StreamController<List<Habit>> _controller =
      StreamController.broadcast();

  @override
  Stream<List<Habit>> watchHabits({HabitStatus? status}) async* {
    yield _snapshot(status);
    yield* _controller.stream.map((_) => _snapshot(status));
  }

  List<Habit> _snapshot(HabitStatus? status) => _byId.values
      .where((h) => status == null || h.status == status)
      .toList(growable: false);

  @override
  Future<Habit?> findHabit(HabitId id) async => _byId[id];

  @override
  Future<void> upsertHabit(Habit habit) async {
    _byId[habit.id] = habit;
    _controller.add(_byId.values.toList());
  }

  @override
  Future<void> archiveHabit(HabitId id) async {
    final h = _byId[id];
    if (h == null) return;
    _byId[id] = h.copyWith(status: HabitStatus.archived);
    _controller.add(_byId.values.toList());
  }

  @override
  Future<void> deleteHabit(HabitId id) async {
    _byId.remove(id);
    _controller.add(_byId.values.toList());
  }
}
