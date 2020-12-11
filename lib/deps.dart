import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'habit/domain/db.dart';
import 'habit/infra/db.dart';
import 'habit/ui/state/controllers.dart';

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

/// Регает hive-box
Provider<Box<Map>> hiveBoxProvider = Provider((_) => Hive.box<Map>("habits"));

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
  (ref) => HabitRepo(ref.watch(hiveBoxProvider)),
);

/// Регает контроллер, загружая привычки
StateNotifierProvider<HabitListController> habitListControllerProvider =
    StateNotifierProvider(
  (ref) {
    var controller = HabitListController(ref.watch(habitRepoProvider));
    controller.loadHabits();
    return controller;
  },
);
