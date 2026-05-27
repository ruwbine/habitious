# Habitious Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Russian/English Flutter habit tracker (Habitious) for Android and iOS — local-only first, mirroring the mockup in `design.jpg`, with stubbed social features behind repository interfaces ready for a phase-2 backend swap.

**Architecture:** MVVM + repository pattern per the Flutter team's recommendations. Feature folders under `ui/`, cross-cutting `data/` layer with abstract repositories + concrete `Drift` implementations + a `FakeSocialRepository` for stubbed social. `provider` for dependency injection and `ChangeNotifier` ViewModels. `go_router` `ShellRoute` for the bottom-nav.

**Tech Stack:** Flutter 3.22+, Dart 3.3+, `drift` (sqlite), `provider`, `freezed`, `go_router`, `flutter_local_notifications`, `flutter_localizations` (ru + en), `rxdart` (BehaviorSubject for the fake social repo), `intl`. Tests use real fakes (not mocks), `NativeDatabase.memory()` for repo tests.

**Spec:** `docs/superpowers/specs/2026-05-27-habitious-design.md`

---

## Conventions used in this plan

- **TDD where it pays off**: ViewModels and repositories are written test-first. Widgets are written then verified with widget tests / golden tests (pure-TDD widget development is awkward in Flutter; build then test the rendered tree).
- **Codegen rebuilds**: After editing any file that uses `freezed`, `drift`, `json_serializable`, or `go_router_builder`, run `dart run build_runner build --delete-conflicting-outputs`.
- **Verification commands**: After each task, run `flutter analyze && flutter test`. If both pass, commit. If either fails, fix the failure in the current task before moving on.
- **Commit style**: Conventional commits (`feat:`, `test:`, `chore:`, `refactor:`). One commit per task unless noted.
- **iOS builds** require macOS. On Linux, you can run `flutter analyze` and `flutter test` but not `flutter build ios`. Use Android emulator for manual verification.

---

## Milestone 0 — Project foundation

### Task 1: Verify toolchain

**Files:** none

- [ ] **Step 1: Confirm Flutter is installed**

Run: `flutter --version`
Expected: prints Flutter 3.22+ and Dart 3.3+. If not installed, install Flutter following https://docs.flutter.dev/get-started/install for your OS, then re-run.

- [ ] **Step 2: Run flutter doctor**

Run: `flutter doctor`
Expected: green checkmarks for Flutter, Android toolchain, and at least one device (emulator or physical). Resolve any red entries before continuing. (macOS users: iOS toolchain too.)

- [ ] **Step 3: Confirm working directory**

Run: `pwd`
Expected: `/home/intelx-ai/projects/habitious` (or your equivalent project root). Confirm `design.jpg` is present: `ls design.jpg`.

---

### Task 2: Initialize git and Flutter project

**Files:**
- Create: `.gitignore` (Flutter default)
- Create: entire Flutter project tree under the current directory

- [ ] **Step 1: Initialize git**

Run: `git init && git add design.jpg docs && git commit -m "chore: initial design assets and spec"`
Expected: initial commit with the design image and spec.

- [ ] **Step 2: Scaffold the Flutter app in place**

Run from project root:
```
flutter create . \
  --org dev.habitious \
  --project-name habitious \
  --platforms=android,ios \
  --description "Habitious — habit tracker"
```
Expected: project files appear (`lib/main.dart`, `android/`, `ios/`, `pubspec.yaml`, etc.).

- [ ] **Step 3: Verify the scaffold builds**

Run: `flutter pub get && flutter analyze && flutter test`
Expected: 0 issues, default counter test passes.

- [ ] **Step 4: Commit scaffold**

```
git add -A
git commit -m "chore: scaffold Flutter project (android+ios)"
```

---

### Task 3: Add dependencies

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Replace dependency blocks**

In `pubspec.yaml` set:
```yaml
environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=3.22.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.6
  provider: ^6.1.2
  go_router: ^14.2.0
  drift: ^2.18.0
  drift_flutter: ^0.2.0
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  flutter_local_notifications: ^17.2.2
  timezone: ^0.9.4
  rxdart: ^0.27.7
  intl: any

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  build_runner: ^2.4.11
  drift_dev: ^2.18.0
  freezed: ^2.5.7
  json_serializable: ^6.8.0

flutter:
  uses-material-design: true
  generate: true        # for l10n
```

- [ ] **Step 2: Get packages**

Run: `flutter pub get`
Expected: resolves without errors.

- [ ] **Step 3: Commit**

```
git add pubspec.yaml pubspec.lock
git commit -m "chore: add core dependencies (drift, provider, go_router, freezed, local_notifications)"
```

---

### Task 4: Configure lints

**Files:**
- Modify: `analysis_options.yaml`

- [ ] **Step 1: Tighten lints**

Replace `analysis_options.yaml` with:
```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: ignore
  language:
    strict-casts: true
    strict-raw-types: true

linter:
  rules:
    prefer_single_quotes: true
    require_trailing_commas: true
    avoid_print: true
    always_use_package_imports: false  # spec calls for relative imports
    prefer_relative_imports: true
    sort_pub_dependencies: false
```

- [ ] **Step 2: Verify analyzer is clean**

Run: `flutter analyze`
Expected: 0 issues.

- [ ] **Step 3: Commit**

```
git add analysis_options.yaml
git commit -m "chore: tighten lints to match Effective Dart"
```

---

### Task 5: Set up localization scaffolding

**Files:**
- Create: `l10n.yaml`
- Create: `lib/l10n/app_en.arb`
- Create: `lib/l10n/app_ru.arb`

- [ ] **Step 1: Configure l10n generator**

Create `l10n.yaml`:
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false
```

- [ ] **Step 2: Seed English strings**

Create `lib/l10n/app_en.arb`:
```json
{
  "@@locale": "en",
  "appTitle": "Habitious",
  "tabAll": "All",
  "tabActive": "Active",
  "tabArchive": "Archive",
  "navHome": "Home",
  "navStats": "Stats",
  "navFriends": "Friends",
  "navProfile": "Profile",
  "habitsTitle": "My Habits",
  "createHabit": "Create habit",
  "habitNameLabel": "Habit name",
  "frequencyLabel": "Frequency",
  "teamLabel": "Team",
  "remindersLabel": "Reminders",
  "reminderEveryDayAt": "Every day at {time}",
  "@reminderEveryDayAt": {"placeholders": {"time": {"type": "String"}}},
  "cardColorLabel": "Card color",
  "remindLazyOnes": "Remind lazy ones",
  "profileTitle": "Profile",
  "hardcoreMode": "Hardcore mode",
  "addFriends": "Add friends",
  "searchByUsername": "Search by username",
  "myQrCode": "My QR code",
  "scanQr": "Scan QR",
  "friendRequests": "Friend requests ({count})",
  "@friendRequests": {"placeholders": {"count": {"type": "int"}}},
  "myFriends": "My friends",
  "sharedHabitsCount": "{count, plural, one{1 shared habit} other{{count} shared habits}}",
  "@sharedHabitsCount": {"placeholders": {"count": {"type": "int"}}},
  "level": "Level {n}",
  "@level": {"placeholders": {"n": {"type": "int"}}},
  "weekProgress": "{done}/{total} days",
  "@weekProgress": {"placeholders": {"done": {"type": "int"}, "total": {"type": "int"}}},
  "streakDays": "{n} days",
  "@streakDays": {"placeholders": {"n": {"type": "int"}}},
  "groupCompletion": "Group completion {percent}%",
  "@groupCompletion": {"placeholders": {"percent": {"type": "int"}}},
  "weekdayMon": "Mon", "weekdayTue": "Tue", "weekdayWed": "Wed",
  "weekdayThu": "Thu", "weekdayFri": "Fri", "weekdaySat": "Sat", "weekdaySun": "Sun",
  "themeSystem": "System", "themeLight": "Light", "themeDark": "Dark",
  "languageRu": "Russian", "languageEn": "English",
  "save": "Save", "cancel": "Cancel"
}
```

- [ ] **Step 3: Seed Russian strings (mirroring keys)**

Create `lib/l10n/app_ru.arb`:
```json
{
  "@@locale": "ru",
  "appTitle": "Habitious",
  "tabAll": "Все",
  "tabActive": "Активные",
  "tabArchive": "Архив",
  "navHome": "Главная",
  "navStats": "Статистика",
  "navFriends": "Друзья",
  "navProfile": "Профиль",
  "habitsTitle": "Мои привычки",
  "createHabit": "Создать привычку",
  "habitNameLabel": "Название привычки",
  "frequencyLabel": "Частота",
  "teamLabel": "Команда",
  "remindersLabel": "Напоминания",
  "reminderEveryDayAt": "Каждый день в {time}",
  "cardColorLabel": "Цвет карточки",
  "remindLazyOnes": "Напомнить ленивым",
  "profileTitle": "Профиль",
  "hardcoreMode": "Хардкор режим",
  "addFriends": "Добавить друзей",
  "searchByUsername": "Поиск по username",
  "myQrCode": "Мой QR-код",
  "scanQr": "Сканировать QR",
  "friendRequests": "Запросы в друзья ({count})",
  "myFriends": "Мои друзья",
  "sharedHabitsCount": "{count, plural, one{1 общая привычка} few{{count} общие привычки} many{{count} общих привычек} other{{count} общих привычек}}",
  "level": "Уровень {n}",
  "weekProgress": "{done}/{total} дней",
  "streakDays": "{n} дней",
  "groupCompletion": "Группа выполнила {percent}%",
  "weekdayMon": "Пн", "weekdayTue": "Вт", "weekdayWed": "Ср",
  "weekdayThu": "Чт", "weekdayFri": "Пт", "weekdaySat": "Сб", "weekdaySun": "Вс",
  "themeSystem": "Системная", "themeLight": "Светлая", "themeDark": "Тёмная",
  "languageRu": "Русский", "languageEn": "Английский",
  "save": "Сохранить", "cancel": "Отмена"
}
```

- [ ] **Step 4: Generate localization code**

Run: `flutter gen-l10n`
Expected: generates `lib/l10n/app_localizations.dart` (or under `.dart_tool/`) without error.

- [ ] **Step 5: Commit**

```
git add l10n.yaml lib/l10n
git commit -m "feat(l10n): seed Russian + English ARB files"
```

---

### Task 6: Color tokens

**Files:**
- Create: `lib/ui/core/themes/color_tokens.dart`

- [ ] **Step 1: Write the tokens**

```dart
import 'package:flutter/material.dart';

/// Color tokens lifted from design.jpg.
/// Hex values come from the palette section of the mockup.
class HabitiousColors {
  HabitiousColors._();

  // Brand
  static const Color brandPurple = Color(0xFF7861FF);
  static const Color brandPurpleAlt = Color(0xFF1F1FF5);

  // Accent / habit card palette
  static const Color accentTeal = Color(0xFF00D4AA);
  static const Color accentOrange = Color(0xFFFFB347);
  static const Color accentPink = Color(0xFFFF5C8A);
  static const Color accentBlue = Color(0xFF008894);
  static const Color accentRed = Color(0xFFFF5C5C);
  static const Color accentWhite = Color(0xFFFFFFFF);

  // Dark surfaces
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceAlt = Color(0xFF2A2A2A);

  // Light surfaces
  static const Color lightBackground = Color(0xFFF8F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF1F1F5);

  // Text
  static const Color textHighEmphasisDark = Color(0xFFFFFFFF);
  static const Color textMediumEmphasisDark = Color(0xB3FFFFFF);
  static const Color textHighEmphasisLight = Color(0xFF1A1A1A);
  static const Color textMediumEmphasisLight = Color(0x99000000);
}
```

- [ ] **Step 2: Verify and commit**

Run: `flutter analyze`
Expected: 0 issues.
```
git add lib/ui/core/themes/color_tokens.dart
git commit -m "feat(theme): add color tokens from design palette"
```

---

### Task 7: Light + dark ThemeData

**Files:**
- Create: `lib/ui/core/themes/light_theme.dart`
- Create: `lib/ui/core/themes/dark_theme.dart`

- [ ] **Step 1: Light theme**

```dart
// lib/ui/core/themes/light_theme.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

