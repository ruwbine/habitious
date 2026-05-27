# Habitious — Design Spec

**Date:** 2026-05-27
**Status:** Approved (design phase)
**Source:** Mockup at `design.jpg` (Russian-language habit tracker with light + dark themes)

## 1. Purpose and scope

Habitious is a Flutter habit-tracking app for Android and iOS. Users create
habits with a weekday schedule, mark completions, see a calendar heatmap and
streak counter, and (in later phases) join group habits with friends and
compete on a leaderboard.

### Phase 1 — local-only

Functional, no backend:

- Habit CRUD (create, edit, archive, delete) with name, fixed-preset icon
  and color, weekday schedule, optional daily reminder.
- Boolean per-day completion. Any past day may be toggled.
- Monthly calendar heatmap (swipe to prior months).
- Streak counter with two modes:
  - **Normal**: missing a scheduled day consumes a freeze; one freeze per
    Mon–Sun week. No freezes left → streak resets.
  - **Hardcore**: no freezes; any missed scheduled day resets the streak.
- Local push reminders (`flutter_local_notifications`).
- Profile screen with display name, avatar, level/XP (stubbed UI), hardcore
  toggle, theme preference (system / light / dark), locale (Russian /
  English).

Stubbed (UI renders against seeded fake data behind a repository interface):

- Friends list, friend requests, search-by-username.
- Group habits with shared completion %, member avatars, leaderboard.
- "Remind lazy ones" button (no-op).
- Level/XP numeric values.

### Out of scope (phase 2+)

- Backend, authentication, real social features, push from server, syncing
  across devices, web/desktop targets.

## 2. Decisions captured during brainstorming

