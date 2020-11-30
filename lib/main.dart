import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yaxxxta/deps.dart';
import 'package:yaxxxta/pages/details.dart';
import 'package:yaxxxta/pages/edit.dart';
import 'package:yaxxxta/pages/list.dart';
import 'package:yaxxxta/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await initDeps();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        routes: {
          "/list": (_) => HabitListPage(),
          "/details": (_) => HabitDetailsPage(),
          "/form": (_) => HabitFormPage(),
        },
        initialRoute: "/form",
        theme: buildTheme(context),
      );
}
