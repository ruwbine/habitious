import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/models/friend.dart';
import '../../data/models/habit_color.dart';
import '../../data/models/habit_icon.dart';
import '../../data/models/reminder_time.dart';
import '../../data/models/weekday.dart';
import '../../data/repositories/habit_repository.dart';
import '../../data/repositories/social_repository.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
        title: Text(l.createHabit),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          _SectionLabel(l.habitNameLabel),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setName,
            decoration: InputDecoration(hintText: l.habitNameLabel),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l.frequencyLabel),
          const SizedBox(height: 10),
          DayChipsSelector(
            selectedDays: vm.schedule.map((d) => d.index).toSet(),
            onChanged: (set) =>
                vm.setSchedule(set.map((i) => Weekday.values[i]).toSet()),
          ),
          const SizedBox(height: 20),
          _SectionLabel(l.teamLabel),
          const SizedBox(height: 10),
          const _TeamAvatarsRow(),
          const SizedBox(height: 20),
          _SectionLabel(l.remindersLabel),
          const SizedBox(height: 10),
          _ReminderCard(
            reminder: vm.reminder,
            onChanged: vm.setReminder,
          ),
          const SizedBox(height: 20),
          _SectionLabel(l.cardColorLabel),
          const SizedBox(height: 10),
          _ColorPicker(selected: vm.color, onChanged: vm.setColor),
          const SizedBox(height: 16),
          _IconPicker(
            color: vm.color,
            selected: vm.icon,
            onChanged: vm.setIcon,
          ),
          const SizedBox(height: 28),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: cs.onSurface.withValues(alpha: 0.7),
      ),
    );
  }
}

class _TeamAvatarsRow extends StatelessWidget {
  const _TeamAvatarsRow();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return StreamBuilder<List<Friend>>(
      stream: context.read<SocialRepository>().watchFriends(),
      builder: (_, snapshot) {
        final friends = (snapshot.data ?? const <Friend>[]).take(4).toList();
        return Row(
          children: [
            for (final f in friends) ...[
              CircleAvatar(
                radius: 22,
                backgroundColor: cs.surfaceContainerHighest,
                child: Text(
                  f.displayName.isNotEmpty
                      ? f.displayName.characters.first
                      : '?',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: cs.primary.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.add, color: cs.primary),
            ),
          ],
        );
      },
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder, required this.onChanged});
  final ReminderTime? reminder;
  final ValueChanged<ReminderTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final isOn = reminder != null;
    final timeStr = reminder == null
        ? '09:00'
        : '${reminder!.hour.toString().padLeft(2, '0')}:${reminder!.minute.toString().padLeft(2, '0')}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.notifications_none,
              color: cs.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.reminderEveryDayAt(timeStr),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch.adaptive(
            value: isOn,
            onChanged: (on) =>
                onChanged(on ? const ReminderTime(hour: 9, minute: 0) : null),
          ),
        ],
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({required this.selected, required this.onChanged});
  final HabitColor selected;
  final ValueChanged<HabitColor> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      children: HabitColor.values.map((c) {
        final isSelected = selected == c;
        return GestureDetector(
          onTap: () => onChanged(c),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? c.value : Colors.transparent,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: c.value,
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _IconPicker extends StatelessWidget {
  const _IconPicker({
    required this.color,
    required this.selected,
    required this.onChanged,
  });
  final HabitColor color;
  final HabitIcon selected;
  final ValueChanged<HabitIcon> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: HabitIcon.values.map((ic) {
        final isSelected = selected == ic;
        return GestureDetector(
          onTap: () => onChanged(ic),
          child: Opacity(
            opacity: isSelected ? 1.0 : 0.4,
            child: HabitIconBadge(color: color, icon: ic),
          ),
        );
      }).toList(),
    );
  }
}
