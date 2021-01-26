import 'package:flutter/material.dart';

import 'core/ui/pages/loading.dart';
import 'habit/ui/details/pages.dart';
import 'habit/ui/form/pages.dart';
import 'habit/ui/list/pages.dart';
import 'settings/ui/pages/settings.dart';

// ignore: avoid_classes_with_only_static_members
/// Роуты
abstract class Routes {
  /// Страница подгрузки всего
  static final String loading = "/loading";

  /// Список привычек
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
  Routes.list: (_) => HabitListPage(),
  Routes.details: (_) => HabitDetailsPage(),
  Routes.form: (_) => HabitFormPage(),
  Routes.settings: (_) => SettingsPage(),
};

Map<int, String> bottomNavRoutes = {
  0: Routes.list,
  1: Routes.settings,
};
