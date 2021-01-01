import 'package:flutter/material.dart';
import 'package:yaxxxta/settings/ui/pages/settings.dart';

import 'habit/ui/details/pages.dart';
import 'habit/ui/form/pages.dart';
import 'habit/ui/list/pages.dart';

// ignore: avoid_classes_with_only_static_members
/// Роуты
abstract class Routes {
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
  Routes.list: (_) => HabitListPage(),
  Routes.details: (_) => HabitDetailsPage(),
  Routes.form: (_) => HabitFormPage(),
  Routes.settings: (_) => SettingsPage()
};
