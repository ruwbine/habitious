import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_status.dart';
import '../../../data/models/weekly_progress.dart';
import '../../../data/repositories/habit_repository.dart';
import 'habit_list_item.dart';

class HabitsListViewModel extends ChangeNotifier {
  HabitsListViewModel(this._habits, this._completions);
  final HabitRepository _habits;
  // ignore: unused_field
  final dynamic _completions; // replaced by CompletionRepository in Task 23

  HabitsTab _tab = HabitsTab.all;
  List<HabitListItem> _items = const [];
  bool _isLoading = true;
  Object? _error;
  StreamSubscription<List<Habit>>? _sub;

  HabitsTab get tab => _tab;
  List<HabitListItem> get items =>
      _items.where(_match).toList(growable: false);
  bool get isLoading => _isLoading;
  Object? get error => _error;

  bool _match(HabitListItem item) {
    switch (_tab) {
      case HabitsTab.all:
        return true;
      case HabitsTab.active:
        return item.habit.status == HabitStatus.active;
      case HabitsTab.archive:
        return item.habit.status == HabitStatus.archived;
    }
  }

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _sub = _habits.watchHabits().listen((list) {
        _items = list
            .map(
              (h) => HabitListItem(
                habit: h,
                progress:
                    const WeeklyProgress(completedDays: 0, scheduledDays: 7),
                participantsCount: 1,
              ),
            )
            .toList(growable: false);
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  void switchTab(HabitsTab tab) {
    if (_tab == tab) return;
    _tab = tab;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
