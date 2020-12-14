import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../deps.dart';
import '../../../theme.dart';

class AppBottomNavigationBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var pageIndexState = useProvider(pageIndexProvider);

    return BottomNavigationBar(
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
      currentIndex: pageIndexState.state,
      onTap: (index) => context.read(pageIndexProvider).state = index,
    );
  }
}
