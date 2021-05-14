import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/core/web/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/routes.gr.dart';

/// Страничка, на которой подгружается все необходимое
class LoadingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var loadingTextState = useState("Ша все буит...");

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        loadingTextState.value = "Грузим системные настройки...";
        // region
        Intl.defaultLocale = 'ru_RU';
        initializeDateFormatting('ru_RU');

        /// тайм-зоны
        tz.initializeTimeZones();
        tz.setLocalLocation(tz.getLocation("Europe/Moscow"));

        /// фаер-бейз
        await Firebase.initializeApp();

        // endregion

        loadingTextState.value = "Грузим данные о юзере...";
        // region
        var user = FirebaseAuth.instance.currentUser ??
            await FirebaseAuth.instance.authStateChanges().first;

        if (user?.isAnonymous ?? true) {
          AutoRouter.of(context).replace(AuthRoute());
          return;
        }

        await context
            .read(appUserInfoControllerProvider.notifier)
            .load(user!.uid);
        // endregion

        loadingTextState.value = "Грузим привычки...";
        // region
        await context.read(habitControllerProvider.notifier).load(user.uid);
        // endregion

        webContentLoaded = true;

        AutoRouter.of(context)
            .replace(HabitRouter(children: [CalendarRoute()]));
      });
      return;
    }, []);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text(loadingTextState.value),
          ],
        ),
      ),
    );
  }
}
