import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:get/get.dart';

import 'deps.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  await initDeps();
  runApp(ProviderScope(child: MyApp()));
}

/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        routes: routes,
        initialRoute: Routes.list,
        // initialRoute: Routes.form,
        theme: buildTheme(context),
      );
}
