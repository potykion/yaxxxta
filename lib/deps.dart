import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'habit/domain/db.dart';
import 'habit/infra/db.dart';
import 'settings/domain/models.dart';
import 'settings/infra/db.dart';

// todo в контроллер засунуть отправку пушей
/// Регает зависимости
// Future<void> initDeps() async {
//   await Hive.initFlutter();
//
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   var initializationSettings = InitializationSettings(
//     android: AndroidInitializationSettings('app_icon'),
//     iOS: IOSInitializationSettings(),
//     macOS: MacOSInitializationSettings(),
//   );
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   await Get.putAsync(
//     () async => await Hive.openBox<Map>('habits'),
//     tag: 'habits',
//   );
//   Get.put(HabitRepo(Get.find(tag: 'habits')));
//   Get.put(NotificationSender(flutterLocalNotificationsPlugin));
// }

////////////////////////////////////////////////////////////////////////////////
// CORE
////////////////////////////////////////////////////////////////////////////////

/// Регает индекс выбранной странички
StateProvider<int> pageIndexProvider = StateProvider((_) => 0);

////////////////////////////////////////////////////////////////////////////////
// HABIT
////////////////////////////////////////////////////////////////////////////////

/// Регает hive-box для привычек
Provider<Box<Map>> _habitBoxProvider = Provider((_) => Hive.box<Map>("habits"));

/// Регает hive-box для выполнений привычек
Provider<Box<Map>> _habitPerformingBoxProvider =
    Provider((_) => Hive.box<Map>("habit_performings"));

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
  (ref) => HabitRepo(ref.watch(_habitBoxProvider)),
);

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => HabitPerformingRepo(ref.watch(_habitPerformingBoxProvider)),
);

////////////////////////////////////////////////////////////////////////////////
// SETTINGS
////////////////////////////////////////////////////////////////////////////////

/// Регает hive-box для настроек
Provider<Box<Map>> _settingsBoxProvider =
    Provider((_) => Hive.box<Map>("settings"));

/// Регает репо настроек
Provider<SettingsRepo> settingsRepoProvider =
    Provider((ref) => SettingsRepo(ref.watch(_settingsBoxProvider)));

/// Регает настройки
StateProvider<Settings> settingsProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).get(),
);
