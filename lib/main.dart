import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'deps.dart';
import 'routes.dart';
import 'theme.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

void main() async => runApp(
      // ProviderScope(observers: [Logger()], child: MyApp()),
      ProviderScope(child: MyApp()),
    );

/// Приложуха
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        routes: routes,
        // home: PlaygroundPage(),
        initialRoute: Routes.loading,
        theme: buildTheme(context),
        debugShowCheckedModeBanner: false,
      );
}
