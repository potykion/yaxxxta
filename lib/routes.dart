import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/pages/auth.dart';
import 'package:yaxxxta/pages/calendar.dart';
import 'package:yaxxxta/pages/loading.dart';

import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/settings.dart';

part 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: LoadingPage, initial: true),
    AutoRoute<dynamic>(page: AuthPage),
    AutoRoute<dynamic>(page: CalendarPage),
    AutoRoute<dynamic>(page: HabitFormPage),
    AutoRoute<int>(page: ListHabitPage),
    AutoRoute<dynamic>(page: SettingsPage),
  ],
)
class $AppRouter {}

final appRouter = AppRouter();
