import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../routes.gr.dart';
import 'user_avatar.dart';

AppBar buildCalendarAppBar(
  BuildContext context, {
  List<Widget> extraActions = const [],
}) {
  return AppBar(
    leading: kIsWeb ? Logo() : null,
    actions: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => AutoRouter.of(context).push(SettingsRoute()),
            child: UserAvatar(),
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => AutoRouter.of(context).push(HabitFormRoute()),
      ),
      ...extraActions,
    ].reversed.toList(),
    // titleSpacing: 0,
  );
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image(image: AssetImage("assets/icon/app_icon.png")),
      );
}
