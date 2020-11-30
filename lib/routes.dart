import 'package:flutter/material.dart';
import 'package:yaxxxta/pages/details.dart';
import 'package:yaxxxta/pages/form.dart';
import 'package:yaxxxta/pages/list.dart';

abstract class Routes {
  static final String list = "/list";
  static final String details = "/details";
  static final String form = "/form";
}

final Map<String, Widget Function(BuildContext context)> routes = {
  Routes.list: (_) => HabitListPage(),
  Routes.details: (_) => HabitDetailsPage(),
  Routes.form: (_) => HabitFormPage(),
};
