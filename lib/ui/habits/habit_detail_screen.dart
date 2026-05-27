import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/typed_ids.dart';
import '../../data/repositories/completion_repository.dart';
import '../../data/repositories/habit_repository.dart';
import '../../data/repositories/social_repository.dart';
import '../../data/services/clock_service.dart';
import '../../l10n/app_localizations.dart';
import '../../profile_sync.dart';
import '../core/widgets/secondary_button.dart';
import 'view_models/habit_detail_view_model.dart';
import 'widgets/group_completion_header.dart';
import 'widgets/habit_heatmap.dart';
import 'widgets/leaderboard_list.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});
  final String habitId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HabitDetailViewModel(
        ctx.read<HabitRepository>(),
        ctx.read<CompletionRepository>(),
        ctx.read<SocialRepository>(),
        ctx.read<ClockService>(),
        ctx.read<HardcoreFlag>(),
        habitId: HabitId(habitId),
      )..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HabitDetailViewModel>();
    final l = AppLocalizations.of(context);
    final habit = vm.habit;
    if (habit == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          GroupCompletionHeader(
            percent: vm.group?.completionPercentThisWeek ?? 0,
            streak: vm.streak?.currentStreak ?? 0,
            color: habit.color,
            icon: habit.icon,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () => vm.changeMonthCommand.run(
                  DateTime(vm.visibleMonth.year, vm.visibleMonth.month - 1),
                ),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _monthLabel(vm.visibleMonth),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => vm.changeMonthCommand.run(
                  DateTime(vm.visibleMonth.year, vm.visibleMonth.month + 1),
                ),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          HabitHeatmap(
            month: vm.visibleMonth,
            completedDates: vm.monthCompletions,
            scheduledDays: habit.schedule,
            color: habit.color,
            onTapDay: (d) => vm.toggleDayCommand.run(d),
          ),
          const SizedBox(height: 24),
          if (vm.leaderboard.isNotEmpty) ...[
            Text(l.leaderboard, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            LeaderboardList(entries: vm.leaderboard),
            const SizedBox(height: 16),
          ],
          SecondaryButton(
            label: l.remindLazyOnes,
            onPressed: vm.group == null
                ? null
                : () => vm.nudgeLazyCommand.run(null),
          ),
        ],
      ),
    );
  }
}

const _monthsRu = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];

String _monthLabel(DateTime d) => '${_monthsRu[d.month - 1]} ${d.year}';
