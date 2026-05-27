import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_preferences.dart';
import 'data/repositories/drift_habit_repository.dart';
import 'data/repositories/habit_repository.dart';
import 'data/services/app_database.dart';
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
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
        ProxyProvider<AppDatabase, HabitRepository>(
          update: (_, db, __) => DriftHabitRepository(db),
        ),
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
