import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekly_progress.dart';

class InMemoryCompletionRepositoryStub {
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    yield const WeeklyProgress(completedDays: 0, scheduledDays: 7);
  }
}
