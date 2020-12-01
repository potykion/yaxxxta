import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'deps.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  await Hive.initFlutter();
  await initDeps();
  runApp(MyApp());
}

/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        routes: routes,
        initialRoute: Routes.list,
        theme: buildTheme(context),
      );
}
