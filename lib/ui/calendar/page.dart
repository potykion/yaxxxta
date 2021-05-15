import 'package:flutter/material.dart';

import 'app/page.dart';
import 'web/page.dart';

class CalendarPage extends StatelessWidget {
  final int? initialIndex;

  const CalendarPage({Key? key, this.initialIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, size) => size.maxWidth > 768
            ? CalendarWebPage()
            : CalendarAppPage(initialIndex: initialIndex),
      );
}
