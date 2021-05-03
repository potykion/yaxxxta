// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'logic/habit/models.dart' as _i9;
import 'pages/auth.dart' as _i4;
import 'pages/calendar.dart' as _i5;
import 'pages/form.dart' as _i6;
import 'pages/list.dart' as _i7;
import 'pages/loading.dart' as _i3;
import 'pages/settings.dart' as _i8;

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
    CalendarRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CalendarPage());
    },
    HabitFormRoute.name: (routeData) {
      final args = routeData.argsAs<HabitFormRouteArgs>(
          orElse: () => const HabitFormRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.HabitFormPage(initial: args.initial));
    },
    ListHabitRoute.name: (routeData) {
      return _i1.MaterialPageX<int>(
          routeData: routeData, child: _i7.ListHabitPage());
    },
    SettingsRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.SettingsPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LoadingRoute.name, path: '/'),
        _i1.RouteConfig(AuthRoute.name, path: '/auth-page'),
        _i1.RouteConfig(CalendarRoute.name, path: '/calendar-page'),
        _i1.RouteConfig(HabitFormRoute.name, path: '/habit-form-page'),
        _i1.RouteConfig(ListHabitRoute.name, path: '/list-habit-page'),
        _i1.RouteConfig(SettingsRoute.name, path: '/settings-page')
      ];
}

class LoadingRoute extends _i1.PageRouteInfo {
  const LoadingRoute() : super(name, path: '/');

  static const String name = 'LoadingRoute';
}

class AuthRoute extends _i1.PageRouteInfo {
  const AuthRoute() : super(name, path: '/auth-page');

  static const String name = 'AuthRoute';
}

class CalendarRoute extends _i1.PageRouteInfo {
  const CalendarRoute() : super(name, path: '/calendar-page');

  static const String name = 'CalendarRoute';
}

class HabitFormRoute extends _i1.PageRouteInfo<HabitFormRouteArgs> {
  HabitFormRoute({_i9.Habit? initial})
      : super(name,
            path: '/habit-form-page',
            args: HabitFormRouteArgs(initial: initial));

  static const String name = 'HabitFormRoute';
}

class HabitFormRouteArgs {
  const HabitFormRouteArgs({this.initial});

  final _i9.Habit? initial;
}

class ListHabitRoute extends _i1.PageRouteInfo {
  const ListHabitRoute() : super(name, path: '/list-habit-page');

  static const String name = 'ListHabitRoute';
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}
