import 'package:flutter/material.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

import 'app.dart';
import 'web.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, size) => WebPadding(
          child: size.maxWidth > 600 ? CalendarWebPage() : CalendarAppPage(),
        ),
      );
}
