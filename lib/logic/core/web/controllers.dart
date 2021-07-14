import 'package:auto_route/auto_route.dart';

import '../../../routes.gr.dart';

/// См. WebContentLoadedGuard
bool webContentLoaded = false;

/// В вебе хот-релоад сбрасывает стейт - его надо грузить заново
/// Этот класс редиректит на страницу подгрузки,
/// если флажок webContentLoaded = false
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
