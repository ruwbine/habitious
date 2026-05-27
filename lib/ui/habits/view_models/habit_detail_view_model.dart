import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/date_range.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/streak_info.dart';
import '../../../data/models/typed_ids.dart';
import '../../../data/repositories/completion_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/services/clock_service.dart';
import '../../core/command.dart';

class HabitDetailViewModel extends ChangeNotifier {
  HabitDetailViewModel(
    this._habits,
    this._completions,
    this._clock, {
    required this.habitId,
    required this.hardcoreProvider,
  }) {
    toggleDayCommand = Command<DateTime, void>(_toggleDay);
    changeMonthCommand = Command<DateTime, void>(_changeMonth);
  }

  final HabitRepository _habits;
  final CompletionRepository _completions;
  final ClockService _clock;
  final HabitId habitId;
  final bool Function() hardcoreProvider;

  Habit? habit;
  StreakInfo? streak;
  Set<DateTime> monthCompletions = const {};
  DateTime visibleMonth = DateTime(2000);
  StreamSubscription<Set<DateTime>>? _monthSub;

  late final Command<DateTime, void> toggleDayCommand;
  late final Command<DateTime, void> changeMonthCommand;

  Future<void> load() async {
    habit = await _habits.findHabit(habitId);
    final today = _clock.today();
    visibleMonth = DateTime(today.year, today.month);
    await _resubscribeMonth();
    await _refreshStreak();
  }

  Future<void> _resubscribeMonth() async {
    final start = DateTime(visibleMonth.year, visibleMonth.month);
    final end = DateTime(visibleMonth.year, visibleMonth.month + 1);
    await _monthSub?.cancel();
    _monthSub = _completions
        .watchCompletionDates(habitId, DateRange(start, end))
        .listen((set) {
      monthCompletions = set;
      notifyListeners();
    });
  }

  Future<void> _refreshStreak() async {
    streak = await _completions.computeStreak(
      habitId,
      hardcore: hardcoreProvider(),
    );
    notifyListeners();
  }

  Future<void> _toggleDay(DateTime day) async {
    final done = await _completions.isCompleted(habitId, day);
    if (done) {
      await _completions.unmarkCompleted(habitId, day);
    } else {
      await _completions.markCompleted(habitId, day);
    }
    await _refreshStreak();
  }

  Future<void> _changeMonth(DateTime month) async {
    visibleMonth = DateTime(month.year, month.month);
    notifyListeners();
    await _resubscribeMonth();
  }

  @override
  void dispose() {
    _monthSub?.cancel();
    super.dispose();
  }
}
