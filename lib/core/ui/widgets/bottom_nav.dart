import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../routes.dart';
import '../../../theme.dart';

/// Боттом нав барчик
class AppBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentIndex = bottomNavRoutes.entries
        .firstWhere((e) => e.value == ModalRoute.of(context).settings.name)
        .key;

    return BottomNavigationBar(
      selectedItemColor: CustomColors.almostBlack,
      unselectedItemColor: CustomColors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: "Календарь",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Привычки",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Настройки",
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) => Navigator.pushReplacement<dynamic, dynamic>(
        context,
        PageTransition<dynamic>(
          child: routes[bottomNavRoutes[index]](context),
          type: currentIndex < index
              ? PageTransitionType.rightToLeftJoined
              : PageTransitionType.leftToRightJoined,
          childCurrent: routes[bottomNavRoutes[currentIndex]](context),
          settings: RouteSettings(name: bottomNavRoutes[index]),
        ),
      ),
    );
  }
}
