import 'package:flutter/material.dart';

import 'app/page.dart';
import 'web/page.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, size) =>
            size.maxWidth > 768 ? CalendarWebPage() : CalendarAppPage(),
      );
}
