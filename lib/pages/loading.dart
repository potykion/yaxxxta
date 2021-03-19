import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yaxxxta/logic/habit/services.dart';
import 'package:yaxxxta/logic/habit/ui/core/controllers.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/logic/user/domain/services.dart';
import 'package:yaxxxta/logic/user/ui/controllers.dart';

import '../deps.dart';
import '../routes.dart';
import '../widgets/core/circular_progress.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';

/// Страничка, на которой подгружается все необходимое
class LoadingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var loadingTextState = useState("Ша все буит...");

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        loadingTextState.value = "Грузим настройки...";

        // region
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

        var auth = context.read(authProvider);
        var user = auth.tryGetUser() ?? (await auth.signInAnon());
        await context.read(userDataControllerProvider).load(
              user: user,
              deviceId: androidInfo.id,
            );
        var userData = context.read(userDataControllerProvider.state)!;
        // endregion

        loadingTextState.value = "Грузим привычки...";

        // region
        await context.read(habitControllerProvider).load(userData.habitIds);

        await context
            .read(scheduleNotificationsForHabitsWithoutNotificationsProvider)(
          context.read(habitControllerProvider.state),
        );

        await context
            .read(habitPerformingController)
            .loadDateHabitPerformings(DateTime.now());
        // endregion

        loadingTextState.value = "Грузим награды...";
        await context.read(rewardControllerProvider).load(userData.rewardIds);

        Navigator.pushReplacementNamed(context, Routes.calendar);
      });
      return;
    }, []);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CenteredCircularProgress(),
          SmallPadding.onlyBottom(),
          BiggerText(text: loadingTextState.value),
        ],
      ),
    );
  }
}