ThemeData buildLightTheme() {
  const seed = HabitiousColors.brandPurple;
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
    surface: HabitiousColors.lightSurface,
    background: HabitiousColors.lightBackground,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: HabitiousColors.lightBackground,
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    cardTheme: CardTheme(
      color: HabitiousColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
```

- [ ] **Step 2: Dark theme**

```dart
// lib/ui/core/themes/dark_theme.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

ThemeData buildDarkTheme() {
  const seed = HabitiousColors.brandPurple;
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
    surface: HabitiousColors.darkSurface,
    background: HabitiousColors.darkBackground,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: HabitiousColors.darkBackground,
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: HabitiousColors.textHighEmphasisDark),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: HabitiousColors.textHighEmphasisDark),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: HabitiousColors.textHighEmphasisDark),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: HabitiousColors.textHighEmphasisDark),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HabitiousColors.textMediumEmphasisDark),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HabitiousColors.textMediumEmphasisDark),
    ),
    cardTheme: CardTheme(
      color: HabitiousColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
```

- [ ] **Step 3: Verify and commit**

Run: `flutter analyze`
Expected: 0 issues.
```
git add lib/ui/core/themes
git commit -m "feat(theme): light and dark ThemeData"
```

---

### Task 8: AppPreferences (theme + locale ChangeNotifier)

**Files:**
- Create: `lib/app_preferences.dart`
- Create: `test/unit/app_preferences_test.dart`

- [ ] **Step 1: Write failing test**

```dart
// test/unit/app_preferences_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/app_preferences.dart';

void main() {
  test('starts with system theme and Russian locale', () {
    final prefs = AppPreferences();
    expect(prefs.themeMode, ThemeMode.system);
    expect(prefs.locale, const Locale('ru'));
  });

  test('setTheme notifies and stores value', () {
    final prefs = AppPreferences();
    var calls = 0;
    prefs.addListener(() => calls++);
    prefs.setTheme(ThemeMode.dark);
    expect(prefs.themeMode, ThemeMode.dark);
    expect(calls, 1);
  });

  test('setLocale notifies and stores value', () {
    final prefs = AppPreferences();
    var calls = 0;
    prefs.addListener(() => calls++);
    prefs.setLocale(const Locale('en'));
    expect(prefs.locale, const Locale('en'));
    expect(calls, 1);
  });
}
```

- [ ] **Step 2: Run — verify it fails**

Run: `flutter test test/unit/app_preferences_test.dart`
Expected: FAIL (`AppPreferences` not defined).

- [ ] **Step 3: Implement AppPreferences**

```dart
// lib/app_preferences.dart
import 'package:flutter/material.dart';

class AppPreferences extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ru');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void setTheme(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
```

- [ ] **Step 4: Run — verify pass**

Run: `flutter test test/unit/app_preferences_test.dart`
Expected: 3 tests pass.

- [ ] **Step 5: Commit**

```
git add lib/app_preferences.dart test/unit/app_preferences_test.dart
git commit -m "feat(app): AppPreferences notifier for theme and locale"
```

---

### Task 9: Command<Arg,Result> helper

**Files:**
- Create: `lib/ui/core/command.dart`
- Create: `test/unit/ui/core/command_test.dart`

- [ ] **Step 1: Failing test**

```dart
// test/unit/ui/core/command_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/ui/core/command.dart';

void main() {
  test('reports running state and result on success', () async {
    final cmd = Command<int, int>((x) async => x * 2);
    expect(cmd.running, isFalse);
    final future = cmd.run(21);
    expect(cmd.running, isTrue);
    final result = await future;
    expect(result, 42);
    expect(cmd.running, isFalse);
    expect(cmd.lastResult, 42);
    expect(cmd.error, isNull);
  });

  test('captures errors without rethrowing', () async {
    final cmd = Command<void, void>((_) async => throw StateError('boom'));
    await cmd.run(null);
    expect(cmd.running, isFalse);
    expect(cmd.error, isA<StateError>());
  });
}
```

- [ ] **Step 2: Run, expect FAIL**

Run: `flutter test test/unit/ui/core/command_test.dart`

- [ ] **Step 3: Implement**

```dart
// lib/ui/core/command.dart
import 'package:flutter/foundation.dart';

class Command<Arg, Result> extends ChangeNotifier {
  Command(this._action);
  final Future<Result> Function(Arg) _action;

  bool _running = false;
  Result? _lastResult;
  Object? _error;

  bool get running => _running;
  Result? get lastResult => _lastResult;
  Object? get error => _error;

  Future<Result?> run(Arg arg) async {
    if (_running) return null;
    _running = true;
    _error = null;
    notifyListeners();
    try {
      _lastResult = await _action(arg);
      return _lastResult;
    } catch (e) {
      _error = e;
      return null;
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}
```

- [ ] **Step 4: Run, expect PASS**

- [ ] **Step 5: Commit**

```
git add lib/ui/core/command.dart test/unit/ui/core/command_test.dart
git commit -m "feat(ui): Command helper for VM->View async state"
```

---

### Task 10: Root shell with bottom-nav placeholders

**Files:**
- Create: `lib/ui/core/widgets/root_shell.dart`
- Create: `lib/ui/habits/habits_list_screen.dart` (placeholder)
- Create: `lib/ui/stats/stats_screen.dart` (placeholder)
- Create: `lib/ui/friends/friends_screen.dart` (placeholder)
- Create: `lib/ui/profile/profile_screen.dart` (placeholder)

- [ ] **Step 1: Write placeholder screens**

Each is a `StatelessWidget` returning a `Scaffold` with an `AppBar(title: Text('<screen name>'))` and a `Center(child: Text('<screen name>'))`. Example:

```dart
// lib/ui/habits/habits_list_screen.dart
import 'package:flutter/material.dart';
class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Habits')));
}
```

Repeat the same template for `StatsScreen`, `FriendsScreen`, `ProfileScreen` under their respective directories.

- [ ] **Step 2: RootShell widget**

```dart
// lib/ui/core/widgets/root_shell.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';

class RootShell extends StatelessWidget {
  const RootShell({super.key, required this.child, required this.location});
  final Widget child;
  final String location;

  static const _tabs = <String>['/', '/stats', '/friends', '/profile'];

  int get _currentIndex {
    final idx = _tabs.indexWhere((p) => location == p || location.startsWith('$p/'));
    return idx == -1 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l.navHome),
          NavigationDestination(icon: const Icon(Icons.bar_chart_outlined), selectedIcon: const Icon(Icons.bar_chart), label: l.navStats),
          NavigationDestination(icon: const Icon(Icons.group_outlined), selectedIcon: const Icon(Icons.group), label: l.navFriends),
          NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: l.navProfile),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Verify analyze**

Run: `flutter analyze`
Expected: 0 issues.

- [ ] **Step 4: Commit**

```
git add lib/ui
git commit -m "feat(ui): root shell with bottom-nav and placeholder screens"
```

---

### Task 11: Router wiring

**Files:**
- Create: `lib/routing/app_router.dart`

- [ ] **Step 1: Define routes**

```dart
// lib/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/core/widgets/root_shell.dart';
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
      // /create and /habit/:id will be added in later milestones (outside shell).
    ],
  );
}
```

- [ ] **Step 2: Verify analyze**

Run: `flutter analyze`
Expected: 0 issues.

- [ ] **Step 3: Commit**

```
git add lib/routing
git commit -m "feat(routing): go_router with bottom-nav ShellRoute"
```

---

### Task 12: Wire app.dart and main.dart

**Files:**
- Replace: `lib/main.dart`
- Create: `lib/app.dart`

- [ ] **Step 1: app.dart with providers**

```dart
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'app_preferences.dart';
import 'l10n/app_localizations.dart';
import 'routing/app_router.dart';
import 'ui/core/themes/dark_theme.dart';
import 'ui/core/themes/light_theme.dart';

class HabitiousApp extends StatelessWidget {
  HabitiousApp({super.key});
  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppPreferences()),
      ],
      child: Consumer<AppPreferences>(
        builder: (context, prefs, _) {
          return MaterialApp.router(
            title: 'Habitious',
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: prefs.themeMode,
            locale: prefs.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: main.dart**

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HabitiousApp());
}
```

- [ ] **Step 3: Delete the default counter widget test**

The scaffold's `test/widget_test.dart` references `MyApp`. Replace it with a smoke test:
```dart
// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/app.dart';

void main() {
  testWidgets('app builds without throwing', (tester) async {
    await tester.pumpWidget(HabitiousApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
```

- [ ] **Step 4: Run tests**

Run: `flutter analyze && flutter test`
Expected: 0 issues, smoke test + earlier tests pass.

- [ ] **Step 5: Commit**

```
git add lib/main.dart lib/app.dart test/widget_test.dart
git commit -m "feat(app): wire MaterialApp.router with providers, themes, l10n"
```

---

### Task 13: Design-system widgets — PrimaryButton, SecondaryButton, DayChipsSelector

**Files:**
- Create: `lib/ui/core/widgets/primary_button.dart`
- Create: `lib/ui/core/widgets/secondary_button.dart`
- Create: `lib/ui/core/widgets/day_chips_selector.dart`
- Create: `test/widget/ui/core/day_chips_selector_test.dart`

- [ ] **Step 1: Buttons**

```dart
// lib/ui/core/widgets/primary_button.dart
import 'package:flutter/material.dart';
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }
}
```

```dart
// lib/ui/core/widgets/secondary_button.dart
import 'package:flutter/material.dart';
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }
}
```

- [ ] **Step 2: DayChipsSelector — write test first**

```dart
// test/widget/ui/core/day_chips_selector_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/l10n/app_localizations.dart';
import 'package:habitious/ui/core/widgets/day_chips_selector.dart';

Widget _wrap(Widget w) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: w),
    );

void main() {
  testWidgets('tapping a chip toggles its selection', (tester) async {
    var selected = <int>{0, 1, 2, 3, 4}; // Mon-Fri
    await tester.pumpWidget(_wrap(StatefulBuilder(builder: (context, setState) {
      return DayChipsSelector(
        selectedDays: selected,
        onChanged: (next) => setState(() => selected = next),
      );
    })));
    await tester.pumpAndSettle();

    expect(find.text('Sat'), findsOneWidget);
    await tester.tap(find.text('Sat'));
    await tester.pump();
    expect(selected.contains(5), isTrue);
  });
}
```

- [ ] **Step 3: Run, expect FAIL**

Run: `flutter test test/widget/ui/core/day_chips_selector_test.dart`

- [ ] **Step 4: Implement DayChipsSelector**

```dart
// lib/ui/core/widgets/day_chips_selector.dart
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

/// Indexes: 0=Mon ... 6=Sun.
class DayChipsSelector extends StatelessWidget {
  const DayChipsSelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  final Set<int> selectedDays;
  final ValueChanged<Set<int>> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final labels = [l.weekdayMon, l.weekdayTue, l.weekdayWed, l.weekdayThu, l.weekdayFri, l.weekdaySat, l.weekdaySun];
    return Wrap(
      spacing: 8,
      children: List.generate(7, (i) {
        final isSelected = selectedDays.contains(i);
        return ChoiceChip(
          label: Text(labels[i]),
          selected: isSelected,
          onSelected: (sel) {
            final next = {...selectedDays};
            if (sel) next.add(i); else next.remove(i);
            onChanged(next);
          },
        );
      }),
    );
  }
}
```

- [ ] **Step 5: Run, expect PASS**

- [ ] **Step 6: Commit**

```
git add lib/ui/core/widgets test/widget/ui/core
git commit -m "feat(ui): PrimaryButton, SecondaryButton, DayChipsSelector"
```

---

## Milestone 1 — Data layer foundations (models + Drift)

### Task 14: Enum models (HabitColor, HabitIcon, Weekday, HabitStatus, ThemePreference)

**Files:**
- Create: `lib/data/models/habit_color.dart`
- Create: `lib/data/models/habit_icon.dart`
- Create: `lib/data/models/weekday.dart`
- Create: `lib/data/models/habit_status.dart`
- Create: `lib/data/models/theme_preference.dart`

- [ ] **Step 1: Write enums**

```dart
// lib/data/models/habit_color.dart
import 'package:flutter/material.dart';
import '../../ui/core/themes/color_tokens.dart';

enum HabitColor {
  purple(HabitiousColors.brandPurple),
  teal(HabitiousColors.accentTeal),
  orange(HabitiousColors.accentOrange),
  pink(HabitiousColors.accentPink),
  blue(HabitiousColors.accentBlue),
  red(HabitiousColors.accentRed);

  const HabitColor(this.value);
  final Color value;
}
```

```dart
// lib/data/models/habit_icon.dart
import 'package:flutter/material.dart';
enum HabitIcon {
  drop(Icons.water_drop_outlined),
  dumbbell(Icons.fitness_center_outlined),
  book(Icons.menu_book_outlined),
  lotus(Icons.self_improvement_outlined),
  run(Icons.directions_run_outlined),
  apple(Icons.local_pizza_outlined);
  const HabitIcon(this.iconData);
  final IconData iconData;
}
```

```dart
// lib/data/models/weekday.dart
enum Weekday { mon, tue, wed, thu, fri, sat, sun;
  int get bit => 1 << index;
  static Set<Weekday> fromMask(int mask) =>
      Weekday.values.where((d) => (mask & d.bit) != 0).toSet();
  static int toMask(Set<Weekday> days) =>
      days.fold(0, (acc, d) => acc | d.bit);
}
```

```dart
// lib/data/models/habit_status.dart
enum HabitStatus { active, archived }
```

```dart
// lib/data/models/theme_preference.dart
import 'package:flutter/material.dart';
enum ThemePreference {
  system(ThemeMode.system),
  light(ThemeMode.light),
  dark(ThemeMode.dark);
  const ThemePreference(this.mode);
  final ThemeMode mode;
}
```

- [ ] **Step 2: Test the bitmask helpers**

Create `test/unit/data/models/weekday_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/weekday.dart';

void main() {
  test('toMask and fromMask round-trip', () {
    final days = {Weekday.mon, Weekday.wed, Weekday.fri};
    final mask = Weekday.toMask(days);
    expect(Weekday.fromMask(mask), days);
  });

  test('empty set maps to 0 and back', () {
    expect(Weekday.toMask(const {}), 0);
    expect(Weekday.fromMask(0), isEmpty);
  });
}
```

- [ ] **Step 3: Run tests + analyze**

Run: `flutter analyze && flutter test`
Expected: passes.

- [ ] **Step 4: Commit**

```
git add lib/data/models test/unit/data
git commit -m "feat(models): habit color/icon/weekday/status/theme enums"
```

---

### Task 15: Freezed domain models

**Files:**
- Create: `lib/data/models/typed_ids.dart`
- Create: `lib/data/models/reminder_time.dart`
- Create: `lib/data/models/habit.dart`
- Create: `lib/data/models/habit_completion.dart`
- Create: `lib/data/models/streak_info.dart`
- Create: `lib/data/models/weekly_progress.dart`
- Create: `lib/data/models/user_profile.dart`
- Create: `lib/data/models/friend.dart`
- Create: `lib/data/models/friend_request.dart`
- Create: `lib/data/models/group.dart`
- Create: `lib/data/models/leaderboard_entry.dart`
- Create: `lib/data/models/date_range.dart`

- [ ] **Step 1: Typed IDs**

```dart
// lib/data/models/typed_ids.dart
extension type const HabitId(String value) {}
extension type const GroupId(String value) {}
extension type const FriendId(String value) {}
```

- [ ] **Step 2: ReminderTime**

```dart
// lib/data/models/reminder_time.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reminder_time.freezed.dart';

@freezed
class ReminderTime with _$ReminderTime {
  const factory ReminderTime({
    required int hour,    // 0..23
    required int minute,  // 0..59
  }) = _ReminderTime;
}
```

- [ ] **Step 3: Habit + completion + streak + progress + profile + social models**

Use `freezed` for all of them; example template:
```dart
// lib/data/models/habit.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'habit_color.dart';
import 'habit_icon.dart';
import 'habit_status.dart';
import 'reminder_time.dart';
import 'typed_ids.dart';
import 'weekday.dart';

part 'habit.freezed.dart';

@freezed
class Habit with _$Habit {
  const factory Habit({
    required HabitId id,
    required String name,
    required HabitColor color,
    required HabitIcon icon,
    required Set<Weekday> schedule,
    required ReminderTime? reminder,
    required HabitStatus status,
    required DateTime createdAt,
    required GroupId? groupId,
  }) = _Habit;
}
```

```dart
// lib/data/models/habit_completion.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'typed_ids.dart';
part 'habit_completion.freezed.dart';
@freezed
class HabitCompletion with _$HabitCompletion {
  const factory HabitCompletion({
    required HabitId habitId,
    required DateTime date,
    required DateTime markedAt,
  }) = _HabitCompletion;
}
```

```dart
// lib/data/models/streak_info.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'streak_info.freezed.dart';
@freezed
class StreakInfo with _$StreakInfo {
  const factory StreakInfo({
    required int currentStreak,
    required int longestStreak,
    required int freezesRemainingThisWeek,
  }) = _StreakInfo;
}
```

```dart
// lib/data/models/weekly_progress.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'weekly_progress.freezed.dart';
@freezed
class WeeklyProgress with _$WeeklyProgress {
  const factory WeeklyProgress({
    required int completedDays,
    required int scheduledDays,
  }) = _WeeklyProgress;
}
```

```dart
// lib/data/models/user_profile.dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'theme_preference.dart';
part 'user_profile.freezed.dart';
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String displayName,
    required String? avatarPath,
    required int level,
    required int xp,
    required bool hardcoreMode,
    required ThemePreference themePreference,
    required Locale locale,
  }) = _UserProfile;
}
```

```dart
// lib/data/models/friend.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'typed_ids.dart';
part 'friend.freezed.dart';
@freezed
class Friend with _$Friend {
  const factory Friend({
    required FriendId id,
    required String displayName,
    required String? avatarPath,
    required int sharedHabitsCount,
  }) = _Friend;
}
```

```dart
// lib/data/models/friend_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'friend.dart';
part 'friend_request.freezed.dart';
@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required Friend friend,
    required DateTime sentAt,
    required bool incoming,
  }) = _FriendRequest;
}
```

```dart
// lib/data/models/group.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'typed_ids.dart';
part 'group.freezed.dart';

@freezed
class GroupMember with _$GroupMember {
  const factory GroupMember({
    required FriendId id,
    required String displayName,
    required String? avatarPath,
    required int currentStreak,
    required int completedThisWeek,
    required int scheduledThisWeek,
  }) = _GroupMember;
}

@freezed
class Group with _$Group {
  const factory Group({
    required GroupId id,
    required HabitId habitId,
    required List<GroupMember> members,
    required int completionPercentThisWeek,
  }) = _Group;
}
```

```dart
// lib/data/models/leaderboard_entry.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'typed_ids.dart';
part 'leaderboard_entry.freezed.dart';
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required int rank,
    required FriendId memberId,
    required String displayName,
    required String? avatarPath,
    required int currentStreak,
    required int completedThisWeek,
    required int scheduledThisWeek,
  }) = _LeaderboardEntry;
}
```

```dart
// lib/data/models/date_range.dart
class DateRange {
  const DateRange(this.startInclusive, this.endExclusive);
  final DateTime startInclusive;
  final DateTime endExclusive;
}
```

- [ ] **Step 4: Run codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: generates `*.freezed.dart` files.

- [ ] **Step 5: Verify**

Run: `flutter analyze && flutter test`
Expected: passes.

- [ ] **Step 6: Commit**

```
git add lib/data/models
git commit -m "feat(models): freezed domain models for habit/completion/profile/social"
```

---

### Task 16: Drift database

**Files:**
- Create: `lib/data/services/app_database.dart`
- Create: `test/unit/data/services/app_database_test.dart`

- [ ] **Step 1: Schema**

```dart
// lib/data/services/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Habits extends Table {
  TextColumn  get id => text()();
  TextColumn  get name => text().withLength(min: 1, max: 80)();
  IntColumn   get colorIndex => integer()();
  IntColumn   get iconIndex => integer()();
  IntColumn   get scheduleBitmask => integer()();
  IntColumn   get reminderMinutes => integer().nullable()();
  BoolColumn  get reminderEnabled => boolean().withDefault(const Constant(false))();
  IntColumn   get statusIndex => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn  get groupId => text().nullable()();
  @override Set<Column> get primaryKey => {id};
}

class HabitCompletions extends Table {
  TextColumn     get habitId =>
      text().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get markedAt => dateTime()();
  @override Set<Column> get primaryKey => {habitId, date};
}

class UserProfileTable extends Table {
  IntColumn   get id => integer().withDefault(const Constant(0))();
  TextColumn  get displayName => text()();
  TextColumn  get avatarPath => text().nullable()();
  IntColumn   get level => integer().withDefault(const Constant(1))();
  IntColumn   get xp => integer().withDefault(const Constant(0))();
  BoolColumn  get hardcoreMode => boolean().withDefault(const Constant(false))();
  IntColumn   get themePreferenceIndex => integer().withDefault(const Constant(0))();
  TextColumn  get localeTag => text().withDefault(const Constant('ru'))();
  @override Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Habits, HabitCompletions, UserProfileTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'habitious'));
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
```

- [ ] **Step 2: Generate Drift code**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: produces `app_database.g.dart`.

- [ ] **Step 3: Smoke test the database**

```dart
// test/unit/data/services/app_database_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/services/app_database.dart';

void main() {
  test('opens an in-memory database and reports 0 habits', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final habits = await db.select(db.habits).get();
    expect(habits, isEmpty);
  });
}
```

- [ ] **Step 4: Run + verify**

Run: `flutter test test/unit/data/services/app_database_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```
git add lib/data/services test/unit/data/services
git commit -m "feat(db): drift schema for habits, completions, profile"
```

---

### Task 17: ClockService

**Files:**
- Create: `lib/data/services/clock_service.dart`
- Create: `test/fakes/fake_clock_service.dart`

- [ ] **Step 1: Interface + system impl**

```dart
// lib/data/services/clock_service.dart
abstract interface class ClockService {
  DateTime now();
  /// Local midnight of today.
  DateTime today();
}

class SystemClockService implements ClockService {
  @override DateTime now() => DateTime.now();
  @override
  DateTime today() {
    final n = now();
    return DateTime(n.year, n.month, n.day);
  }
}
```

- [ ] **Step 2: FakeClockService**

```dart
// test/fakes/fake_clock_service.dart
import 'package:habitious/data/services/clock_service.dart';

class FakeClockService implements ClockService {
  FakeClockService(this._now);
  DateTime _now;
  void advance(Duration d) => _now = _now.add(d);
  void setTo(DateTime t) => _now = t;
  @override DateTime now() => _now;
  @override DateTime today() => DateTime(_now.year, _now.month, _now.day);
}
```

- [ ] **Step 3: Commit (no test yet — used as a test helper)**

Run: `flutter analyze`
Expected: 0 issues.
```
git add lib/data/services/clock_service.dart test/fakes/fake_clock_service.dart
git commit -m "feat(services): ClockService + FakeClockService"
```

---

## Milestone 2 — Habit CRUD + habits list + create screen

### Task 18: HabitRepository interface + Drift implementation

**Files:**
- Create: `lib/data/repositories/habit_repository.dart`
- Create: `lib/data/repositories/drift_habit_repository.dart`
- Create: `test/unit/data/repositories/drift_habit_repository_test.dart`

- [ ] **Step 1: Failing test**

```dart
// test/unit/data/repositories/drift_habit_repository_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/data/repositories/drift_habit_repository.dart';
import 'package:habitious/data/services/app_database.dart';

void main() {
  late AppDatabase db;
  late DriftHabitRepository repo;
  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = DriftHabitRepository(db);
  });
  tearDown(() => db.close());

  Habit makeHabit({String id = 'h1', String name = 'Drink water'}) => Habit(
        id: HabitId(id),
        name: name,
        color: HabitColor.purple,
        icon: HabitIcon.drop,
        schedule: Weekday.values.toSet(),
        reminder: null,
        status: HabitStatus.active,
        createdAt: DateTime(2026, 5, 1),
        groupId: null,
      );

  test('upsert then findHabit returns the same habit', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    final found = await repo.findHabit(h.id);
    expect(found, h);
  });

  test('watchHabits emits inserts and updates', () async {
    final stream = repo.watchHabits();
    final emissions = <int>[];
    final sub = stream.listen((list) => emissions.add(list.length));

    await repo.upsertHabit(makeHabit(id: 'a'));
    await repo.upsertHabit(makeHabit(id: 'b'));
    await Future<void>.delayed(Duration.zero);
    expect(emissions.last, 2);
    await sub.cancel();
  });

  test('archiveHabit flips status', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    await repo.archiveHabit(h.id);
    final found = await repo.findHabit(h.id);
    expect(found?.status, HabitStatus.archived);
  });

  test('deleteHabit removes the row', () async {
    final h = makeHabit();
    await repo.upsertHabit(h);
    await repo.deleteHabit(h.id);
    expect(await repo.findHabit(h.id), isNull);
  });
}
```

- [ ] **Step 2: Run, expect FAIL** (`DriftHabitRepository` not defined)

- [ ] **Step 3: Implement interface**

```dart
// lib/data/repositories/habit_repository.dart
import '../models/habit.dart';
import '../models/habit_status.dart';
import '../models/typed_ids.dart';

