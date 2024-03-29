import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/ui/profile/profile_bottom_sheet.dart';

import '../form/habit_form.dart';

/// Боттом-нав на странице с календарем
class CalendarBottomNav extends HookWidget {
  /// Боттом-нав на странице с календарем
  const CalendarBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: (index) async {
        if (index == 0) {
          var habit = await showHabitFormBottomSheet(context);
          if (habit != null) {
            await context
                .read(habitCalendarStateProvider.notifier)
                .create(habit);
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
