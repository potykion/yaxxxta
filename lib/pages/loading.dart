import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/services.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/logic/user/services.dart';

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

        await Hive.initFlutter();
        await Hive.openBox<Map<String, dynamic>>('user_data');
        await Hive.openBox<Map<String, dynamic>>('habits');
        await Hive.openBox<Map<String, dynamic>>('habit_performings');
        await Hive.openBox<Map<String, dynamic>>('rewards');

        // пуши
        if (kIsWeb) {
        } else {
          await flutterLocalNotificationsPlugin
              .initialize(InitializationSettings(
            android: AndroidInitializationSettings('app_icon'),
            iOS: IOSInitializationSettings(),
            macOS: MacOSInitializationSettings(),
          ));
        }

        /// тайм-зоны
        tz.initializeTimeZones();
        tz.setLocalLocation(tz.getLocation("Europe/Moscow"));

        /// фаер-бейз
        await Firebase.initializeApp();

        var auth = context.read(authProvider);
        var user = auth.tryGetUser() ?? (await auth.signInAnon());
        context.read(userProvider).state = user;
        await context.read(userDataControllerProvider).load(user: user);
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
