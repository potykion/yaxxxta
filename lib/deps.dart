import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:yaxxxta/controllers.dart';
import 'db.dart';

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

Provider<Box<Map>> hiveBoxProvider = Provider((_) => Hive.box<Map>("habits"));
Provider<HabitRepo> habitRepoProvider = Provider(
  (ref) => HabitRepo(ref.watch(hiveBoxProvider)),
);
Provider<HabitListController> habitListControllerProvider = Provider(
  (ref) => HabitListController(ref.watch(habitRepoProvider)),
);
