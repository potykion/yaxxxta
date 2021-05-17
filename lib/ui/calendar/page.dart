import 'package:flutter/material.dart';

import 'app/page.dart';
import 'web/page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, size) =>
            size.maxWidth > 768 ? CalendarWebPage() : CalendarAppPage(),
      );
}
