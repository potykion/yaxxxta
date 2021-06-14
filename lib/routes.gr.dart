// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'logic/core/web/controllers.dart' as _i3;
import 'logic/habit/models.dart' as _i11;
import 'pages/auth.dart' as _i5;
import 'pages/form.dart' as _i7;
import 'pages/loading.dart' as _i4;
import 'pages/settings.dart' as _i10;
import 'ui/archive/page.dart' as _i9;
import 'ui/calendar/page.dart' as _i6;
import 'ui/list/page.dart' as _i8;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.webContentLoadedGuard})
      : super(navigatorKey);

  final _i3.WebContentLoadedGuard webContentLoadedGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoadingRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.LoadingPage());
    },
    AuthRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.AuthPage());
    },
    HabitRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    CalendarRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.CalendarPage());
    },
    HabitFormRoute.name: (routeData) {
      final args = routeData.argsAs<HabitFormRouteArgs>(
          orElse: () => const HabitFormRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.HabitFormPage(initial: args.initial));
    },
    ListHabitRoute.name: (routeData) {
      final args = routeData.argsAs<ListHabitRouteArgs>(
          orElse: () => const ListHabitRouteArgs());
      return _i1.MaterialPageX<int>(
          routeData: routeData,
          child: _i8.ListHabitPage(archived: args.archived));
    },
    HabitArchiveRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.HabitArchivePage());
    },
    SettingsRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.SettingsPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/loading', fullMatch: true),
        _i1.RouteConfig(LoadingRoute.name, path: '/loading'),
        _i1.RouteConfig(AuthRoute.name, path: '/auth'),
        _i1.RouteConfig(HabitRouter.name, path: '/habits', guards: [
          webContentLoadedGuard
        ], children: [
          _i1.RouteConfig(CalendarRoute.name, path: 'calendar'),
          _i1.RouteConfig(HabitFormRoute.name, path: 'form'),
          _i1.RouteConfig(ListHabitRoute.name, path: 'list'),
          _i1.RouteConfig(HabitArchiveRoute.name, path: 'archive'),
          _i1.RouteConfig(SettingsRoute.name, path: 'settings')
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

class HabitFormRoute extends _i1.PageRouteInfo<HabitFormRouteArgs> {
  HabitFormRoute({_i11.Habit? initial})
      : super(name, path: 'form', args: HabitFormRouteArgs(initial: initial));

  static const String name = 'HabitFormRoute';
}

class HabitFormRouteArgs {
  const HabitFormRouteArgs({this.initial});

  final _i11.Habit? initial;
}

class ListHabitRoute extends _i1.PageRouteInfo<ListHabitRouteArgs> {
  ListHabitRoute({bool archived = false})
      : super(name, path: 'list', args: ListHabitRouteArgs(archived: archived));

  static const String name = 'ListHabitRoute';
}

class ListHabitRouteArgs {
  const ListHabitRouteArgs({this.archived = false});

  final bool archived;
}

class HabitArchiveRoute extends _i1.PageRouteInfo {
  const HabitArchiveRoute() : super(name, path: 'archive');

  static const String name = 'HabitArchiveRoute';
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: 'settings');

  static const String name = 'SettingsRoute';
}
