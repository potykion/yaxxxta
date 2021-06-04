import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/routes.gr.dart';

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({Key? key}) : super(key: key);

  Map<int, PageRouteInfo> get routes => {
        0: CalendarRoute(),
        1: ListHabitRoute(),
        2: SettingsRoute(),
      };

  @override
  Widget build(BuildContext context) {
    var currentRoute = AutoRouter.of(context).current.path;
    var currentIndex =
        routes.entries.where((e) => e.value.path == currentRoute).first.key;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) =>
          AutoRouter.of(context).replaceNamed(routes[index]!.path),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: "Календарь",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Список",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Настройки",
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
