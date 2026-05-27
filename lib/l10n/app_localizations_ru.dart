// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Habitious';

  @override
  String get tabAll => 'Все';

  @override
  String get tabActive => 'Активные';

  @override
  String get tabArchive => 'Архив';

  @override
  String get navHome => 'Главная';

  @override
  String get navStats => 'Статистика';

  @override
  String get navFriends => 'Друзья';

  @override
  String get navProfile => 'Профиль';

  @override
  String get habitsTitle => 'Мои привычки';

  @override
  String get createHabit => 'Создать привычку';

  @override
  String get habitNameLabel => 'Название привычки';

  @override
  String get frequencyLabel => 'Частота';

  @override
  String get teamLabel => 'Команда';

  @override
  String get remindersLabel => 'Напоминания';

  @override
  String reminderEveryDayAt(String time) {
    return 'Каждый день в $time';
  }

  @override
  String get cardColorLabel => 'Цвет карточки';

  @override
  String get remindLazyOnes => 'Напомнить ленивым';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get hardcoreMode => 'Хардкор режим';

  @override
  String get addFriends => 'Добавить друзей';

  @override
  String get searchByUsername => 'Поиск по username';

  @override
  String get myQrCode => 'Мой QR-код';

  @override
  String get scanQr => 'Сканировать QR';

  @override
  String friendRequests(int count) {
    return 'Запросы в друзья ($count)';
  }

  @override
  String get myFriends => 'Мои друзья';

  @override
  String sharedHabitsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count общих привычек',
      many: '$count общих привычек',
      few: '$count общие привычки',
      one: '1 общая привычка',
    );
    return '$_temp0';
  }

  @override
  String level(int n) {
    return 'Уровень $n';
  }

  @override
  String weekProgress(int done, int total) {
    return '$done/$total дней';
  }

  @override
  String streakDays(int n) {
    return '$n дней';
  }

  @override
  String groupCompletion(int percent) {
    return 'Группа выполнила $percent%';
  }

  @override
  String get leaderboard => 'Лидерборд';

  @override
  String get weekdayMon => 'Пн';

  @override
  String get weekdayTue => 'Вт';

  @override
  String get weekdayWed => 'Ср';

  @override
  String get weekdayThu => 'Чт';

  @override
  String get weekdayFri => 'Пт';

  @override
  String get weekdaySat => 'Сб';

  @override
  String get weekdaySun => 'Вс';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get languageRu => 'Русский';

  @override
  String get languageEn => 'Английский';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';
}
