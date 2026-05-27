import '../models/date_range.dart';
import '../models/streak_info.dart';
import '../models/typed_ids.dart';
import '../models/weekly_progress.dart';

abstract interface class CompletionRepository {
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range);
  Future<bool> isCompleted(HabitId id, DateTime date);
  Future<void> markCompleted(HabitId id, DateTime date);
  Future<void> unmarkCompleted(HabitId id, DateTime date);
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore});
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id);
}
