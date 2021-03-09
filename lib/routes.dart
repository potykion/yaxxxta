import 'package:flutter/material.dart';

import 'pages/calendar.dart';
import 'pages/details.dart';
import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/loading.dart';
import 'pages/settings.dart';

// ignore: avoid_classes_with_only_static_members
/// Роуты
abstract class Routes {
  /// Страница подгрузки всего
  static final String loading = "/loading";

  /// Страница с календарем привычек
  static final String calendar = "/calendar";

  /// Страница со списком привычек
  static final String list = "/list";

  /// Страница инфы о привычке
  static final String details = "/details";

  /// Страница редактирования/создания привычки
  static final String form = "/form";

  /// Страница с настройками
  static final String settings = "/settings";
}

/// Маппинг роутов в страницы
final Map<String, Widget Function(BuildContext context)> routes = {
  Routes.loading: (_) => LoadingPage(),
  Routes.calendar: (_) => HabitCalendarPage(),
  Routes.list: (_) => HabitListPage(),
  Routes.details: (_) => HabitDetailsPage(),
  Routes.form: (_) => HabitFormPage(),
  Routes.settings: (_) => SettingsPage(),
};

/// Маппинг индексов bottomNavBar'а в роуты
Map<int, String> bottomNavRoutes = {
  0: Routes.calendar,
  1: Routes.list,
  2: Routes.settings,
};
