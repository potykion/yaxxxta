import 'package:flutter/material.dart';
import 'package:yaxxxta/pages/auth.dart';
import 'package:yaxxxta/pages/calendar.dart';
import 'package:yaxxxta/pages/loading.dart';

import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/settings.dart';

// ignore: avoid_classes_with_only_static_members
/// Роуты
abstract class Routes {
  /// Страница подгрузки всего
  static final String loading = "/loading";

  /// Страница аутентификации
  static final String auth = "/auth";

  static final String calendar = "/calendar";
  static final String form = "/form";
  static final String list = "/list";
  static final String settings = "/settings";
}

/// Маппинг роутов в страницы
final Map<String, Widget Function(BuildContext context)> routes = {
  Routes.loading: (_) => LoadingPage(),
  Routes.auth: (_) => AuthPage(),
  Routes.calendar: (_) => CalendarPage(),
  Routes.form: (_) => HabitFormPage(),
  Routes.list: (_) => ListHabitPage(),
  Routes.settings: (_) => SettingsPage(),
};
