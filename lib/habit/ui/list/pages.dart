import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/utils/dt.dart';

import '../../../core/ui/widgets/date.dart';
import '../../../deps.dart';
import '../../../routes.dart';
import 'widgets.dart';

/// Страница списка привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(listHabitVMs);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kToolbarHeight),
            DatePicker(
              change: (date) {
                context.read(selectedDateProvider).state = date;

                if (!date.isToday()) {
                  context.read(dateHabitPerfomingsProvider).state =
                      context.read(loadDateHabitPerformingsProvider)(date);
                }
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          for (var vm in vms)
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.details,
                arguments: vm.id,
              ),
              child: HabitRepeatControl(
                repeatTitleBuilder: (repeat) => Row(children: [
                  BiggerText(text: vm.title),
                  SizedBox(width: 5),
                  if (repeat.performTime != null)
                    SmallerText(text: repeat.performTimeStr),
                ]),
                repeats: vm.repeats,
                initialRepeatIndex: vm.firstIncompleteRepeatIndex,
                onRepeatIncrement: (repeatIndex, incrementValue) async {
                  var selectedDate = context.read(selectedDateProvider).state;

                  var performing =
                      await context.read(createHabitPerformingProvider)(
                    habitId: vm.id,
                    repeatIndex: repeatIndex,
                    performValue: incrementValue,
                    performDateTime:
                        buildDateTime(selectedDate, DateTime.now()),
                  );

                  if (selectedDate.isToday()) {
                    context.read(todayHabitPerformingsProvider).state = [
                      ...context.read(todayHabitPerformingsProvider).state,
                      performing,
                    ];
                  } else {
                    context.read(dateHabitPerfomingsProvider).state = [
                      ...context.read(dateHabitPerfomingsProvider).state,
                      performing,
                    ];
                  }
                },
              ),
            )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 50),
        onPressed: () => Navigator.of(context).pushNamed(Routes.form),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