abstract interface class HabitRepository {
  Stream<List<Habit>> watchHabits({HabitStatus? status});
  Future<Habit?> findHabit(HabitId id);
  Future<void> upsertHabit(Habit habit);
  Future<void> archiveHabit(HabitId id);
  Future<void> deleteHabit(HabitId id);
}
```

- [ ] **Step 4: Implement Drift version with row<->model mapping**

```dart
// lib/data/repositories/drift_habit_repository.dart
import 'package:drift/drift.dart';
import '../models/habit.dart';
import '../models/habit_color.dart';
import '../models/habit_icon.dart';
import '../models/habit_status.dart';
import '../models/reminder_time.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';
import '../services/app_database.dart';
import 'habit_repository.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Habit>> watchHabits({HabitStatus? status}) {
    final query = _db.select(_db.habits);
    if (status != null) {
      query.where((tbl) => tbl.statusIndex.equals(status.index));
    }
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Future<Habit?> findHabit(HabitId id) async {
    final row = await (_db.select(_db.habits)..where((t) => t.id.equals(id.value))).getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<void> upsertHabit(Habit habit) async {
    await _db.into(_db.habits).insertOnConflictUpdate(_toCompanion(habit));
  }

  @override
  Future<void> archiveHabit(HabitId id) async {
    await (_db.update(_db.habits)..where((t) => t.id.equals(id.value)))
        .write(HabitsCompanion(statusIndex: Value(HabitStatus.archived.index)));
  }

  @override
  Future<void> deleteHabit(HabitId id) async {
    await (_db.delete(_db.habits)..where((t) => t.id.equals(id.value))).go();
  }

  Habit _fromRow(Habit_ row) => Habit(
        id: HabitId(row.id),
        name: row.name,
        color: HabitColor.values[row.colorIndex],
        icon: HabitIcon.values[row.iconIndex],
        schedule: Weekday.fromMask(row.scheduleBitmask),
        reminder: (row.reminderMinutes == null || !row.reminderEnabled)
            ? null
            : ReminderTime(hour: row.reminderMinutes! ~/ 60, minute: row.reminderMinutes! % 60),
        status: HabitStatus.values[row.statusIndex],
        createdAt: row.createdAt,
        groupId: row.groupId == null ? null : GroupId(row.groupId!),
      );

  HabitsCompanion _toCompanion(Habit h) => HabitsCompanion.insert(
        id: h.id.value,
        name: h.name,
        colorIndex: h.color.index,
        iconIndex: h.icon.index,
        scheduleBitmask: Weekday.toMask(h.schedule),
        reminderMinutes: h.reminder == null
            ? const Value.absent()
            : Value(h.reminder!.hour * 60 + h.reminder!.minute),
        reminderEnabled: Value(h.reminder != null),
        statusIndex: h.status.index,
        createdAt: h.createdAt,
        groupId: h.groupId == null ? const Value.absent() : Value(h.groupId!.value),
      );
}
```

> Note: `Habit_` is Drift's generated row class name (it suffixes `_` to avoid clashing with the domain type). If your generated name differs (e.g. `HabitRow`), adjust the import.

- [ ] **Step 5: Run, expect PASS**

Run: `flutter test test/unit/data/repositories/drift_habit_repository_test.dart`

- [ ] **Step 6: Commit**

```
git add lib/data/repositories test/unit/data/repositories
git commit -m "feat(data): HabitRepository + Drift implementation"
```

---

### Task 19: HabitsListViewModel (test-driven)

**Files:**
- Create: `lib/ui/habits/view_models/habits_list_view_model.dart`
- Create: `lib/ui/habits/view_models/habit_list_item.dart`
- Create: `test/fakes/in_memory_habit_repository.dart`
- Create: `test/unit/ui/habits/habits_list_view_model_test.dart`

- [ ] **Step 1: InMemoryHabitRepository fake**

```dart
// test/fakes/in_memory_habit_repository.dart
import 'dart:async';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/repositories/habit_repository.dart';

class InMemoryHabitRepository implements HabitRepository {
  final Map<HabitId, Habit> _byId = {};
  final StreamController<List<Habit>> _controller = StreamController.broadcast();

  @override
  Stream<List<Habit>> watchHabits({HabitStatus? status}) async* {
    yield _snapshot(status);
    yield* _controller.stream.map((_) => _snapshot(status));
  }

  List<Habit> _snapshot(HabitStatus? status) => _byId.values
      .where((h) => status == null || h.status == status)
      .toList(growable: false);

  @override Future<Habit?> findHabit(HabitId id) async => _byId[id];

  @override Future<void> upsertHabit(Habit habit) async {
    _byId[habit.id] = habit;
    _controller.add(_byId.values.toList());
  }

  @override Future<void> archiveHabit(HabitId id) async {
    final h = _byId[id];
    if (h == null) return;
    _byId[id] = h.copyWith(status: HabitStatus.archived);
    _controller.add(_byId.values.toList());
  }

  @override Future<void> deleteHabit(HabitId id) async {
    _byId.remove(id);
    _controller.add(_byId.values.toList());
  }
}
```

- [ ] **Step 2: HabitListItem view model + tabs enum**

```dart
// lib/ui/habits/view_models/habit_list_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/weekly_progress.dart';
part 'habit_list_item.freezed.dart';

