import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'core/ui/deps.dart';
import 'core/ui/pages/home.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// носкл
  await Hive.initFlutter();
  await Hive.openBox<Map>("habits");
  await Hive.openBox<Map>("habit_performings");
  await Hive.openBox<Map>("settings");

  /// пуши
  await flutterLocalNotificationsPlugin.initialize(InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: IOSInitializationSettings(),
    macOS: MacOSInitializationSettings(),
  ));

  /// инфа о аппе
  packageInfo = await PackageInfo.fromPlatform();

  /// тайм-зоны
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Europe/Moscow"));

  /// фаер-бейз
  await Firebase.initializeApp();

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
