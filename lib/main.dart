import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/ui/deps.dart';
import 'core/ui/pages/home.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Map>("habits");
  await Hive.openBox<Map>("habit_performings");
  await Hive.openBox<Map>("settings");

  await flutterLocalNotificationsPlugin.initialize(InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: IOSInitializationSettings(),
    macOS: MacOSInitializationSettings(),
  ));

  runApp(ProviderScope(child: MyApp()));
}


/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        routes: routes,
        home: HomePage(),
        theme: buildTheme(context),
      );
}
