import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/core/utils/map.dart';
import 'package:yaxxxta/routes.dart';

class MyBottomNav extends StatelessWidget {
  static List<String> navRoutes = [
    Routes.calendar,
    Routes.list,
    Routes.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navRoutes.indexOf(ModalRoute.of(context)!.settings.name!),
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
      onTap: (index) =>
          Navigator.pushReplacementNamed(context, navRoutes[index]),
    );
  }
}
