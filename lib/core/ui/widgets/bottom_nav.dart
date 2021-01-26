import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../theme.dart';

/// Боттом нав барчик
class AppBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        selectedItemColor: CustomColors.almostBlack,
        unselectedItemColor: CustomColors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Календарь",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Настройки",
          ),
        ],
        currentIndex: getCurrentIndex(context),
        onTap: (index) =>
            Navigator.of(context).pushReplacementNamed(bottomNavRoutes[index]),
      );

  int getCurrentIndex(BuildContext context) => bottomNavRoutes.entries
      .firstWhere((e) => e.value == ModalRoute.of(context).settings.name)
      .key;
}
