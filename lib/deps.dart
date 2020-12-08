import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yaxxxta/controllers.dart';
import 'package:yaxxxta/push.dart';
import 'db.dart';

/// Регает зависимости
Future<void> initDeps() async {
  await Hive.initFlutter();

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: IOSInitializationSettings(),
    macOS: MacOSInitializationSettings(),
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Get.putAsync(
    () async => await Hive.openBox<Map>('habits'),
    tag: 'habits',
  );
  Get.put(HabitRepo(Get.find(tag: 'habits')));
  Get.put(NotificationSender(flutterLocalNotificationsPlugin));
}

var habitListControllerProvider = Provider((_) => HabitListController());
