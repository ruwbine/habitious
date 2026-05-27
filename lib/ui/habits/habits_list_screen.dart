import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/completion_repository.dart';
import '../../data/repositories/habit_repository.dart';
import '../../l10n/app_localizations.dart';
import '../core/widgets/habit_card.dart';
import 'view_models/habit_list_item.dart';
import 'view_models/habits_list_view_model.dart';

class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final repo = context.read<HabitRepository>();
    final completions = context.read<CompletionRepository>();
    return ChangeNotifierProvider(
      create: (_) => HabitsListViewModel(repo, completions)..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HabitsListViewModel>();
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.habitsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/create'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<HabitsTab>(
              segments: [
                ButtonSegment(value: HabitsTab.all, label: Text(l.tabAll)),
                ButtonSegment(
                  value: HabitsTab.active,
                  label: Text(l.tabActive),
                ),
                ButtonSegment(
                  value: HabitsTab.archive,
                  label: Text(l.tabArchive),
                ),
              ],
              selected: {vm.tab},
              onSelectionChanged: (s) => vm.switchTab(s.first),
            ),
          ),
        ),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: vm.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => HabitCard(
                item: vm.items[i],
                onTap: () =>
                    context.push('/habit/${vm.items[i].habit.id.value}'),
              ),
            ),
    );
  }
}
