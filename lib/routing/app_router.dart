import 'package:go_router/go_router.dart';
import '../ui/core/widgets/root_shell.dart';
import '../ui/habits/create_habit_screen.dart';
import '../ui/habits/habit_detail_screen.dart';
import '../ui/habits/habits_list_screen.dart';
import '../ui/stats/stats_screen.dart';
import '../ui/friends/friends_screen.dart';
import '../ui/profile/profile_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            RootShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const HabitsListScreen()),
          GoRoute(path: '/stats', builder: (_, __) => const StatsScreen()),
          GoRoute(path: '/friends', builder: (_, __) => const FriendsScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ],
      ),
      GoRoute(path: '/create', builder: (_, __) => const CreateHabitScreen()),
      GoRoute(path: '/habit/:id', builder: (_, state) => HabitDetailScreen(habitId: state.pathParameters['id']!)),
    ],
  );
}
