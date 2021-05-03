// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'pages/auth.dart';
import 'pages/calendar.dart';
import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/loading.dart';
import 'pages/settings.dart';

part of 'routes.dart';


class AppRouter extends RootStackRouter {
  AppRouter([GlobalKey<NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoadingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: LoadingPage());
    },
    AuthRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: AuthPage());
    },
    CalendarRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CalendarPage());
    },
    HabitFormRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: HabitFormPage());
    },
    ListHabitRoute.name: (routeData) {
      return MaterialPageX<int>(
          routeData: routeData, child: ListHabitPage());
    },
    SettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SettingsPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(LoadingRoute.name, path: '/'),
        RouteConfig(AuthRoute.name, path: '/auth-page'),
        RouteConfig(CalendarRoute.name, path: '/calendar-page'),
        RouteConfig(HabitFormRoute.name, path: '/habit-form-page'),
        RouteConfig(ListHabitRoute.name, path: '/list-habit-page'),
        RouteConfig(SettingsRoute.name, path: '/settings-page')
      ];
}

class LoadingRoute extends PageRouteInfo {
  const LoadingRoute() : super(name, path: '/');

  static const String name = 'LoadingRoute';
}

class AuthRoute extends PageRouteInfo {
  const AuthRoute() : super(name, path: '/auth-page');

  static const String name = 'AuthRoute';
}

class CalendarRoute extends PageRouteInfo {
  const CalendarRoute() : super(name, path: '/calendar-page');

  static const String name = 'CalendarRoute';
}

class HabitFormRoute extends PageRouteInfo {
  const HabitFormRoute() : super(name, path: '/habit-form-page');

  static const String name = 'HabitFormRoute';
}

class ListHabitRoute extends PageRouteInfo {
  const ListHabitRoute() : super(name, path: '/list-habit-page');

  static const String name = 'ListHabitRoute';
}

class SettingsRoute extends PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}
