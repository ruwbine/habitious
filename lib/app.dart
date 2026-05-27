import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_preferences.dart';
import 'data/repositories/completion_repository.dart';
import 'data/repositories/drift_completion_repository.dart';
import 'data/repositories/drift_habit_repository.dart';
import 'data/repositories/fake_social_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/social_repository.dart';
import 'data/services/app_database.dart';
import 'data/services/clock_service.dart';
import 'data/services/notification_service.dart';
import 'l10n/app_localizations.dart';
import 'profile_sync.dart';
import 'routing/app_router.dart';
import 'ui/core/themes/dark_theme.dart';
import 'ui/core/themes/light_theme.dart';

class HabitiousApp extends StatefulWidget {
  const HabitiousApp({
    super.key,
    required this.database,
    required this.profileRepository,
    required this.preferences,
    required this.hardcoreFlag,
    required this.notifications,
  });

  final AppDatabase database;
  final ProfileRepository profileRepository;
  final AppPreferences preferences;
  final HardcoreFlag hardcoreFlag;
  final NotificationService notifications;

  @override
  State<HabitiousApp> createState() => _HabitiousAppState();
}

class _HabitiousAppState extends State<HabitiousApp> {
  final _router = buildRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await widget.notifications.requestPermission();
      } catch (_) {
        // ignore failures on simulators/headless tests
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.preferences),
        ChangeNotifierProvider.value(value: widget.hardcoreFlag),
        Provider<AppDatabase>.value(value: widget.database),
        Provider<NotificationService>.value(value: widget.notifications),
        Provider<ProfileRepository>.value(value: widget.profileRepository),
        Provider<ClockService>(create: (_) => SystemClockService()),
        ProxyProvider<AppDatabase, HabitRepository>(
          update: (_, db, __) => DriftHabitRepository(db),
        ),
        ProxyProvider2<AppDatabase, ClockService, CompletionRepository>(
          update: (_, db, clock, __) => DriftCompletionRepository(db, clock),
        ),
        Provider<SocialRepository>(create: (_) => FakeSocialRepository.seeded()),
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