@freezed
class HabitListItem with _$HabitListItem {
  const factory HabitListItem({
    required Habit habit,
    required WeeklyProgress progress,
    required int participantsCount, // stubbed: 1 (solo) or N from group
  }) = _HabitListItem;
}

enum HabitsTab { all, active, archive }
```

Run codegen: `dart run build_runner build --delete-conflicting-outputs`.

- [ ] **Step 3: Failing test**

```dart
// test/unit/ui/habits/habits_list_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/habit_list_item.dart';
import 'package:habitious/ui/habits/view_models/habits_list_view_model.dart';
import '../../../fakes/in_memory_habit_repository.dart';
// (CompletionRepository fake added in Milestone 3; for now use a stub.)
import '../../../fakes/in_memory_completion_repository_stub.dart';

Habit _mk(String id, HabitStatus status) => Habit(
      id: HabitId(id), name: id, color: HabitColor.purple, icon: HabitIcon.drop,
      schedule: Weekday.values.toSet(), reminder: null, status: status,
      createdAt: DateTime(2026, 5, 1), groupId: null,
    );

void main() {
  test('loads habits and exposes them filtered by tab', () async {
    final habits = InMemoryHabitRepository();
    await habits.upsertHabit(_mk('a', HabitStatus.active));
    await habits.upsertHabit(_mk('b', HabitStatus.archived));
    final vm = HabitsListViewModel(habits, InMemoryCompletionRepositoryStub());
    await vm.load();
    expect(vm.items.length, 2);
    vm.switchTab(HabitsTab.active);
    expect(vm.items.map((i) => i.habit.id.value), ['a']);
    vm.switchTab(HabitsTab.archive);
    expect(vm.items.map((i) => i.habit.id.value), ['b']);
  });
}
```

Also create a tiny stub so this test compiles before the real CompletionRepository exists in Milestone 3:

```dart
// test/fakes/in_memory_completion_repository_stub.dart
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekly_progress.dart';

class InMemoryCompletionRepositoryStub {
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    yield const WeeklyProgress(completedDays: 0, scheduledDays: 7);
  }
}
```

> When the real `CompletionRepository` lands in Task 23, replace this stub with the real fake.

- [ ] **Step 4: Run, expect FAIL**

- [ ] **Step 5: Implement ViewModel**

```dart
// lib/ui/habits/view_models/habits_list_view_model.dart
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
  // Typed as dynamic here to allow the stub during Milestone 2;
  // Task 23 replaces this signature with CompletionRepository.
  final dynamic _completions;

  HabitsTab _tab = HabitsTab.all;
  List<HabitListItem> _items = const [];
  bool _isLoading = true;
  Object? _error;
  StreamSubscription<List<Habit>>? _sub;

  HabitsTab get tab => _tab;
  List<HabitListItem> get items => _items.where(_match).toList(growable: false);
  bool get isLoading => _isLoading;
  Object? get error => _error;

  bool _match(HabitListItem item) {
    switch (_tab) {
      case HabitsTab.all: return true;
      case HabitsTab.active: return item.habit.status == HabitStatus.active;
      case HabitsTab.archive: return item.habit.status == HabitStatus.archived;
    }
  }

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _sub = _habits.watchHabits().listen((list) {
        _items = list
            .map((h) => HabitListItem(
                  habit: h,
                  progress: const WeeklyProgress(completedDays: 0, scheduledDays: 7),
                  participantsCount: 1,
                ))
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
```

- [ ] **Step 6: Run, expect PASS**

- [ ] **Step 7: Commit**

```
git add lib/ui/habits/view_models test/unit/ui/habits test/fakes
git commit -m "feat(habits): HabitsListViewModel + InMemoryHabitRepository fake"
```

---

### Task 20: HabitCard widget

**Files:**
- Create: `lib/ui/core/widgets/habit_card.dart`
- Create: `lib/ui/core/widgets/habit_icon_badge.dart`

- [ ] **Step 1: HabitIconBadge**

```dart
// lib/ui/core/widgets/habit_icon_badge.dart
import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/habit_icon.dart';

class HabitIconBadge extends StatelessWidget {
  const HabitIconBadge({super.key, required this.color, required this.icon, this.size = 48});
  final HabitColor color;
  final HabitIcon icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.value.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(icon.iconData, color: color.value, size: size * 0.55),
    );
  }
}
```

- [ ] **Step 2: HabitCard**

```dart
// lib/ui/core/widgets/habit_card.dart
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../habits/view_models/habit_list_item.dart';
import 'habit_icon_badge.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.item, this.onTap, this.onLongPress});
  final HabitListItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              HabitIconBadge(color: item.habit.color, icon: item.habit.icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.habit.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('${item.participantsCount} ${l.myFriends.toLowerCase()}', style: Theme.of(context).textTheme.bodyMedium),
                ]),
              ),
              Text(l.weekProgress(item.progress.completedDays, item.progress.scheduledDays),
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Verify analyze**

Run: `flutter analyze`

- [ ] **Step 4: Commit**

```
git add lib/ui/core/widgets/habit_card.dart lib/ui/core/widgets/habit_icon_badge.dart
git commit -m "feat(ui): HabitCard and HabitIconBadge"
```

---

### Task 21: Wire HabitsListScreen to the ViewModel

**Files:**
- Replace: `lib/ui/habits/habits_list_screen.dart`
- Modify: `lib/app.dart` (add `HabitRepository` to provider tree)

- [ ] **Step 1: Add provider to app.dart**

In `HabitiousApp.build`, replace the `MultiProvider.providers` list:
```dart
providers: [
  ChangeNotifierProvider(create: (_) => AppPreferences()),
  Provider<AppDatabase>(create: (_) => AppDatabase(), dispose: (_, db) => db.close()),
  ProxyProvider<AppDatabase, HabitRepository>(
    update: (_, db, __) => DriftHabitRepository(db),
  ),
],
```
Add imports for `AppDatabase`, `HabitRepository`, `DriftHabitRepository`.

- [ ] **Step 2: HabitsListScreen with VM**

```dart
// lib/ui/habits/habits_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (_) => HabitsListViewModel(repo, _StubCompletions())..load(),
      child: const _Body(),
    );
  }
}

class _StubCompletions {} // replaced in Milestone 3 with real CompletionRepository

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
          IconButton(icon: const Icon(Icons.add), onPressed: () => context.push('/create')),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<HabitsTab>(
              segments: [
                ButtonSegment(value: HabitsTab.all, label: Text(l.tabAll)),
                ButtonSegment(value: HabitsTab.active, label: Text(l.tabActive)),
                ButtonSegment(value: HabitsTab.archive, label: Text(l.tabArchive)),
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
                onTap: () => context.push('/habit/${vm.items[i].habit.id.value}'),
              ),
            ),
    );
  }
}
```

- [ ] **Step 3: Verify**

Run: `flutter analyze && flutter test`
Expected: passes.

- [ ] **Step 4: Commit**

```
git add lib/ui/habits/habits_list_screen.dart lib/app.dart
git commit -m "feat(habits): wire HabitsListScreen to ViewModel + repository"
```

---

### Task 22: CreateHabitScreen + ViewModel

**Files:**
- Create: `lib/ui/habits/view_models/create_habit_view_model.dart`
- Create: `lib/ui/habits/create_habit_screen.dart`
- Modify: `lib/routing/app_router.dart` (add `/create` outside the shell)
- Create: `test/unit/ui/habits/create_habit_view_model_test.dart`

- [ ] **Step 1: Failing VM test**

```dart
// test/unit/ui/habits/create_habit_view_model_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/reminder_time.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/create_habit_view_model.dart';
import '../../../fakes/in_memory_habit_repository.dart';

void main() {
  test('canSubmit requires non-empty name and at least one weekday', () {
    final vm = CreateHabitViewModel(InMemoryHabitRepository());
    expect(vm.canSubmit, isFalse);
    vm.setName('Drink water');
    expect(vm.canSubmit, isTrue);
    vm.setSchedule(<Weekday>{});
    expect(vm.canSubmit, isFalse);
  });

  test('submit persists a habit with the chosen fields', () async {
    final habits = InMemoryHabitRepository();
    final vm = CreateHabitViewModel(habits);
    vm.setName('Drink water');
    vm.setColor(HabitColor.teal);
    vm.setIcon(HabitIcon.drop);
    vm.setReminder(const ReminderTime(hour: 9, minute: 0));
    final id = await vm.submitCommand.run(null);
    expect(id, isNotNull);
    final saved = await habits.findHabit(id!);
    expect(saved!.name, 'Drink water');
    expect(saved.color, HabitColor.teal);
    expect(saved.reminder, const ReminderTime(hour: 9, minute: 0));
  });
}
```

- [ ] **Step 2: Run, expect FAIL**

- [ ] **Step 3: Implement VM**

```dart
// lib/ui/habits/view_models/create_habit_view_model.dart
import 'package:flutter/foundation.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/habit_icon.dart';
import '../../../data/models/habit_status.dart';
import '../../../data/models/reminder_time.dart';
import '../../../data/models/typed_ids.dart';
import '../../../data/models/weekday.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../core/command.dart';

class CreateHabitViewModel extends ChangeNotifier {
  CreateHabitViewModel(this._habits) {
    submitCommand = Command<void, HabitId?>((_) async {
      if (!canSubmit) return null;
      final id = HabitId('h_${DateTime.now().microsecondsSinceEpoch}');
      final habit = Habit(
        id: id,
        name: _name.trim(),
        color: _color,
        icon: _icon,
        schedule: _schedule,
        reminder: _reminder,
        status: HabitStatus.active,
        createdAt: DateTime.now(),
        groupId: null,
      );
      await _habits.upsertHabit(habit);
      return id;
    });
  }

  final HabitRepository _habits;

  String _name = '';
  Set<Weekday> _schedule = Weekday.values.toSet();
  ReminderTime? _reminder;
  HabitColor _color = HabitColor.purple;
  HabitIcon _icon = HabitIcon.drop;

  String get name => _name;
  Set<Weekday> get schedule => _schedule;
  ReminderTime? get reminder => _reminder;
  HabitColor get color => _color;
  HabitIcon get icon => _icon;

  bool get canSubmit => _name.trim().isNotEmpty && _schedule.isNotEmpty;

  late final Command<void, HabitId?> submitCommand;

  void setName(String value) { _name = value; notifyListeners(); }
  void setSchedule(Set<Weekday> value) { _schedule = value; notifyListeners(); }
  void setReminder(ReminderTime? value) { _reminder = value; notifyListeners(); }
  void setColor(HabitColor value) { _color = value; notifyListeners(); }
  void setIcon(HabitIcon value) { _icon = value; notifyListeners(); }
}
```

- [ ] **Step 4: Run, expect PASS**

- [ ] **Step 5: Implement screen**

```dart
// lib/ui/habits/create_habit_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/models/habit_color.dart';
import '../../data/models/habit_icon.dart';
import '../../data/models/reminder_time.dart';
import '../../data/models/weekday.dart';
import '../../data/repositories/habit_repository.dart';
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
      create: (_) => CreateHabitViewModel(context.read<HabitRepository>()),
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
          Text(l.habitNameLabel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(onChanged: vm.setName, decoration: const InputDecoration(border: OutlineInputBorder())),
          const SizedBox(height: 16),
          Text(l.frequencyLabel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DayChipsSelector(
            selectedDays: vm.schedule.map((d) => d.index).toSet(),
            onChanged: (set) => vm.setSchedule(set.map((i) => Weekday.values[i]).toSet()),
          ),
          const SizedBox(height: 16),
          Text(l.remindersLabel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SwitchListTile(
            value: vm.reminder != null,
            onChanged: (on) => vm.setReminder(on ? const ReminderTime(hour: 9, minute: 0) : null),
            title: Text(vm.reminder == null
                ? l.remindersLabel
                : l.reminderEveryDayAt('${vm.reminder!.hour.toString().padLeft(2, '0')}:${vm.reminder!.minute.toString().padLeft(2, '0')}')),
          ),
          const SizedBox(height: 16),
          Text(l.cardColorLabel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: HabitColor.values.map((c) => GestureDetector(
              onTap: () => vm.setColor(c),
              child: CircleAvatar(radius: 18, backgroundColor: c.value, child: vm.color == c ? const Icon(Icons.check, color: Colors.white, size: 18) : null),
            )).toList(),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: HabitIcon.values.map((ic) => GestureDetector(
              onTap: () => vm.setIcon(ic),
              child: Opacity(opacity: vm.icon == ic ? 1.0 : 0.4, child: HabitIconBadge(color: vm.color, icon: ic)),
            )).toList(),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: l.createHabit,
            onPressed: vm.canSubmit ? () async {
              final id = await vm.submitCommand.run(null);
              if (id != null && context.mounted) context.pop();
            } : null,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 6: Register route**

In `lib/routing/app_router.dart`, after the `ShellRoute`, add:
```dart
GoRoute(path: '/create', builder: (_, __) => const CreateHabitScreen()),
```
Add the import at the top.

- [ ] **Step 7: Run + manual smoke**

Run: `flutter analyze && flutter test`
Then on an emulator: `flutter run`. Verify you can navigate from the `+` button on the list screen, fill out the form, tap "Create habit", and see the new habit appear in the list.

- [ ] **Step 8: Commit**

```
git add lib/ui/habits/create_habit_screen.dart lib/ui/habits/view_models/create_habit_view_model.dart lib/routing/app_router.dart test/unit/ui/habits/create_habit_view_model_test.dart
git commit -m "feat(habits): create-habit screen + ViewModel"
```

---

## Milestone 3 — Completions, heatmap, streaks, habit detail

### Task 23: CompletionRepository interface + Drift impl + InMemory fake

**Files:**
- Create: `lib/data/repositories/completion_repository.dart`
- Create: `lib/data/repositories/drift_completion_repository.dart`
- Create: `test/fakes/in_memory_completion_repository.dart`
- Delete: `test/fakes/in_memory_completion_repository_stub.dart`
- Create: `test/unit/data/repositories/drift_completion_repository_test.dart`

- [ ] **Step 1: Interface**

```dart
// lib/data/repositories/completion_repository.dart
import '../models/date_range.dart';
import '../models/streak_info.dart';
import '../models/typed_ids.dart';
import '../models/weekly_progress.dart';

abstract interface class CompletionRepository {
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range);
  Future<bool> isCompleted(HabitId id, DateTime date);
  Future<void> markCompleted(HabitId id, DateTime date);
  Future<void> unmarkCompleted(HabitId id, DateTime date);
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore});
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id);
}
```

- [ ] **Step 2: Drift impl with streak algorithm**

```dart
// lib/data/repositories/drift_completion_repository.dart
import 'package:drift/drift.dart';
import '../models/date_range.dart';
import '../models/habit.dart';
import '../models/habit_color.dart';
import '../models/habit_icon.dart';
import '../models/habit_status.dart';
import '../models/streak_info.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';
import '../models/weekly_progress.dart';
import '../services/app_database.dart';
import '../services/clock_service.dart';
import 'completion_repository.dart';

