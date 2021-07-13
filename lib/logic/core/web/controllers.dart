import 'package:auto_route/auto_route.dart';

import '../../../routes.gr.dart';

bool webContentLoaded = false;

class WebContentLoadedGuard extends AutoRouteGuard {
  @override
  Future<bool> canNavigate(
    List<PageRouteInfo<dynamic>> pendingRoutes,
    StackRouter router,
  ) async {
    if (webContentLoaded) {
      return true;
    }

    router.root.push(LoadingRoute());
    return false;
  }
}
