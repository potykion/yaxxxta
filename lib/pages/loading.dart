import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../routes.dart';

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
        var user = FirebaseAuth.instance.currentUser;

        if (user?.isAnonymous ?? true) {
          Navigator.pushReplacementNamed(context, Routes.auth);
          return;
        }

        Navigator.pushReplacementNamed(context, Routes.calendar);
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
