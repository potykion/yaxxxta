import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yaxxxta/pages/details.dart';
import 'package:yaxxxta/theme.dart';

import 'pages/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        // home: HabitListPage(),
        home: HabitDetailsPage(),
        theme: buildTheme(context),
      );
}
