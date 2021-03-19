import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tuple/tuple.dart';

import 'package:yaxxxta/logic/core/utils/list.dart';
import '../../routes.dart';
import '../../theme.dart';

/// Боттом нав барчик
class AppBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentRoute = ModalRoute.of(context)!.settings.name;

    var currentIndex =
        bottomNavRoutes.entries.firstWhere((e) => e.value == currentRoute).key;

    return BottomAppBar(
      child: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Tuple2<String, IconData>("Календарь", Icons.today),
              Tuple2<String, IconData>("Награды", Icons.cake),
              Tuple2<String, IconData>("Настройки", Icons.settings),
            ]
                .mapWithIndex(
                  (textAndIcon, index) => AppBottomNavBarItem(
                      text: textAndIcon.item1,
                      icon: textAndIcon.item2,
                      selected: bottomNavRoutes[index] == currentRoute,
                      onTap: () {
                        /// Не меняем страницу, если индекс не изменился
                        if (currentIndex == index) {
                          return;
                        }

                        Navigator.pushReplacement<dynamic, dynamic>(
                          context,
                          PageTransition<dynamic>(
                            child: routes[bottomNavRoutes[index]]!(context),
                            type: currentIndex < index
                                ? PageTransitionType.rightToLeftJoined
                                : PageTransitionType.leftToRightJoined,
                            childCurrent:
                                routes[bottomNavRoutes[currentIndex]]!(context),
                            settings:
                                RouteSettings(name: bottomNavRoutes[index]),
                          ),
                        );
                      }),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

/// Кнопочка в боттом апп баре
class AppBottomNavBarItem extends StatelessWidget {
  /// Иконка
  final IconData icon;

  /// Текст
  final String text;

  /// Выбрана ли кнопка
  final bool selected;

  /// Событие нажатия
  final void Function() onTap;

  /// Кнопочка в боттом апп баре
  const AppBottomNavBarItem({
    Key? key,
    required this.icon,
    required this.text,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? CustomColors.yellow : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon), Text(text)],
          ),
        ),
      );
}
