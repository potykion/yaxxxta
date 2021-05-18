import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/widgets/user_avatar.dart';

import '../../../routes.gr.dart';

class CalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int index) onHabitSelect;

  const CalendarAppBar({
    Key? key,
    required this.onHabitSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => AutoRouter.of(context).push(SettingsRoute()),
            child: UserAvatar(),
          ),
        ),
        title: IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;

            if (index != null) {
              onHabitSelect(index);
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => AutoRouter.of(context).push(HabitFormRoute()),
          ),
        ].reversed.toList(),
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
