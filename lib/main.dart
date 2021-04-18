import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/theme.dart';

import 'routes.dart';

/// Логгер провайдеров
/// Нужно для логгирования изменений стейта
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
        routes: routes,
        // home: PlaygroundPage(),
        initialRoute: Routes.loading,
        debugShowCheckedModeBanner: false,
        theme: buildThemeData(context),
      );
}
