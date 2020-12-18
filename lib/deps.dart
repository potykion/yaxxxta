import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'habit/domain/db.dart';
import 'habit/infra/db.dart';
import 'habit/ui/state/controllers.dart';
import 'settings/domain/models.dart';
import 'settings/infra/db.dart';

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

/// Регает hive-box для привычек
Provider<Box<Map>> habitBoxProvider = Provider((_) => Hive.box<Map>("habits"));

/// Регает hive-box для настроек
Provider<Box<Map>> settingsBoxProvider =
    Provider((_) => Hive.box<Map>("settings"));

/// Регает hive-box для выполнений привычек
Provider<Box<Map>> habitPerformingBoxProvider =
    Provider((_) => Hive.box<Map>("habit_performings"));

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
  (ref) => HabitRepo(ref.watch(habitBoxProvider)),
);

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => HabitPerformingRepo(ref.watch(habitPerformingBoxProvider)),
);

/// Регает контроллер, загружая привычки
StateNotifierProvider<HabitListController> habitListControllerProvider =
    StateNotifierProvider(
  (ref) {
    var controller = HabitListController(
      habitRepo: ref.watch(habitRepoProvider),
      habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
      settings: ref.watch(settingsProvider).state,
    );
    controller.loadHabits();
    return controller;
  },
);

var habitsToShowProvider = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return ref
      .watch(habitListControllerProvider.state)
      .where((h) => settings.showCompleted || !h.isComplete)
      .toList();
});

/// Регает индекс выбранной странички
StateProvider<int> pageIndexProvider = StateProvider((_) => 0);

/// Регает репо настроек
Provider<SettingsRepo> settingsRepoProvider =
    Provider((ref) => SettingsRepo(ref.watch(settingsBoxProvider)));

/// Регает настройки
StateProvider<Settings> settingsProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).get(),
);
