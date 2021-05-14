import 'package:auto_route/auto_route.dart';
import 'package:yaxxxta/pages/auth.dart';
import 'package:yaxxxta/pages/loading.dart';
import 'package:yaxxxta/ui/calendar/page.dart';

import 'logic/core/web/controllers.dart';
import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/settings.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(path: "/loading", page: LoadingPage, initial: true),
    AutoRoute<dynamic>(path: "/auth", page: AuthPage),
    AutoRoute<dynamic>(
      page: EmptyRouterPage,
      guards: [WebContentLoadedGuard],
      name: "HabitRouter",
      path: "/habits",
      children: [
        AutoRoute<dynamic>(path: "calendar", page: CalendarPage),
        AutoRoute<dynamic>(path: "form", page: HabitFormPage),
        AutoRoute<int>(path: "list", page: ListHabitPage),
        AutoRoute<dynamic>(path: "settings", page: SettingsPage),
      ],
    ),
  ],
)
class $AppRouter {}
