import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/models/habit_color.dart';
import '../../data/models/habit_icon.dart';
import '../../data/models/reminder_time.dart';
import '../../data/models/weekday.dart';
import '../../data/repositories/habit_repository.dart';
import '../../data/services/notification_service.dart';
import '../../l10n/app_localizations.dart';
import '../core/widgets/day_chips_selector.dart';
import '../core/widgets/habit_icon_badge.dart';
import '../core/widgets/primary_button.dart';
import 'view_models/create_habit_view_model.dart';

class CreateHabitScreen extends StatelessWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateHabitViewModel(
        context.read<HabitRepository>(),
        context.read<NotificationService>(),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vm = context.watch<CreateHabitViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(l.createHabit)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l.habitNameLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setName,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text(
            l.frequencyLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DayChipsSelector(
            selectedDays: vm.schedule.map((d) => d.index).toSet(),
            onChanged: (set) =>
                vm.setSchedule(set.map((i) => Weekday.values[i]).toSet()),
          ),
          const SizedBox(height: 16),
          Text(
            l.remindersLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: vm.reminder != null,
            onChanged: (on) => vm.setReminder(
              on ? const ReminderTime(hour: 9, minute: 0) : null,
            ),
            title: Text(
              vm.reminder == null
                  ? l.remindersLabel
                  : l.reminderEveryDayAt(
                      '${vm.reminder!.hour.toString().padLeft(2, '0')}:${vm.reminder!.minute.toString().padLeft(2, '0')}',
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l.cardColorLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: HabitColor.values
                .map(
                  (c) => GestureDetector(
                    onTap: () => vm.setColor(c),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: c.value,
                      child: vm.color == c
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: HabitIcon.values
                .map(
                  (ic) => GestureDetector(
                    onTap: () => vm.setIcon(ic),
                    child: Opacity(
                      opacity: vm.icon == ic ? 1.0 : 0.4,
                      child: HabitIconBadge(color: vm.color, icon: ic),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: l.createHabit,
            onPressed: vm.canSubmit
                ? () async {
                    final id = await vm.submitCommand.run(null);
                    if (id != null && context.mounted) context.pop();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