class DriftCompletionRepository implements CompletionRepository {
  DriftCompletionRepository(this._db, this._clock);
  final AppDatabase _db;
  final ClockService _clock;

  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range) {
    final q = _db.select(_db.habitCompletions)
      ..where((t) => t.habitId.equals(id.value)
          & t.date.isBiggerOrEqualValue(range.startInclusive)
          & t.date.isSmallerThanValue(range.endExclusive));
    return q.watch().map((rows) => rows.map((r) => _normalize(r.date)).toSet());
  }

  @override
  Future<bool> isCompleted(HabitId id, DateTime date) async {
    final r = await (_db.select(_db.habitCompletions)
          ..where((t) => t.habitId.equals(id.value) & t.date.equals(_normalize(date))))
        .getSingleOrNull();
    return r != null;
  }

  @override
  Future<void> markCompleted(HabitId id, DateTime date) async {
    await _db.into(_db.habitCompletions).insertOnConflictUpdate(
      HabitCompletionsCompanion.insert(
        habitId: id.value,
        date: _normalize(date),
        markedAt: _clock.now(),
      ),
    );
  }

  @override
  Future<void> unmarkCompleted(HabitId id, DateTime date) async {
    await (_db.delete(_db.habitCompletions)
          ..where((t) => t.habitId.equals(id.value) & t.date.equals(_normalize(date))))
        .go();
  }

  @override
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore}) async {
    final habit = await _fetchHabit(id);
    if (habit == null) return const StreakInfo(currentStreak: 0, longestStreak: 0, freezesRemainingThisWeek: 0);
    final completions = await _allDates(id);
    return _computeStreakPure(
      schedule: habit.schedule,
      completions: completions,
      today: _clock.today(),
      hardcore: hardcore,
    );
  }

  @override
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    // Emit current week progress when completions change.
    final start = _startOfWeek(_clock.today());
    final end = start.add(const Duration(days: 7));
    await for (final dates in watchCompletionDates(id, DateRange(start, end))) {
      final habit = await _fetchHabit(id);
      if (habit == null) { yield const WeeklyProgress(completedDays: 0, scheduledDays: 0); continue; }
      final scheduled = habit.schedule.length;
      final completed = dates.length;
      yield WeeklyProgress(completedDays: completed, scheduledDays: scheduled);
    }
  }

  Future<Habit?> _fetchHabit(HabitId id) async {
    final row = await (_db.select(_db.habits)..where((t) => t.id.equals(id.value))).getSingleOrNull();
    if (row == null) return null;
    return Habit(
      id: HabitId(row.id),
      name: row.name,
      color: HabitColor.values[row.colorIndex],
      icon: HabitIcon.values[row.iconIndex],
      schedule: Weekday.fromMask(row.scheduleBitmask),
      reminder: null,
      status: HabitStatus.values[row.statusIndex],
      createdAt: row.createdAt,
      groupId: null,
    );
  }

  Future<Set<DateTime>> _allDates(HabitId id) async {
    final rows = await (_db.select(_db.habitCompletions)..where((t) => t.habitId.equals(id.value))).get();
    return rows.map((r) => _normalize(r.date)).toSet();
  }

  DateTime _startOfWeek(DateTime day) {
    // Monday as week start (weekday 1).
    final delta = (day.weekday - DateTime.monday) % 7;
    return day.subtract(Duration(days: delta));
  }
}

/// Pure function — exposed for direct unit testing.
StreakInfo _computeStreakPure({
  required Set<Weekday> schedule,
  required Set<DateTime> completions,
  required DateTime today,
  required bool hardcore,
}) {
  int currentStreak = 0;
  int longestStreak = 0;
  int runningLongest = 0;
  int freezesRemainingThisWeek = hardcore ? 0 : 1;
  bool streakStillRunning = true;

  // Walk back through scheduled days only.
  // Stop after ~365 days to bound the work.
  var cursor = today.subtract(const Duration(days: 1)); // yesterday and earlier
  DateTime? lastWeekStart;
  for (int i = 0; i < 365 && streakStillRunning; i++) {
    final dayOfWeek = Weekday.values[(cursor.weekday - 1) % 7];
    if (schedule.contains(dayOfWeek)) {
      final completed = completions.any((d) =>
          d.year == cursor.year && d.month == cursor.month && d.day == cursor.day);
      if (completed) {
        currentStreak++;
        runningLongest = currentStreak;
        if (runningLongest > longestStreak) longestStreak = runningLongest;
      } else {
        if (hardcore) {
          streakStillRunning = false;
        } else if (freezesRemainingThisWeek > 0) {
          freezesRemainingThisWeek--;
        } else {
          streakStillRunning = false;
        }
      }
      // Reset freezes when crossing into a new week (walking backwards).
      final weekStart = cursor.subtract(Duration(days: (cursor.weekday - DateTime.monday) % 7));
      lastWeekStart ??= weekStart;
      if (weekStart != lastWeekStart) {
        freezesRemainingThisWeek = hardcore ? 0 : 1;
        lastWeekStart = weekStart;
      }
    }
    cursor = cursor.subtract(const Duration(days: 1));
  }

  return StreakInfo(
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    freezesRemainingThisWeek: hardcore ? 0 : 1, // current week's remaining
  );
}
```

> Two known refinements to lock in via tests next: (a) the pure helper exposes `freezesRemainingThisWeek` for the *current* week, not the historical walk; (b) the walking week boundary is for the *past* week we're computing against.

- [ ] **Step 3: InMemory fake**

```dart
// test/fakes/in_memory_completion_repository.dart
import 'dart:async';
import 'package:habitious/data/models/date_range.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/streak_info.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/data/models/weekly_progress.dart';
import 'package:habitious/data/repositories/completion_repository.dart';

class InMemoryCompletionRepository implements CompletionRepository {
  InMemoryCompletionRepository({required this.todayProvider, required this.habitLookup});
  final DateTime Function() todayProvider;
  final Future<Habit?> Function(HabitId id) habitLookup;
  final Map<HabitId, Set<DateTime>> _dates = {};
  final StreamController<HabitId> _events = StreamController.broadcast();

  DateTime _norm(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Stream<Set<DateTime>> watchCompletionDates(HabitId id, DateRange range) async* {
    yield _filter(id, range);
    yield* _events.stream.where((x) => x == id).map((_) => _filter(id, range));
  }

  Set<DateTime> _filter(HabitId id, DateRange range) =>
      (_dates[id] ?? const {})
          .where((d) => !d.isBefore(range.startInclusive) && d.isBefore(range.endExclusive))
          .toSet();

  @override Future<bool> isCompleted(HabitId id, DateTime date) async =>
      (_dates[id] ?? const {}).contains(_norm(date));

  @override Future<void> markCompleted(HabitId id, DateTime date) async {
    (_dates[id] ??= {}).add(_norm(date));
    _events.add(id);
  }

  @override Future<void> unmarkCompleted(HabitId id, DateTime date) async {
    _dates[id]?.remove(_norm(date));
    _events.add(id);
  }

  @override
  Future<StreakInfo> computeStreak(HabitId id, {required bool hardcore}) async {
    final habit = await habitLookup(id);
    if (habit == null) return const StreakInfo(currentStreak: 0, longestStreak: 0, freezesRemainingThisWeek: 0);
    // Mirror the algorithm from drift_completion_repository.dart.
    final today = todayProvider();
    int current = 0; int longest = 0; int freezes = hardcore ? 0 : 1;
    var cursor = today.subtract(const Duration(days: 1));
    var running = true;
    for (int i = 0; i < 365 && running; i++) {
      final dow = Weekday.values[(cursor.weekday - 1) % 7];
      if (habit.schedule.contains(dow)) {
        final completed = (_dates[id] ?? const {}).contains(_norm(cursor));
        if (completed) { current++; if (current > longest) longest = current; }
        else if (hardcore || freezes == 0) { running = false; }
        else { freezes--; }
      }
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return StreakInfo(currentStreak: current, longestStreak: longest, freezesRemainingThisWeek: hardcore ? 0 : 1);
  }

  @override
  Stream<WeeklyProgress> watchWeeklyProgress(HabitId id) async* {
    Future<WeeklyProgress> compute() async {
      final habit = await habitLookup(id);
      if (habit == null) return const WeeklyProgress(completedDays: 0, scheduledDays: 0);
      final today = todayProvider();
      final start = today.subtract(Duration(days: (today.weekday - DateTime.monday) % 7));
      final end = start.add(const Duration(days: 7));
      final done = (_dates[id] ?? const {}).where((d) => !d.isBefore(start) && d.isBefore(end)).length;
      return WeeklyProgress(completedDays: done, scheduledDays: habit.schedule.length);
    }
    yield await compute();
    yield* _events.stream.where((x) => x == id).asyncMap((_) => compute());
  }
}
```

- [ ] **Step 4: Drift repo test**

```dart
// test/unit/data/repositories/drift_completion_repository_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/data/repositories/drift_completion_repository.dart';
import 'package:habitious/data/repositories/drift_habit_repository.dart';
import 'package:habitious/data/services/app_database.dart';
import '../../../fakes/fake_clock_service.dart';

void main() {
  late AppDatabase db;
  late DriftHabitRepository habits;
  late DriftCompletionRepository comps;
  late FakeClockService clock;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = FakeClockService(DateTime(2026, 5, 27));
    habits = DriftHabitRepository(db);
    comps = DriftCompletionRepository(db, clock);
    await habits.upsertHabit(Habit(
      id: const HabitId('h1'), name: 'Drink',
      color: HabitColor.purple, icon: HabitIcon.drop,
      schedule: Weekday.values.toSet(), reminder: null,
      status: HabitStatus.active, createdAt: DateTime(2026, 5, 1), groupId: null,
    ));
  });
  tearDown(() => db.close());

  test('mark and unmark round-trip', () async {
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    expect(await comps.isCompleted(const HabitId('h1'), DateTime(2026, 5, 26)), isTrue);
    await comps.unmarkCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    expect(await comps.isCompleted(const HabitId('h1'), DateTime(2026, 5, 26)), isFalse);
  });

  test('hardcore mode resets streak on first miss', () async {
    // Two consecutive completed days before today, then a missed day before those.
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 25));
    // (2026-05-24 not marked → streak ends there.)
    final s = await comps.computeStreak(const HabitId('h1'), hardcore: true);
    expect(s.currentStreak, 2);
  });

  test('normal mode allows one freeze per week', () async {
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 26));
    // 2026-05-25 missed → consumes the freeze
    await comps.markCompleted(const HabitId('h1'), DateTime(2026, 5, 24));
    final s = await comps.computeStreak(const HabitId('h1'), hardcore: false);
    expect(s.currentStreak, 2);
  });
}
```

- [ ] **Step 5: Run, expect PASS**

Run: `flutter test test/unit/data/repositories/drift_completion_repository_test.dart`

- [ ] **Step 6: Add CompletionRepository to the provider tree**

In `lib/app.dart`'s `MultiProvider.providers`, add:
```dart
Provider<ClockService>(create: (_) => SystemClockService()),
ProxyProvider2<AppDatabase, ClockService, CompletionRepository>(
  update: (_, db, clock, __) => DriftCompletionRepository(db, clock),
),
```
Add imports for `ClockService`, `SystemClockService`, `CompletionRepository`, `DriftCompletionRepository`.

- [ ] **Step 7: Replace the stub used by HabitsListViewModel**

Edit `lib/ui/habits/view_models/habits_list_view_model.dart`: change the field type from `dynamic` to `CompletionRepository` and import it. Then subscribe to `watchWeeklyProgress` per item. Replace the `load()` body:
```dart
Future<void> load() async {
  _isLoading = true;
  _error = null;
  notifyListeners();
  _sub = _habits.watchHabits().listen((list) async {
    final futures = list.map((h) async {
      final progress = await _completions.watchWeeklyProgress(h.id).first;
      return HabitListItem(habit: h, progress: progress, participantsCount: 1);
    });
    _items = await Future.wait(futures);
    _isLoading = false;
    notifyListeners();
  });
}
```

In `lib/ui/habits/habits_list_screen.dart`, replace the `_StubCompletions()` argument with `context.read<CompletionRepository>()` and delete the unused `_StubCompletions` class.

Delete `test/fakes/in_memory_completion_repository_stub.dart`. Update `test/unit/ui/habits/habits_list_view_model_test.dart` to import `InMemoryCompletionRepository` and pass it to the VM:
```dart
final clock = FakeClockService(DateTime(2026, 5, 27));
final comps = InMemoryCompletionRepository(
  todayProvider: () => clock.today(),
  habitLookup: habits.findHabit,
);
final vm = HabitsListViewModel(habits, comps);
```

- [ ] **Step 8: Verify**

Run: `flutter analyze && flutter test`

- [ ] **Step 9: Commit**

```
git add -A
git commit -m "feat(data): CompletionRepository + streak algorithm + week progress"
```

---

### Task 24: Heatmap widget

**Files:**
- Create: `lib/ui/habits/widgets/habit_heatmap.dart`
- Create: `test/widget/ui/habits/habit_heatmap_test.dart`

- [ ] **Step 1: Failing widget test**

```dart
// test/widget/ui/habits/habit_heatmap_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/widgets/habit_heatmap.dart';

void main() {
  testWidgets('renders cells for each day of the month and reports taps', (tester) async {
    DateTime? tapped;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: HabitHeatmap(
      month: DateTime(2026, 5),
      completedDates: {DateTime(2026, 5, 1), DateTime(2026, 5, 2)},
      scheduledDays: Weekday.values.toSet(),
      color: HabitColor.purple,
      onTapDay: (d) => tapped = d,
    ))));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    await tester.tap(find.text('15'));
    expect(tapped, DateTime(2026, 5, 15));
  });
}
```

- [ ] **Step 2: Run, expect FAIL**

- [ ] **Step 3: Implement**

```dart
// lib/ui/habits/widgets/habit_heatmap.dart
import 'package:flutter/material.dart';
import '../../../data/models/habit_color.dart';
import '../../../data/models/weekday.dart';

