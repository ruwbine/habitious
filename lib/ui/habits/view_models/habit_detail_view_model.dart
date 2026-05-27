import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/date_range.dart';
import '../../../data/models/group.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/leaderboard_entry.dart';
import '../../../data/models/streak_info.dart';
import '../../../data/models/typed_ids.dart';
import '../../../data/repositories/completion_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/repositories/social_repository.dart';
import '../../../data/services/clock_service.dart';
import '../../../profile_sync.dart';
import '../../core/command.dart';

class HabitDetailViewModel extends ChangeNotifier {
  HabitDetailViewModel(
    this._habits,
    this._completions,
    this._social,
    this._clock,
    this._hardcoreFlag, {
    required this.habitId,
  }) {
    toggleDayCommand = Command<DateTime, void>(_toggleDay);
    changeMonthCommand = Command<DateTime, void>(_changeMonth);
    nudgeLazyCommand = Command<void, void>(_nudgeLazy);
    _hardcoreFlag.addListener(_onHardcoreChanged);
  }

  final HabitRepository _habits;
  final CompletionRepository _completions;
  final SocialRepository _social;
  final ClockService _clock;
  final HardcoreFlag _hardcoreFlag;
  final HabitId habitId;

  Habit? habit;
  StreakInfo? streak;
  Set<DateTime> monthCompletions = const {};
  DateTime visibleMonth = DateTime(2000);
  StreamSubscription<Set<DateTime>>? _monthSub;

  Group? group;
  List<LeaderboardEntry> leaderboard = const [];
  StreamSubscription<Group?>? _groupSub;
  StreamSubscription<List<LeaderboardEntry>>? _lbSub;

  late final Command<DateTime, void> toggleDayCommand;
  late final Command<DateTime, void> changeMonthCommand;
  late final Command<void, void> nudgeLazyCommand;

  Future<void> load() async {
    habit = await _habits.findHabit(habitId);
    final today = _clock.today();
    visibleMonth = DateTime(today.year, today.month);
    await _resubscribeMonth();
    await _refreshStreak();
    _groupSub = _social.watchGroupForHabit(habitId).listen((g) {
      group = g;
      notifyListeners();
      _lbSub?.cancel();
      if (g != null) {
        _lbSub = _social.watchLeaderboard(g.id).listen((rows) {
          leaderboard = rows;
          notifyListeners();
        });
      }
    });
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
      hardcore: _hardcoreFlag.value,
    );
    notifyListeners();
  }

  void _onHardcoreChanged() { _refreshStreak(); }

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

  Future<void> _nudgeLazy(void _) async {
    final g = group;
    if (g == null) return;
    await _social.nudgeLazyMembers(g.id);
  }

  @override
  void dispose() {
    _hardcoreFlag.removeListener(_onHardcoreChanged);
    _monthSub?.cancel();
    _groupSub?.cancel();
    _lbSub?.cancel();
    super.dispose();
  }
}
