import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/pages/form.dart';
import 'package:yaxxxta/pages/settings.dart';
import 'package:yaxxxta/ui/calendar/web/habit_list.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';
import 'package:yaxxxta/widgets/calendar_app_bar.dart';
import 'package:yaxxxta/widgets/perform_habit_btn.dart';
import 'package:yaxxxta/ui/core/user_avatar.dart';

var selectedHabitIndexProvider = StateProvider((ref) => 0);

enum DrawerType { settings, addHabit, editHabit }

var drawerTypeProvider = StateProvider<DrawerType>((_) => DrawerType.addHabit);

var habitToEditProvider = StateProvider<Habit?>((_) => null);

class CalendarWebPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var selectedHabitIndex = useProvider(selectedHabitIndexProvider).state;

    var vms = useProvider(habitVMsProvider);
    var vm = vms[selectedHabitIndex];

    return Scaffold(
      appBar: AppBar(
        leading: Logo(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    context.read(drawerTypeProvider).state =
                        DrawerType.settings;
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: UserAvatar(),
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read(drawerTypeProvider).state = DrawerType.addHabit;
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ].reversed.toList(),
        // titleSpacing: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vm.habit.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0,
                      // opacity: 1,
                      child: FloatingActionButton(
                        heroTag: null,
                        onPressed: () {},
                        child: Icon(Icons.edit),
                      ),
                    ),
                    SizedBox(width: 50),
                    PerformHabitButton(
                      vm: vm,
                    ),
                    SizedBox(width: 50),
                    Builder(
                      builder: (context) => FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          context.read(habitToEditProvider).state = vm.habit;
                          context.read(drawerTypeProvider).state =
                              DrawerType.editHabit;
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                HabitPerformingCalendar(vm: vm),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            child: HabitList(),
            left: 0,
            top: 0,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
      endDrawer: Container(
        width: 400,
        color: Colors.white,
        child: Consumer(
          builder: (context, watch, child) {
            var drawerType = watch(drawerTypeProvider).state;

            switch (drawerType) {
              case DrawerType.settings:
                return SettingsPage();
              case DrawerType.addHabit:
                return HabitFormPage();
              case DrawerType.editHabit:
                return HabitFormPage(
                  initial: context.read(habitToEditProvider).state,
                );
            }
          },
        ),
      ),
    );
  }
}
