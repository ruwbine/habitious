import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/completion_repository.dart';
import '../../data/repositories/habit_repository.dart';
import '../../l10n/app_localizations.dart';
import '../core/widgets/habit_card.dart';
import '../core/widgets/pill_tabs.dart';
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
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l.habitsTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, size: 20, color: Colors.white),
            ),
            onPressed: () => context.push('/create'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                  child: PillTabs<HabitsTab>(
                    tabs: [
                      PillTab(value: HabitsTab.all, label: l.tabAll),
                      PillTab(value: HabitsTab.active, label: l.tabActive),
                      PillTab(value: HabitsTab.archive, label: l.tabArchive),
                    ],
                    selected: vm.tab,
                    onChanged: vm.switchTab,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: vm.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => HabitCard(
                      item: vm.items[i],
                      onTap: () =>
                          context.push('/habit/${vm.items[i].habit.id.value}'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
