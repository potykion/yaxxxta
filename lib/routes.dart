import 'package:auto_route/auto_route.dart';
import 'package:yaxxxta/ui/auth/page.dart';
import 'package:yaxxxta/ui/loading/page.dart';
import 'package:yaxxxta/ui/archive/page.dart';
import 'package:yaxxxta/ui/calendar/page.dart';


/// Роутер, который будет сгенерен кодогенерацией
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(path: "/loading", page: LoadingPage, initial: true),
    AutoRoute<dynamic>(path: "/auth", page: AuthPage),
    AutoRoute<dynamic>(
      page: EmptyRouterPage,
      name: "HabitRouter",
      path: "/habits",
      children: [
        AutoRoute<dynamic>(path: "calendar", page: CalendarPage),
        AutoRoute<dynamic>(path: "archive", page: HabitArchivePage),
      ],
    ),
  ],
)
class $AppRouter {}