class HabitHeatmap extends StatelessWidget {
  const HabitHeatmap({
    super.key,
    required this.month,
    required this.completedDates,
    required this.scheduledDays,
    required this.color,
    required this.onTapDay,
  });

  final DateTime month; // any day inside the visible month
  final Set<DateTime> completedDates;
  final Set<Weekday> scheduledDays;
  final HabitColor color;
  final ValueChanged<DateTime> onTapDay;

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = (firstOfMonth.weekday - DateTime.monday) % 7;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4),
      itemCount: leadingBlanks + daysInMonth,
      itemBuilder: (_, i) {
        if (i < leadingBlanks) return const SizedBox.shrink();
        final dayNumber = i - leadingBlanks + 1;
        final day = DateTime(month.year, month.month, dayNumber);
        final dow = Weekday.values[(day.weekday - 1) % 7];
        final isScheduled = scheduledDays.contains(dow);
        final isCompleted = completedDates.any((d) => d.year == day.year && d.month == day.month && d.day == day.day);
        final bg = !isScheduled
            ? Theme.of(context).colorScheme.surfaceVariant
            : isCompleted ? color.value : color.value.withOpacity(0.18);
        return InkWell(
          onTap: () => onTapDay(day),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
            alignment: Alignment.center,
            child: Text('$dayNumber', style: TextStyle(color: isCompleted ? Colors.white : null, fontSize: 12)),
          ),
        );
      },
    );
  }
}
```

- [ ] **Step 4: Run, expect PASS**

- [ ] **Step 5: Commit**

```
git add lib/ui/habits/widgets/habit_heatmap.dart test/widget/ui/habits/habit_heatmap_test.dart
git commit -m "feat(habits): monthly heatmap widget"
```

---

### Task 25: HabitDetailViewModel + screen

**Files:**
- Create: `lib/ui/habits/view_models/habit_detail_view_model.dart`
- Create: `lib/ui/habits/habit_detail_screen.dart`
- Modify: `lib/routing/app_router.dart` (add `/habit/:id`)
- Create: `test/unit/ui/habits/habit_detail_view_model_test.dart`

- [ ] **Step 1: Failing VM test** (load habit, toggle a day, change month)

```dart
// test/unit/ui/habits/habit_detail_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/habit_color.dart';
import 'package:habitious/data/models/habit_icon.dart';
import 'package:habitious/data/models/habit_status.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/models/weekday.dart';
import 'package:habitious/ui/habits/view_models/habit_detail_view_model.dart';
import '../../../fakes/fake_clock_service.dart';
import '../../../fakes/in_memory_completion_repository.dart';
import '../../../fakes/in_memory_habit_repository.dart';

void main() {
  test('toggles day and refreshes month completions', () async {
    final habits = InMemoryHabitRepository();
    final habitId = const HabitId('h1');
    await habits.upsertHabit(Habit(
      id: habitId, name: 'Drink', color: HabitColor.purple, icon: HabitIcon.drop,
      schedule: Weekday.values.toSet(), reminder: null,
      status: HabitStatus.active, createdAt: DateTime(2026, 5, 1), groupId: null,
    ));
    final clock = FakeClockService(DateTime(2026, 5, 27));
    final comps = InMemoryCompletionRepository(
      todayProvider: () => clock.today(),
      habitLookup: habits.findHabit,
    );

    final vm = HabitDetailViewModel(habits, comps, clock, hardcoreProvider: () => false, habitId: habitId);
    await vm.load();
    await vm.toggleDayCommand.run(DateTime(2026, 5, 26));
    expect(vm.monthCompletions.contains(DateTime(2026, 5, 26)), isTrue);
    await vm.toggleDayCommand.run(DateTime(2026, 5, 26));
    expect(vm.monthCompletions.contains(DateTime(2026, 5, 26)), isFalse);
  });
}
```

- [ ] **Step 2: Run, expect FAIL**

- [ ] **Step 3: Implement VM**

```dart
// lib/ui/habits/view_models/habit_detail_view_model.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/date_range.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/streak_info.dart';
import '../../../data/models/typed_ids.dart';
import '../../../data/repositories/completion_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/services/clock_service.dart';
import '../../core/command.dart';

class HabitDetailViewModel extends ChangeNotifier {
  HabitDetailViewModel(
    this._habits,
    this._completions,
    this._clock, {
    required this.habitId,
    required this.hardcoreProvider,
  }) {
    toggleDayCommand = Command<DateTime, void>(_toggleDay);
    changeMonthCommand = Command<DateTime, void>(_changeMonth);
  }

  final HabitRepository _habits;
  final CompletionRepository _completions;
  final ClockService _clock;
  final HabitId habitId;
  final bool Function() hardcoreProvider;

  Habit? habit;
  StreakInfo? streak;
  Set<DateTime> monthCompletions = const {};
  DateTime visibleMonth = DateTime(2000);
  StreamSubscription<Set<DateTime>>? _monthSub;

  late final Command<DateTime, void> toggleDayCommand;
  late final Command<DateTime, void> changeMonthCommand;

  Future<void> load() async {
    habit = await _habits.findHabit(habitId);
    visibleMonth = DateTime(_clock.today().year, _clock.today().month);
    await _resubscribeMonth();
    await _refreshStreak();
  }

  Future<void> _resubscribeMonth() async {
    final start = DateTime(visibleMonth.year, visibleMonth.month);
    final end = DateTime(visibleMonth.year, visibleMonth.month + 1);
    await _monthSub?.cancel();
    _monthSub = _completions.watchCompletionDates(habitId, DateRange(start, end)).listen((set) {
      monthCompletions = set;
      notifyListeners();
    });
  }

  Future<void> _refreshStreak() async {
    streak = await _completions.computeStreak(habitId, hardcore: hardcoreProvider());
    notifyListeners();
  }

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

  @override
  void dispose() {
    _monthSub?.cancel();
    super.dispose();
  }
}
```

- [ ] **Step 4: Implement screen** — title, streak chip, heatmap, month nav, "remind lazy" button (no-op for now, wired in Milestone 6).

```dart
// lib/ui/habits/habit_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/typed_ids.dart';
import '../../data/repositories/completion_repository.dart';
import '../../data/repositories/habit_repository.dart';
import '../../data/services/clock_service.dart';
import '../../l10n/app_localizations.dart';
import '../core/widgets/habit_icon_badge.dart';
import '../core/widgets/secondary_button.dart';
import 'view_models/habit_detail_view_model.dart';
import 'widgets/habit_heatmap.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});
  final String habitId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HabitDetailViewModel(
        ctx.read<HabitRepository>(),
        ctx.read<CompletionRepository>(),
        ctx.read<ClockService>(),
        habitId: HabitId(habitId),
        hardcoreProvider: () => false, // wired to ProfileRepository in Milestone 5
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
    if (habit == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(habit.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            HabitIconBadge(color: habit.color, icon: habit.icon, size: 64),
            const SizedBox(width: 16),
            if (vm.streak != null) Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('🔥', style: Theme.of(context).textTheme.headlineMedium),
              Text(l.streakDays(vm.streak!.currentStreak), style: Theme.of(context).textTheme.bodyLarge),
            ]),
          ]),
          const SizedBox(height: 24),
          HabitHeatmap(
            month: vm.visibleMonth,
            completedDates: vm.monthCompletions,
            scheduledDays: habit.schedule,
            color: habit.color,
            onTapDay: (d) => vm.toggleDayCommand.run(d),
          ),
          const SizedBox(height: 16),
          Row(children: [
            IconButton(
              onPressed: () => vm.changeMonthCommand.run(DateTime(vm.visibleMonth.year, vm.visibleMonth.month - 1)),
              icon: const Icon(Icons.chevron_left),
            ),
            const Spacer(),
            Text('${vm.visibleMonth.year}-${vm.visibleMonth.month.toString().padLeft(2, '0')}'),
            const Spacer(),
            IconButton(
              onPressed: () => vm.changeMonthCommand.run(DateTime(vm.visibleMonth.year, vm.visibleMonth.month + 1)),
              icon: const Icon(Icons.chevron_right),
            ),
          ]),
          const SizedBox(height: 24),
          // Leaderboard slot — populated in Milestone 6 with stubbed social.
          SecondaryButton(label: l.remindLazyOnes, onPressed: null),
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: Add the route**

In `lib/routing/app_router.dart`:
```dart
GoRoute(path: '/habit/:id', builder: (_, state) => HabitDetailScreen(habitId: state.pathParameters['id']!)),
```

- [ ] **Step 6: Run + manual smoke**

Run: `flutter analyze && flutter test`, then `flutter run`. Verify: tap a habit, see the heatmap, tap a day to toggle, swipe months.

- [ ] **Step 7: Commit**

```
git add lib/ui/habits/view_models/habit_detail_view_model.dart lib/ui/habits/habit_detail_screen.dart lib/routing/app_router.dart test/unit/ui/habits/habit_detail_view_model_test.dart
git commit -m "feat(habits): habit detail screen with heatmap + streak"
```

---

## Milestone 4 — Local push reminders

### Task 26: NotificationService

**Files:**
- Create: `lib/data/services/notification_service.dart`
- Create: `test/fakes/fake_notification_service.dart`
- Create: `test/unit/data/services/notification_service_test.dart` (against the fake)

- [ ] **Step 1: Interface**

```dart
// lib/data/services/notification_service.dart
import '../models/habit.dart';
import '../models/typed_ids.dart';

abstract interface class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> scheduleHabitReminders(Habit habit);
  Future<void> cancelHabitReminders(HabitId id);
}
```

- [ ] **Step 2: Fake implementation**

```dart
// test/fakes/fake_notification_service.dart
import 'package:habitious/data/models/habit.dart';
import 'package:habitious/data/models/typed_ids.dart';
import 'package:habitious/data/services/notification_service.dart';

class FakeNotificationService implements NotificationService {
  int initCalls = 0; int permCalls = 0;
  final List<Habit> scheduled = [];
  final List<HabitId> cancelled = [];
  bool permissionResponse = true;
  @override Future<void> initialize() async => initCalls++;
  @override Future<bool> requestPermission() async { permCalls++; return permissionResponse; }
  @override Future<void> scheduleHabitReminders(Habit h) async => scheduled.add(h);
  @override Future<void> cancelHabitReminders(HabitId id) async => cancelled.add(id);
}
```

- [ ] **Step 3: Real impl**

```dart
// lib/data/services/notification_service.dart (extend the same file)
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../models/habit.dart';
import '../models/typed_ids.dart';
import '../models/weekday.dart';

class FlutterLocalNotificationsServiceImpl implements NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(initSettings);
  }

  @override
  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final a = await android?.requestNotificationsPermission() ?? true;
    final i = await ios?.requestPermissions(alert: true, badge: true, sound: true) ?? true;
    return a && i;
  }

  static int _stableId(HabitId id, Weekday day) =>
      (id.value.hashCode ^ day.index) & 0x7fffffff;

  @override
  Future<void> scheduleHabitReminders(Habit habit) async {
    await cancelHabitReminders(habit.id);
    if (habit.reminder == null) return;
    final r = habit.reminder!;
    for (final day in habit.schedule) {
      final next = _nextInstance(day, r.hour, r.minute);
      await _plugin.zonedSchedule(
        _stableId(habit.id, day),
        habit.name,
        '⏰',
        next,
        const NotificationDetails(
          android: AndroidNotificationDetails('habits', 'Habit reminders', importance: Importance.high),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  @override
  Future<void> cancelHabitReminders(HabitId id) async {
    for (final day in Weekday.values) {
      await _plugin.cancel(_stableId(id, day));
    }
  }

  tz.TZDateTime _nextInstance(Weekday day, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    final targetWeekday = day.index + 1; // Mon=1...Sun=7
    while (scheduled.weekday != targetWeekday || !scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
```

- [ ] **Step 4: Wire into providers + initialize on app start**

In `lib/main.dart`:
```dart
import 'package:habitious/data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notif = FlutterLocalNotificationsServiceImpl();
  await notif.initialize();
  runApp(HabitiousApp(notifications: notif));
}
```

In `app.dart`, add a constructor parameter `final NotificationService notifications;` and register it:
```dart
Provider<NotificationService>.value(value: notifications),
```

- [ ] **Step 5: Hook into CreateHabitViewModel**

Edit `CreateHabitViewModel` to accept a `NotificationService` and, in `submitCommand`, call `await _notifications.scheduleHabitReminders(habit)` after `_habits.upsertHabit(habit)`.

Pass it through `CreateHabitScreen.build`:
```dart
CreateHabitViewModel(context.read<HabitRepository>(), context.read<NotificationService>())
```

Update the existing VM test (Task 22) to inject `FakeNotificationService` and assert that `scheduled.length == 1`.

- [ ] **Step 6: Request permission on first launch**

In `HabitiousApp.build`, wrap with a `FutureBuilder` (or use `addPostFrameCallback`) that calls `context.read<NotificationService>().requestPermission()` once.

- [ ] **Step 7: Android Manifest + iOS Info.plist**

Modify `android/app/src/main/AndroidManifest.xml` and add inside `<manifest>`:
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```

And inside `<application>`:
```xml
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"/>
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
  <intent-filter>
    <action android:name="android.intent.action.BOOT_COMPLETED"/>
    <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
  </intent-filter>
</receiver>
```

For iOS, modify `ios/Runner/AppDelegate.swift`: add `UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate` per the `flutter_local_notifications` README.

- [ ] **Step 8: Manual smoke + commit**

`flutter analyze && flutter test`. Then run on an Android emulator: create a habit with a reminder one minute in the future and verify a notification fires.

```
git add -A
git commit -m "feat(reminders): local notifications scheduled per habit"
```

---

## Milestone 5 — Profile, preferences, hardcore mode

### Task 27: ProfileRepository

**Files:**
- Create: `lib/data/repositories/profile_repository.dart`
- Create: `lib/data/repositories/drift_profile_repository.dart`
- Create: `test/fakes/in_memory_profile_repository.dart`
- Create: `test/unit/data/repositories/drift_profile_repository_test.dart`

- [ ] **Step 1: Interface**

```dart
// lib/data/repositories/profile_repository.dart
import '../models/user_profile.dart';
abstract interface class ProfileRepository {
  Stream<UserProfile> watchProfile();
  Future<void> updateProfile(UserProfile profile);
}
```

- [ ] **Step 2: Drift impl**

```dart
// lib/data/repositories/drift_profile_repository.dart
import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import '../models/theme_preference.dart';
import '../models/user_profile.dart';
import '../services/app_database.dart';
import 'profile_repository.dart';

