import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'deps.dart';
import 'routes.dart';
import 'theme.dart';

void main() async => runApp(ProviderScope(child: MyApp()));

/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        routes: routes,
        initialRoute: Routes.loading,
        theme: buildTheme(context),
        debugShowCheckedModeBanner: false,
      );
}
