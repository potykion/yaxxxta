import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/ui/profile/profile_bottom_sheet.dart';

import 'habit_form.dart';

class MyBottomNav extends HookWidget {
  const MyBottomNav({Key? key}) : super(key: key);

  Map<int, PageRouteInfo> get routes => {
        0: CalendarRoute(),
        1: ListHabitRoute(),
        2: SettingsRoute(),
      };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: (index) async {
        if (index == 0) {
          var habit = await showHabitFormBottomSheet(context);
          if (habit != null) {
            await context.read(habitControllerProvider.notifier).create(habit);
          }
        }
        if (index == 2) {
          showProfileBottomSheet(context);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: "Создание",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: "Календарь",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Настройки",
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
