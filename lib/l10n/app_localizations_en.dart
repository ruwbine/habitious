// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Habitious';

  @override
  String get tabAll => 'All';

  @override
  String get tabActive => 'Active';

  @override
  String get tabArchive => 'Archive';

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Stats';

  @override
  String get navFriends => 'Friends';

  @override
  String get navProfile => 'Profile';

  @override
  String get habitsTitle => 'My Habits';

  @override
  String get createHabit => 'Create habit';

  @override
  String get habitNameLabel => 'Habit name';

  @override
  String get frequencyLabel => 'Frequency';

  @override
  String get teamLabel => 'Team';

  @override
  String get remindersLabel => 'Reminders';

  @override
  String reminderEveryDayAt(String time) {
    return 'Every day at $time';
  }

  @override
  String get cardColorLabel => 'Card color';

  @override
  String get remindLazyOnes => 'Remind lazy ones';

  @override
  String get profileTitle => 'Profile';

  @override
  String get hardcoreMode => 'Hardcore mode';

  @override
  String get addFriends => 'Add friends';

  @override
  String get searchByUsername => 'Search by username';

  @override
  String get myQrCode => 'My QR code';

  @override
  String get scanQr => 'Scan QR';

  @override
  String friendRequests(int count) {
    return 'Friend requests ($count)';
  }

  @override
  String get myFriends => 'My friends';

  @override
  String sharedHabitsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shared habits',
      one: '1 shared habit',
    );
    return '$_temp0';
  }

  @override
  String level(int n) {
    return 'Level $n';
  }

  @override
  String weekProgress(int done, int total) {
    return '$done/$total days';
  }

  @override
  String streakDays(int n) {
    return '$n days';
  }

  @override
  String groupCompletion(int percent) {
    return 'Group completion $percent%';
  }

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageRu => 'Russian';

  @override
  String get languageEn => 'English';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';
}
