import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/models/habit_status.dart';
import '../../../data/repositories/completion_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import 'habit_list_item.dart';

class HabitsListViewModel extends ChangeNotifier {
  HabitsListViewModel(this._habits, this._completions);
  final HabitRepository _habits;
  final CompletionRepository _completions;

  HabitsTab _tab = HabitsTab.all;
  List<HabitListItem> _items = const [];
  bool _isLoading = true;
  Object? _error;
  StreamSubscription<List<HabitListItem>>? _sub;

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
    _sub = _habits.watchHabits().switchMap<List<HabitListItem>>((list) {
      if (list.isEmpty) {
        return Stream.value(const <HabitListItem>[]);
      }
      final perHabit = list.map((h) =>
          _completions.watchWeeklyProgress(h.id).map((p) => HabitListItem(
                habit: h,
                progress: p,
                participantsCount: 1,
              )));
      return Rx.combineLatestList<HabitListItem>(perHabit);
    }).listen(
      (items) {
        _items = items;
        _isLoading = false;
        notifyListeners();
      },
      onError: (Object e) {
        _error = e;
        _isLoading = false;
        notifyListeners();
      },
    );
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
