import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:device_info/device_info.dart';
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
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// носкл
  await Hive.initFlutter();
  await Hive.openBox<Map>("settings");

  /// пуши
  await flutterLocalNotificationsPlugin.initialize(InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: IOSInitializationSettings(),
    macOS: MacOSInitializationSettings(),
  ));

  /// инфа о аппе
  packageInfo = await PackageInfo.fromPlatform();

  var deviceInfo = DeviceInfoPlugin();
  androidInfo = await deviceInfo.androidInfo;

  /// тайм-зоны
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Europe/Moscow"));

  /// фаер-бейз
  await Firebase.initializeApp();

  if (!androidInfo.isPhysicalDevice) {
    var host = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';
    fs.FirebaseFirestore.instance.settings =
        fs.Settings(host: host, sslEnabled: false);
  }

  runApp(ProviderScope(child: MyApp()));
}

/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        routes: routes,
        initialRoute: Routes.loading,
        theme: buildTheme(context),
      );
}
