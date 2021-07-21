// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'ui/archive/page.dart' as _i6;
import 'ui/auth/page.dart' as _i4;
import 'ui/calendar/page.dart' as _i5;
import 'ui/loading/page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoadingRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LoadingPage());
    },
    AuthRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.AuthPage());
    },
    HabitRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    CalendarRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CalendarPage());
    },
    HabitArchiveRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.HabitArchivePage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/loading', fullMatch: true),
        _i1.RouteConfig(LoadingRoute.name, path: '/loading'),
        _i1.RouteConfig(AuthRoute.name, path: '/auth'),
        _i1.RouteConfig(HabitRouter.name, path: '/habits', children: [
          _i1.RouteConfig(CalendarRoute.name, path: 'calendar'),
          _i1.RouteConfig(HabitArchiveRoute.name, path: 'archive')
        ])
      ];
}

class LoadingRoute extends _i1.PageRouteInfo {
  const LoadingRoute() : super(name, path: '/loading');

  static const String name = 'LoadingRoute';
}

class AuthRoute extends _i1.PageRouteInfo {
  const AuthRoute() : super(name, path: '/auth');

  static const String name = 'AuthRoute';
}

class HabitRouter extends _i1.PageRouteInfo {
  const HabitRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/habits', children: children);

  static const String name = 'HabitRouter';
}

class CalendarRoute extends _i1.PageRouteInfo {
  const CalendarRoute() : super(name, path: 'calendar');

  static const String name = 'CalendarRoute';
}

class HabitArchiveRoute extends _i1.PageRouteInfo {
  const HabitArchiveRoute() : super(name, path: 'archive');

  static const String name = 'HabitArchiveRoute';
}