| Topic              | Decision                                                       |
|--------------------|----------------------------------------------------------------|
| Backend            | Local-only first; abstract repositories ready for phase 2      |
| State management   | `ChangeNotifier` + `provider` (matches Flutter team's default) |
| Local database     | Drift (type-safe SQL, reactive streams, codegen migrations)    |
| Localization       | Russian + English via `flutter_localizations` + ARB            |
| Platforms          | Android + iOS                                                  |
| Theming            | Light + dark, follow system with user override                 |
| Habit completion   | Boolean per day                                                |
| Past-day editing   | Any past day editable                                          |
| Icons + colors     | Fixed enum-based presets matching the mockup palette           |
| Heatmap            | Monthly grid, swipe to prior months                            |
| Level/XP           | Stubbed UI only in phase 1                                     |
| Hardcore mode      | Stricter streak rules (no freezes)                             |

## 3. Architecture

MVVM + repository pattern per the Flutter team's recommendations.

### Layers

- **UI layer** — Views (widgets) + ViewModels (`ChangeNotifier`s).
  Views contain only flag-driven branching, layout math, and navigation.
- **Data layer** — Abstract `Repository` interfaces with concrete
  implementations. Services (`NotificationService`, `ClockService`) live
  here as well.
- **Domain layer** — Not introduced in phase 1. Add use-cases later only if
  a ViewModel grows unwieldy.

### Folder layout (hybrid: feature folders + cross-cutting data)

```
lib/
  main.dart
  app.dart                  # MaterialApp, theme, router, root Providers
  routing/                  # go_router config
  data/
    repositories/
      habit_repository.dart
      completion_repository.dart
      social_repository.dart
      profile_repository.dart
    services/
      app_database.dart     # drift
      notification_service.dart
      clock_service.dart
    models/                 # freezed domain models
  ui/
    core/
      themes/               # light_theme.dart, dark_theme.dart, color_tokens.dart
      widgets/              # PrimaryButton, SecondaryButton, DayChipsSelector,
                            # HabitCard, HabitColorDot, HabitIconBadge, ...
      l10n/                 # generated localization
    habits/
      view_models/
      widgets/              # screen-specific widgets
      habits_list_screen.dart
      habit_detail_screen.dart
      create_habit_screen.dart
    profile/
      view_models/
      profile_screen.dart
    stats/
    friends/
test/
  unit/
  widget/
  fakes/
```

Rationale: UI groups by feature so each screen's widgets + ViewModels sit
together; the data layer is global because repositories are reused across
features (e.g., `HabitRepository` is used by both the list and detail
screens).

## 4. Data model

Immutable, generated with `freezed`. Typed ID wrappers (`extension type
HabitId(String value)`) prevent ID-mixup bugs without runtime overhead.

### Domain models

- **Habit** — id, name, color (enum), icon (enum), schedule (`Set<Weekday>`),
  optional `ReminderTime`, status (`active | archived`), createdAt,
  optional groupId.
- **HabitCompletion** — habitId, date (local midnight), markedAt.
- **StreakInfo** — currentStreak, longestStreak, freezesRemainingThisWeek.
  Computed on read; never persisted.
- **UserProfile** — displayName, avatarPath, level, xp, hardcoreMode,
  themePreference, locale.
- **Friend / FriendRequest / Group / GroupMember / LeaderboardEntry** —
  used by stubbed `SocialRepository`.

### Drift schema

- `habits` — id (PK), name, colorIndex, iconIndex, scheduleBitmask
  (7-bit, Mon = bit 0), reminderMinutes (nullable, 0–1439),
  reminderEnabled, statusIndex, createdAt, groupId (nullable).
- `habit_completions` — habitId + date composite PK, markedAt. Date
  normalized to local midnight. ON DELETE CASCADE from `habits`.
- `user_profile` — singleton row (id always 0): displayName, avatarPath,
  level, xp, hardcoreMode, themePreferenceIndex, localeTag.

Friends/groups have no tables in phase 1.

## 5. Repositories and services

### Repository contracts

```dart
abstract interface class HabitRepository {
  Stream<List<Habit>> watchHabits({HabitStatus? status});
  Future<Habit?> findHabit(HabitId id);
  Future<void> upsertHabit(Habit habit);
  Future<void> archiveHabit(HabitId id);
  Future<void> deleteHabit(HabitId id);
}

abstract interface class CompletionRepository {
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range);
  Future<bool> isCompleted(HabitId id, DateTime date);
  Future<void> markCompleted(HabitId id, DateTime date);
  Future<void> unmarkCompleted(HabitId id, DateTime date);
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore});
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id);
}

abstract interface class ProfileRepository {
  Stream<UserProfile> watchProfile();
  Future<void> updateProfile(UserProfile profile);
}

abstract interface class SocialRepository {
  Stream<List<Friend>> watchFriends();
  Stream<List<FriendRequest>> watchIncomingRequests();
  Future<List<Friend>> searchByUsername(String query);
  Stream<Group?> watchGroupForHabit(HabitId habitId);
  Stream<List<LeaderboardEntry>> watchLeaderboard(GroupId groupId);
  Future<void> nudgeLazyMembers(GroupId groupId);
}
```

### Concrete implementations

- `DriftHabitRepository`, `DriftCompletionRepository`,
  `DriftProfileRepository` — wrap Drift DAOs.
- `FakeSocialRepository.seeded()` — returns seeded `Friend` /
  `FriendRequest` / `Group` / `LeaderboardEntry` lists via
  `BehaviorSubject`s so the UI feels reactive.

### Services

- `ClockService` — abstracts `DateTime.now()` for testability.
  `SystemClockService` in prod, `FakeClockService` in tests.
- `NotificationService` — wraps `flutter_local_notifications`. Implements
  permission requests and weekly-repeating reminder scheduling per habit.
  `FakeNotificationService` records calls for tests.

### Streak computation (CompletionRepository.computeStreak)

1. Walk backwards from today, considering only the habit's **scheduled**
   days (skip non-scheduled weekdays — they don't penalize the user).
2. For each past scheduled day:
   - completed → `currentStreak += 1`.
   - missed + hardcore → streak ends.
   - missed + normal + freezes remain in that day's Mon–Sun week →
     consume a freeze, continue.
   - missed + no freezes → streak ends.
3. `freezesRemainingThisWeek` resets every Monday. Normal mode allows 1
   freeze per week.
4. Today never breaks the streak — only past scheduled days can.

### Dependency injection

`provider` `MultiProvider` at the root of `HabitiousApp` builds:

```dart
Provider<ClockService>           // SystemClockService
Provider<AppDatabase>            // drift database
Provider<NotificationService>    // flutter_local_notifications backed
ProxyProvider → HabitRepository
ProxyProvider2 → CompletionRepository
Provider → ProfileRepository
Provider → SocialRepository      // FakeSocialRepository.seeded()
```

ViewModels are created with `ChangeNotifierProvider` at the screen route so
each screen owns a fresh, properly-disposed ViewModel.

## 6. ViewModels per screen

All ViewModels use a small `Command<Arg, Result>` helper that exposes
`running`, `lastResult`, and `error` and notifies listeners — views render
loading/error states uniformly without each VM reinventing flags.

### HabitsListViewModel (Мои привычки)

State: tab (`all | active | archive`), `List<HabitListItem>`, isLoading,
error. Subscribes to `HabitRepository.watchHabits` joined with per-habit
`watchWeeklyProgress` to drive the "6/7 days" label. Commands: `load`,
`switchTab`, `toggleToday(habitId)`.

The bottom-nav (Home/Stats/Friends/Profile) lives in a shared `RootShell`
widget driven by `go_router`'s `ShellRoute`, not in this ViewModel.

### HabitDetailViewModel (Пить воду)

State: habit, streakInfo, group (nullable for solo habits), monthly
completion set, leaderboard, visibleMonth. Commands: `toggleDay`,
`changeMonth`, `nudgeLazy` (calls `SocialRepository.nudgeLazyMembers` —
no-op in phase 1).

The heatmap widget receives `monthCompletions` and the habit's
`scheduledDays` so it can render three cell states: scheduled-and-done,
scheduled-and-missed, not-scheduled.

### CreateHabitViewModel (Создание привычки)

Pure form state — no IO until submit. Fields: name, schedule, reminder,
color, icon, invitedFriendIds. `canSubmit` true when name is non-empty
and at least one weekday is selected. `submitCommand` validates → upserts
the habit → schedules notifications if reminder set → returns the new
`HabitId`.

The "team" picker reads from `SocialRepository.watchFriends()` (seeded
fake data). In phase 1 the invited IDs are held only in form state and
discarded on submit — there's no persistence target until groups exist.
Phase 2 will add an `invited_friends` table or attach the IDs at group
creation time, depending on the backend shape.

### ProfileViewModel (Профиль)

State: profile, friends list, incoming friend requests. Commands:
`toggleHardcoreMode`, `setThemePreference`, `setLocale`, `searchUsername`,
`acceptRequest`, `declineRequest` (the last three are stubbed in phase 1).

Theme and locale changes flow through a root-level `AppPreferences`
`ChangeNotifier` that drives `MaterialApp.themeMode` and `locale`.

## 7. Navigation, errors, theming

### Navigation

`go_router` with a `ShellRoute` for the bottom-nav tabs.

| Route             | Screen                     |
|-------------------|----------------------------|
| `/`               | Habits list                |
| `/stats`          | Stats (reuses heatmap)     |
| `/friends`        | Friends                    |
| `/profile`        | Profile                    |
| `/habit/:id`      | Habit detail               |
| `/create`         | Create habit               |

### Error handling

Repositories complete Futures exceptionally with typed errors
(`HabitNotFound`, `PersistenceFailure`). ViewModels' `Command`s capture
and expose the exception; views show a snackbar for transient errors and
an empty-state widget for "nothing here yet".

### Theming

Two `ThemeData` objects in `ui/core/themes/` map the mockup color palette
(purple primary `#7861FF`, supporting teal/orange/pink, neutrals) to
Material 3 `ColorScheme` and text styles (Inter, since the mockup
specifies "SF Pro Display / Inter").

## 8. Testing strategy

Following the Flutter team's recommendation to prefer fakes over mocks:

- `test/fakes/` — `InMemoryHabitRepository`,
  `InMemoryCompletionRepository`, `FakeClockService`,
  `FakeNotificationService`, `FakeSocialRepository`. Real implementations
  backed by collections — no mocking library.
- **Unit tests** for every ViewModel: state transitions, command
  success/error paths, streak edge cases (hardcore vs normal, week
  boundaries, freeze consumption, scheduled vs unscheduled days), heatmap
  month math.
- **Widget tests** per screen: pump the screen with seeded fakes, verify
  tab switching, list rendering, form validation, navigation. Golden
  tests for the habit card and day-chip selector.
- **Drift tests** with `NativeDatabase.memory()` for repository impls:
  round-trip persistence, schema migrations, range queries.
- CI: `flutter analyze` + `flutter test`. No integration tests in phase 1.

## 9. Phased delivery

1. **Foundations** — project scaffold, theming, l10n, design-system
   widgets, root shell + go_router.
2. **Habit CRUD** — Drift schema, `HabitRepository`, list screen, create
   screen.
3. **Completion + heatmap + streaks** — `CompletionRepository`, heatmap
   widget, streak computation, habit detail screen.
4. **Reminders** — `NotificationService`, scheduling on habit save,
   permission flow.
5. **Profile + preferences** — profile screen, theme + locale toggles,
   hardcore mode toggle.
6. **Stubbed social** — `FakeSocialRepository`, friends list, leaderboard
   widget, group summary on habit detail.

The implementation plan (next step after this spec is approved) will turn
these milestones into concrete tasks with verification steps.
