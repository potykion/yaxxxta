import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../deps.dart';
import '../../../routes.dart';
import '../widgets/text.dart';

/// Страничка, на которой подгружается все необходимое
class LoadingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
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

        await context.read(settingsControllerProvider).loadSettings();
        await context
            .read(scheduleNotificationsForHabitsWithoutNotificationsProvider)();

        var auth = context.read(authProvider);
        var user = auth.tryGetUser() ?? (await auth.signInAnon());
        var userData = await context.read(loadUserDataProvider)(
          user: user,
          deviceId: androidInfo.id,
        );

        // todo грузим привычки
        // var habits = await context.read(provider)

        Navigator.pushReplacementNamed(context, Routes.calendar);
      });
      return;
    }, []);

    return Scaffold(
      body: Center(child: BiggerText(text: "Ща все буит...")),
    );
  }
}