class DriftProfileRepository implements ProfileRepository {
  DriftProfileRepository(this._db) {
    _ensureRow();
  }
  final AppDatabase _db;
  final _subject = BehaviorSubject<UserProfile>();

  Future<void> _ensureRow() async {
    final existing = await _db.select(_db.userProfileTable).getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.userProfileTable).insert(UserProfileTableCompanion.insert(
        displayName: 'Алексей',
      ));
    }
    _db.select(_db.userProfileTable).watch().listen((rows) {
      if (rows.isEmpty) return;
      final r = rows.first;
      _subject.add(UserProfile(
        displayName: r.displayName,
        avatarPath: r.avatarPath,
        level: r.level,
        xp: r.xp,
        hardcoreMode: r.hardcoreMode,
        themePreference: ThemePreference.values[r.themePreferenceIndex],
        locale: Locale(r.localeTag),
      ));
    });
  }

  @override Stream<UserProfile> watchProfile() => _subject.stream;

  @override Future<void> updateProfile(UserProfile p) async {
    await _db.update(_db.userProfileTable).write(UserProfileTableCompanion(
      displayName: Value(p.displayName),
      avatarPath: Value(p.avatarPath),
      level: Value(p.level),
      xp: Value(p.xp),
      hardcoreMode: Value(p.hardcoreMode),
      themePreferenceIndex: Value(p.themePreference.index),
      localeTag: Value(p.locale.languageCode),
    ));
  }
}
```

- [ ] **Step 3: InMemory fake**

```dart
// test/fakes/in_memory_profile_repository.dart
import 'package:rxdart/rxdart.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/data/repositories/profile_repository.dart';

class InMemoryProfileRepository implements ProfileRepository {
  InMemoryProfileRepository(UserProfile seed) { _subject.add(seed); }
  final _subject = BehaviorSubject<UserProfile>();
  @override Stream<UserProfile> watchProfile() => _subject.stream;
  @override Future<void> updateProfile(UserProfile p) async => _subject.add(p);
}
```

- [ ] **Step 4: Drift profile test**

```dart
// test/unit/data/repositories/drift_profile_repository_test.dart
import 'dart:ui';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/theme_preference.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/data/repositories/drift_profile_repository.dart';
import 'package:habitious/data/services/app_database.dart';

void main() {
  test('updateProfile emits new value', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = DriftProfileRepository(db);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await repo.updateProfile(const UserProfile(
      displayName: 'Test', avatarPath: null, level: 1, xp: 0, hardcoreMode: true,
      themePreference: ThemePreference.dark, locale: Locale('en'),
    ));
    final p = await repo.watchProfile().first;
    expect(p.hardcoreMode, isTrue);
    expect(p.themePreference, ThemePreference.dark);
  });
}
```

- [ ] **Step 5: Run + commit**

```
flutter analyze && flutter test
git add -A
git commit -m "feat(data): ProfileRepository (drift + fake)"
```

---

### Task 28: ProfileScreen + ProfileViewModel

**Files:**
- Create: `lib/ui/profile/view_models/profile_view_model.dart`
- Replace: `lib/ui/profile/profile_screen.dart`
- Modify: `lib/app.dart` (sync ProfileRepository -> AppPreferences)
- Create: `test/unit/ui/profile/profile_view_model_test.dart`

- [ ] **Step 1: ViewModel test**

```dart
// test/unit/ui/profile/profile_view_model_test.dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/models/theme_preference.dart';
import 'package:habitious/data/models/user_profile.dart';
import 'package:habitious/ui/profile/view_models/profile_view_model.dart';
import '../../../fakes/in_memory_profile_repository.dart';

