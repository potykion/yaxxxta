import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

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

        if (kDebugMode) {
          /// Вырубаем крашлитикс на дебаге
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(false);
        } else {
          /// Врубаем крашлитикс для всех ошибок на релизе
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterError;
        }

        if (kIsWeb) {
        } else {
          /// Врубаем покупку подписочки на мобилке
          if (defaultTargetPlatform == TargetPlatform.android) {
            InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
          }
          final available = await InAppPurchase.instance.isAvailable();
          if (available) {
            var resp =
                await InAppPurchase.instance.queryProductDetails({'sub'});
            context.read(subscriptionProductProvider).state =
                resp.productDetails.first;
          }

          /// Врубаем уведомленя на мобилке
          await localNotificationPlugin.initialize(
            InitializationSettings(
                android: AndroidInitializationSettings("app_icon")),
          );
        }

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

        await context.read(habitCalendarStateProvider.notifier).load(user.uid);
        await context
            .read(habitCalendarStateProvider.notifier)
            .scheduleNotificationsForHabitsWithoutNotifications();

        // endregion

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
            CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ),
            SizedBox(height: 8),
            Text(
              loadingTextState.value,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