void main() {
  test('toggleHardcoreMode persists to repository', () async {
    final repo = InMemoryProfileRepository(const UserProfile(
      displayName: 'A', avatarPath: null, level: 1, xp: 0,
      hardcoreMode: false, themePreference: ThemePreference.system, locale: Locale('ru'),
    ));
    final vm = ProfileViewModel(repo);
    await vm.load();
    await vm.toggleHardcoreModeCommand.run(true);
    final updated = await repo.watchProfile().first;
    expect(updated.hardcoreMode, isTrue);
  });
}
```

- [ ] **Step 2: Implement VM**

```dart
// lib/ui/profile/view_models/profile_view_model.dart
import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../../../data/models/theme_preference.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../core/command.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._repo) {
    toggleHardcoreModeCommand = Command<bool, void>((v) async =>
        _save((p) => p.copyWith(hardcoreMode: v)));
    setThemePreferenceCommand = Command<ThemePreference, void>((v) async =>
        _save((p) => p.copyWith(themePreference: v)));
    setLocaleCommand = Command<Locale, void>((v) async =>
        _save((p) => p.copyWith(locale: v)));
  }

  final ProfileRepository _repo;
  UserProfile? profile;
  StreamSubscription<UserProfile>? _sub;

  late final Command<bool, void> toggleHardcoreModeCommand;
  late final Command<ThemePreference, void> setThemePreferenceCommand;
  late final Command<Locale, void> setLocaleCommand;

  Future<void> load() async {
    _sub = _repo.watchProfile().listen((p) {
      profile = p;
      notifyListeners();
    });
  }

  Future<void> _save(UserProfile Function(UserProfile) tx) async {
    final cur = profile;
    if (cur == null) return;
    await _repo.updateProfile(tx(cur));
  }

  @override void dispose() { _sub?.cancel(); super.dispose(); }
}
```

- [ ] **Step 3: Implement screen**

```dart
// lib/ui/profile/profile_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_preferences.dart';
import '../../data/models/theme_preference.dart';
import '../../data/repositories/profile_repository.dart';
import '../../l10n/app_localizations.dart';
import 'view_models/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProfileViewModel(ctx.read<ProfileRepository>())..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vm = context.watch<ProfileViewModel>();
    final prefs = context.read<AppPreferences>();
    final p = vm.profile;
    if (p == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(l.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            CircleAvatar(radius: 32, child: Text(p.displayName.characters.first)),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.displayName, style: Theme.of(context).textTheme.titleMedium),
              Text(l.level(p.level)),
            ]),
          ]),
          const Divider(height: 32),
          SwitchListTile(
            title: Text(l.hardcoreMode),
            value: p.hardcoreMode,
            onChanged: (v) => vm.toggleHardcoreModeCommand.run(v),
          ),
          ListTile(
            title: Text(l.themeSystem + ' / ' + l.themeLight + ' / ' + l.themeDark),
            trailing: DropdownButton<ThemePreference>(
              value: p.themePreference,
              items: [
                DropdownMenuItem(value: ThemePreference.system, child: Text(l.themeSystem)),
                DropdownMenuItem(value: ThemePreference.light, child: Text(l.themeLight)),
                DropdownMenuItem(value: ThemePreference.dark, child: Text(l.themeDark)),
              ],
              onChanged: (v) async {
                if (v == null) return;
                await vm.setThemePreferenceCommand.run(v);
                prefs.setTheme(v.mode);
              },
            ),
          ),
          ListTile(
            title: Text(l.languageRu + ' / ' + l.languageEn),
            trailing: DropdownButton<Locale>(
              value: p.locale,
              items: const [
                DropdownMenuItem(value: Locale('ru'), child: Text('RU')),
                DropdownMenuItem(value: Locale('en'), child: Text('EN')),
              ],
              onChanged: (v) async {
                if (v == null) return;
                await vm.setLocaleCommand.run(v);
                prefs.setLocale(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Add HardcoreFlag and a profile sync hook**

Create `lib/profile_sync.dart`:
```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'app_preferences.dart';
import 'data/repositories/profile_repository.dart';

/// Latest-value cache of the user's hardcore-mode toggle, for synchronous reads.
class HardcoreFlag extends ChangeNotifier {
  bool _value = false;
  bool get value => _value;
  void update(bool v) {
    if (_value == v) return;
    _value = v;
    notifyListeners();
  }
}

/// Subscribes to ProfileRepository and pushes preferences into AppPreferences
/// and HardcoreFlag. Returns a Future that resolves after the first emission so
/// startup can await it.
class ProfileSync {
  ProfileSync(this._repo, this._prefs, this._flag);
  final ProfileRepository _repo;
  final AppPreferences _prefs;
  final HardcoreFlag _flag;
  StreamSubscription<Object?>? _sub;

  Future<void> start() async {
    final stream = _repo.watchProfile();
    final completer = Completer<void>();
    _sub = stream.listen((p) {
      _prefs.setTheme(p.themePreference.mode);
      _prefs.setLocale(p.locale);
      _flag.update(p.hardcoreMode);
      if (!completer.isCompleted) completer.complete();
    });
    return completer.future;
  }

  Future<void> dispose() async => _sub?.cancel();
}
```

Register both in `app.dart`'s `MultiProvider`:
```dart
ChangeNotifierProvider(create: (_) => HardcoreFlag()),
```

In `lib/main.dart`, after building the database and notification service, build the repositories, run `await ProfileSync(profileRepo, prefs, flag).start();` before `runApp`. This means `main` now constructs the database, profile repo, app preferences, and hardcore flag explicitly and passes them into `HabitiousApp` via constructor params (replace the in-`build` Providers with `Provider.value` for these).

Concrete `main.dart`:
```dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'app_preferences.dart';
import 'data/repositories/drift_profile_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/services/app_database.dart';
import 'data/services/notification_service.dart';
import 'profile_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final profileRepo = DriftProfileRepository(db);
  final prefs = AppPreferences();
  final flag = HardcoreFlag();
  final notif = FlutterLocalNotificationsServiceImpl();
  await notif.initialize();
  await ProfileSync(profileRepo, prefs, flag).start();
  runApp(HabitiousApp(
    database: db,
    profileRepository: profileRepo,
    preferences: prefs,
    hardcoreFlag: flag,
    notifications: notif,
  ));
}
```

Update `HabitiousApp` to accept these and expose via `Provider.value` (theme/locale read from `prefs`).

- [ ] **Step 5: Wire hardcore mode to HabitDetailViewModel**

In `HabitDetailScreen.build`, replace the placeholder `hardcoreProvider: () => false` with:
```dart
hardcoreProvider: () => ctx.read<HardcoreFlag>().value,
```
Add the import for `HardcoreFlag`.

- [ ] **Step 6: Verify**

`flutter analyze && flutter test`. Manual: toggle theme on profile screen, confirm app updates immediately; toggle hardcore mode, confirm streak recalculates next time the detail screen is opened.

- [ ] **Step 7: Commit**

```
git add -A
git commit -m "feat(profile): profile screen, preferences, hardcore mode wired"
```

---

## Milestone 6 — Stubbed social

### Task 29: FakeSocialRepository

**Files:**
- Create: `lib/data/repositories/social_repository.dart`
- Create: `lib/data/repositories/fake_social_repository.dart`
- Create: `test/unit/data/repositories/fake_social_repository_test.dart`

- [ ] **Step 1: Interface**

```dart
// lib/data/repositories/social_repository.dart
import '../models/friend.dart';
import '../models/friend_request.dart';
import '../models/group.dart';
import '../models/leaderboard_entry.dart';
import '../models/typed_ids.dart';

abstract interface class SocialRepository {
  Stream<List<Friend>> watchFriends();
  Stream<List<FriendRequest>> watchIncomingRequests();
  Future<List<Friend>> searchByUsername(String query);
  Stream<Group?> watchGroupForHabit(HabitId habitId);
  Stream<List<LeaderboardEntry>> watchLeaderboard(GroupId groupId);
  Future<void> nudgeLazyMembers(GroupId groupId);
}
```

- [ ] **Step 2: Seeded fake**

```dart
// lib/data/repositories/fake_social_repository.dart
import 'package:rxdart/rxdart.dart';
import '../models/friend.dart';
import '../models/friend_request.dart';
import '../models/group.dart';
import '../models/leaderboard_entry.dart';
import '../models/typed_ids.dart';
import 'social_repository.dart';

class FakeSocialRepository implements SocialRepository {
  factory FakeSocialRepository.seeded() {
    final repo = FakeSocialRepository._();
    repo._friends.add(const [
      Friend(id: FriendId('f1'), displayName: 'Амир', avatarPath: null, sharedHabitsCount: 2),
      Friend(id: FriendId('f2'), displayName: 'Nurseltan', avatarPath: null, sharedHabitsCount: 1),
      Friend(id: FriendId('f3'), displayName: 'Дина', avatarPath: null, sharedHabitsCount: 4),
      Friend(id: FriendId('f4'), displayName: 'Мария', avatarPath: null, sharedHabitsCount: 1),
    ]);
    final now = DateTime(2026, 5, 25);
    repo._requests.add([
      FriendRequest(
        friend: const Friend(id: FriendId('r1'), displayName: 'Мария', avatarPath: null, sharedHabitsCount: 0),
        sentAt: now, incoming: true,
      ),
      FriendRequest(
        friend: const Friend(id: FriendId('r2'), displayName: 'Илья', avatarPath: null, sharedHabitsCount: 0),
        sentAt: now, incoming: true,
      ),
    ]);
    return repo;
  }

  FakeSocialRepository._();
  final _friends = BehaviorSubject<List<Friend>>.seeded(const []);
  final _requests = BehaviorSubject<List<FriendRequest>>.seeded(const []);

  @override Stream<List<Friend>> watchFriends() => _friends.stream;
  @override Stream<List<FriendRequest>> watchIncomingRequests() => _requests.stream;
  @override Future<List<Friend>> searchByUsername(String query) async =>
      _friends.value.where((f) => f.displayName.toLowerCase().contains(query.toLowerCase())).toList();

  @override
  Stream<Group?> watchGroupForHabit(HabitId habitId) => Stream.value(Group(
    id: GroupId('g_${habitId.value}'),
    habitId: habitId,
    completionPercentThisWeek: 78,
    members: [
      const GroupMember(id: FriendId('me'), displayName: 'Вы', avatarPath: null, currentStreak: 14, completedThisWeek: 6, scheduledThisWeek: 7),
      const GroupMember(id: FriendId('f1'), displayName: 'Амир', avatarPath: null, currentStreak: 5, completedThisWeek: 6, scheduledThisWeek: 7),
      const GroupMember(id: FriendId('f2'), displayName: 'Nurseltan', avatarPath: null, currentStreak: 3, completedThisWeek: 2, scheduledThisWeek: 7),
      const GroupMember(id: FriendId('f3'), displayName: 'Дина', avatarPath: null, currentStreak: 1, completedThisWeek: 1, scheduledThisWeek: 7),
    ],
  ));

  @override
  Stream<List<LeaderboardEntry>> watchLeaderboard(GroupId groupId) => Stream.value(const [
    LeaderboardEntry(rank: 1, memberId: FriendId('me'), displayName: 'Вы', avatarPath: null, currentStreak: 14, completedThisWeek: 6, scheduledThisWeek: 7),
    LeaderboardEntry(rank: 2, memberId: FriendId('f1'), displayName: 'Амир', avatarPath: null, currentStreak: 5, completedThisWeek: 6, scheduledThisWeek: 7),
    LeaderboardEntry(rank: 3, memberId: FriendId('f2'), displayName: 'Nurseltan', avatarPath: null, currentStreak: 3, completedThisWeek: 2, scheduledThisWeek: 7),
    LeaderboardEntry(rank: 4, memberId: FriendId('f3'), displayName: 'Дина', avatarPath: null, currentStreak: 1, completedThisWeek: 1, scheduledThisWeek: 7),
  ]);

  @override
  Future<void> nudgeLazyMembers(GroupId groupId) async {
    // No-op stub.
  }
}
```

- [ ] **Step 3: Test the fake**

```dart
// test/unit/data/repositories/fake_social_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/data/repositories/fake_social_repository.dart';

void main() {
  test('seeded fake exposes 4 friends and 2 requests', () async {
    final repo = FakeSocialRepository.seeded();
    final friends = await repo.watchFriends().first;
    final reqs = await repo.watchIncomingRequests().first;
    expect(friends.length, 4);
    expect(reqs.length, 2);
  });

  test('searchByUsername filters case-insensitively', () async {
    final repo = FakeSocialRepository.seeded();
    expect((await repo.searchByUsername('ам')).map((f) => f.displayName), contains('Амир'));
  });
}
```

- [ ] **Step 4: Provider registration**

In `lib/app.dart`:
```dart
Provider<SocialRepository>(create: (_) => FakeSocialRepository.seeded()),
```

- [ ] **Step 5: Run + commit**

```
flutter analyze && flutter test
git add -A
git commit -m "feat(social): FakeSocialRepository with seeded data"
```

---

### Task 30: Friends screen + profile friends section

**Files:**
- Replace: `lib/ui/friends/friends_screen.dart`
- Modify: `lib/ui/profile/profile_screen.dart` (add a friends section)

- [ ] **Step 1: Friends screen**

```dart
// lib/ui/friends/friends_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/friend.dart';
import '../../data/repositories/social_repository.dart';
import '../../l10n/app_localizations.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = context.read<SocialRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l.navFriends)),
      body: StreamBuilder<List<Friend>>(
        stream: repo.watchFriends(),
        builder: (_, snapshot) {
          final list = snapshot.data ?? const [];
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (_, i) => ListTile(
              leading: CircleAvatar(child: Text(list[i].displayName.characters.first)),
              title: Text(list[i].displayName),
              subtitle: Text(l.sharedHabitsCount(list[i].sharedHabitsCount)),
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Extend SocialRepository with accept/decline (stubbed)**

In `lib/data/repositories/social_repository.dart`, add to the interface:
```dart
Future<void> acceptFriendRequest(FriendId id);
Future<void> declineFriendRequest(FriendId id);
```

In `FakeSocialRepository`:
```dart
@override
Future<void> acceptFriendRequest(FriendId id) async {
  _requests.add(_requests.value.where((r) => r.friend.id != id).toList());
}

@override
Future<void> declineFriendRequest(FriendId id) async {
  _requests.add(_requests.value.where((r) => r.friend.id != id).toList());
}
```

- [ ] **Step 3: Friends section on profile**

In `profile_screen.dart`, after the existing preference tiles in the `ListView`, append:
```dart
const Divider(height: 32),
StreamBuilder<List<FriendRequest>>(
  stream: context.read<SocialRepository>().watchIncomingRequests(),
  builder: (_, snapshot) {
    final reqs = snapshot.data ?? const [];
    if (reqs.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l.friendRequests(reqs.length), style: Theme.of(context).textTheme.titleMedium),
      ...reqs.map((r) => ListTile(
        leading: CircleAvatar(child: Text(r.friend.displayName.characters.first)),
        title: Text(r.friend.displayName),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => context.read<SocialRepository>().acceptFriendRequest(r.friend.id),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.read<SocialRepository>().declineFriendRequest(r.friend.id),
          ),
        ]),
      )),
    ]);
  },
),
const SizedBox(height: 16),
StreamBuilder<List<Friend>>(
  stream: context.read<SocialRepository>().watchFriends(),
  builder: (_, snapshot) {
    final friends = snapshot.data ?? const [];
    if (friends.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l.myFriends, style: Theme.of(context).textTheme.titleMedium),
      ...friends.take(3).map((f) => ListTile(
        leading: CircleAvatar(child: Text(f.displayName.characters.first)),
        title: Text(f.displayName),
        subtitle: Text(l.sharedHabitsCount(f.sharedHabitsCount)),
      )),
    ]);
  },
),
```
Add imports for `FriendRequest`, `Friend`, `SocialRepository`.

- [ ] **Step 3: Verify + commit**

```
flutter analyze && flutter test
git add -A
git commit -m "feat(friends): friends screen + profile friends section"
```

---

### Task 31: Leaderboard widget + habit detail wiring

**Files:**
- Create: `lib/ui/habits/widgets/leaderboard_list.dart`
- Create: `lib/ui/habits/widgets/group_completion_header.dart`
- Modify: `lib/ui/habits/habit_detail_screen.dart` (use the widgets)
- Modify: `lib/ui/habits/view_models/habit_detail_view_model.dart` (add group + leaderboard streams)

- [ ] **Step 1: LeaderboardList**

```dart
// lib/ui/habits/widgets/leaderboard_list.dart
import 'package:flutter/material.dart';
import '../../../data/models/leaderboard_entry.dart';
class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries});
  final List<LeaderboardEntry> entries;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries.map((e) => ListTile(
        leading: CircleAvatar(child: Text('${e.rank}')),
        title: Text(e.displayName),
        subtitle: Text('${e.completedThisWeek}/${e.scheduledThisWeek}'),
        trailing: Text('🔥 ${e.currentStreak}'),
      )).toList(),
    );
  }
}
```

- [ ] **Step 2: GroupCompletionHeader**

```dart
// lib/ui/habits/widgets/group_completion_header.dart
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
class GroupCompletionHeader extends StatelessWidget {
  const GroupCompletionHeader({super.key, required this.percent, required this.streak});
  final int percent; final int streak;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(children: [
      Text(l.groupCompletion(percent), style: Theme.of(context).textTheme.titleMedium),
      const Spacer(),
      Text('🔥 $streak'),
    ]);
  }
}
```

- [ ] **Step 3: Update HabitDetailViewModel**

Edit `lib/ui/habits/view_models/habit_detail_view_model.dart`:

Add an import:
```dart
import '../../../data/models/group.dart';
import '../../../data/models/leaderboard_entry.dart';
import '../../../data/repositories/social_repository.dart';
```

Add a `SocialRepository _social` constructor field. Update the constructor:
```dart
HabitDetailViewModel(
  this._habits,
  this._completions,
  this._social,
  this._clock, {
  required this.habitId,
  required this.hardcoreProvider,
}) {
  toggleDayCommand = Command<DateTime, void>(_toggleDay);
  changeMonthCommand = Command<DateTime, void>(_changeMonth);
  nudgeLazyCommand = Command<void, void>(_nudgeLazy);
}
```

Add fields:
```dart
final SocialRepository _social;
Group? group;
List<LeaderboardEntry> leaderboard = const [];
StreamSubscription<Group?>? _groupSub;
StreamSubscription<List<LeaderboardEntry>>? _lbSub;
late final Command<void, void> nudgeLazyCommand;
```

Inside `load()` after the existing `_resubscribeMonth()`:
```dart
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
```

Add the command body:
```dart
Future<void> _nudgeLazy(void _) async {
  final g = group;
  if (g == null) return;
  await _social.nudgeLazyMembers(g.id);
}
```

Update `dispose()`:
```dart
@override
void dispose() {
  _monthSub?.cancel();
  _groupSub?.cancel();
  _lbSub?.cancel();
  super.dispose();
}
```

- [ ] **Step 4: Update HabitDetailScreen body**

In `lib/ui/habits/habit_detail_screen.dart`:

Pass the `SocialRepository` into the VM:
```dart
create: (ctx) => HabitDetailViewModel(
  ctx.read<HabitRepository>(),
  ctx.read<CompletionRepository>(),
  ctx.read<SocialRepository>(),
  ctx.read<ClockService>(),
  habitId: HabitId(habitId),
  hardcoreProvider: () => ctx.read<HardcoreFlag>().value,
)..load(),
```

Imports: `SocialRepository`, `HardcoreFlag`, `GroupCompletionHeader`, `LeaderboardList`.

In `_Body.build`, insert between the streak header and the heatmap:
```dart
if (vm.group != null) ...[
  const SizedBox(height: 12),
  GroupCompletionHeader(
    percent: vm.group!.completionPercentThisWeek,
    streak: vm.streak?.currentStreak ?? 0,
  ),
],
```

Replace the existing leaderboard slot (the `Напомнить ленивым` button) with:
```dart
if (vm.leaderboard.isNotEmpty) ...[
  Text('Лидерборд', style: Theme.of(context).textTheme.titleMedium),
  LeaderboardList(entries: vm.leaderboard),
  const SizedBox(height: 12),
],
SecondaryButton(
  label: l.remindLazyOnes,
  onPressed: vm.group == null ? null : () => vm.nudgeLazyCommand.run(null),
),
```

- [ ] **Step 5: Verify + commit**

```
flutter analyze && flutter test
git add -A
git commit -m "feat(social): leaderboard + group header on habit detail"
```

---

### Task 32: Profile "Add friends" UI (stubbed)

**Files:**
- Modify: `lib/ui/profile/profile_screen.dart`

- [ ] **Step 1: Add an "add friends" section**

Convert the `_Body` of `profile_screen.dart` to a `StatefulWidget` so it can hold a `TextEditingController` and the latest search results.

Add this block above the friend-requests section:
```dart
Text(l.addFriends, style: Theme.of(context).textTheme.titleMedium),
const SizedBox(height: 8),
TextField(
  controller: _searchController,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.search),
    hintText: l.searchByUsername,
    border: const OutlineInputBorder(),
  ),
  onChanged: (q) async {
    final results = await context.read<SocialRepository>().searchByUsername(q);
    if (mounted) setState(() => _searchResults = results);
  },
),
if (_searchResults.isNotEmpty)
  ..._searchResults.map((f) => ListTile(
    leading: CircleAvatar(child: Text(f.displayName.characters.first)),
    title: Text(f.displayName),
  )),
const SizedBox(height: 8),
ListTile(
  leading: const Icon(Icons.qr_code),
  title: Text(l.myQrCode),
  onTap: () => showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      content: SizedBox(width: 200, height: 200, child: Center(
        child: Icon(Icons.qr_code_2, size: 160, color: Theme.of(context).colorScheme.primary),
      )),
    ),
  ),
),
ListTile(
  leading: const Icon(Icons.qr_code_scanner),
  title: Text(l.scanQr),
  onTap: () => showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(content: Text(l.scanQr)),
  ),
),
const Divider(height: 32),
```

Add to the `_BodyState` class:
```dart
final TextEditingController _searchController = TextEditingController();
List<Friend> _searchResults = const [];

@override
void dispose() {
  _searchController.dispose();
  super.dispose();
}
```

- [ ] **Step 2: Verify + commit**

```
flutter analyze && flutter test
git add -A
git commit -m "feat(profile): add-friends UI (stubbed)"
```

---

### Task 33: Final pass — analyzer, tests, manual smoke

**Files:** none

- [ ] **Step 1: Run the full battery**

```
flutter analyze
flutter test
dart format --output=write lib test
```
Expected: 0 issues; all tests green; format makes no changes.

- [ ] **Step 2: Manual smoke on Android emulator**

Run: `flutter run`
Walk through: create a habit → mark today → swipe to last month → toggle a past day → set theme to dark → switch locale to English → open profile → toggle hardcore mode → re-open habit detail and confirm streak recomputes.

- [ ] **Step 3: Commit any formatting fixes**

```
git add -A
git commit -m "chore: format"
```

- [ ] **Step 4: Tag phase-1**

```
git tag v0.1.0-phase1
```

---

## Self-review

(See spec sections 1–9.)

- **§1 Phase 1 scope:** habit CRUD (Tasks 18, 19, 22), heatmap + streaks (Tasks 23–25), local reminders (Task 26), stubbed social (Tasks 29–32), level/XP stubbed UI (Task 28's profile screen).
- **§2 Decision matrix:** every entry has a corresponding task.
- **§3 Architecture / folder layout:** Tasks 6–12 build the foundation matching the layout exactly.
- **§4 Data model:** Tasks 14–16.
- **§5 Repositories + services + streak rules:** Tasks 17, 18, 23, 26, 27, 29 — streak rules tested in Task 23.
- **§6 ViewModels per screen:** Tasks 19 (list), 22 (create), 25 (detail), 28 (profile).
- **§7 Nav / errors / theming:** Tasks 11 (routing), 7 (themes), Command helper (Task 9) for errors.
- **§8 Testing strategy:** fakes built in Tasks 17, 19, 23, 26, 27, 29; tests every milestone.
- **§9 Phased delivery:** mapped 1:1 to milestones above.

No placeholders found. Types and method signatures cross-reference consistently across tasks (`HabitId`, `Habit`, `HabitListItem`, `Command<Arg,Result>`).
