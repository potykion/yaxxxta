import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:yaxxxta/logic/new/vms.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/core/circular_progress.dart';
import 'package:yaxxxta/logic/core/utils/num.dart';
import 'package:yaxxxta/logic/core/utils/list.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/widgets/core/date.dart';
import 'package:yaxxxta/widgets/new/new_bottom.dart';
import 'package:yaxxxta/widgets/new/perform_buttons.dart';

import '../routes.dart';

class NewMainPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider);
    var habitPerformingsValue =
        useProvider(newHabitPerformingControllerProvider);
    var todayHabitPerformings = useProvider(todayHabitPerformingsProvider);

    return Scaffold(
      body: PageView.builder(
        onPageChanged: (index) {
          index %= habits.length;
          context
              .read(newHabitPerformingControllerProvider.notifier)
              .load(habits[index].id!);
        },
        itemBuilder: (_, index) => habitPerformingsValue.maybeWhen(
          data: (habitPerformings) {
            index %= habits.length;

            var vm = NewHabitVM(
              context: context,
              habit: habits[index],
              allPerformings: habitPerformings,
              todayPerformings: todayHabitPerformings,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (var i in habits.length.range())
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 8,
                              height: 8,
                              color: i == index
                                  ? CustomColors.yellow
                                  : (habits[i]
                                              .stats
                                              .lastPerforming
                                              ?.isToday() ??
                                          false)
                                      ? CustomColors.green
                                      : CustomColors.grey.withAlpha(47),
                            ),
                          )
                      ]
                          .joinObject(
                              Padding(padding: EdgeInsets.only(right: 4)))
                          .toList(),
                    ),
                  ),
                  top: MediaQuery.of(context).padding.top + 10,
                ),
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        vm.habit.title,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Opacity(
                          opacity: vm.isMultiplePerformingsLeft ? 1 : 0,
                          child: FloatingActionButton(
                            child: Icon(Icons.done),
                            onPressed: () => vm.performFull(),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        HabitProgressButton(vm),
                        FloatingActionButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.form,
                            arguments: vm.habit,
                          ),
                          child: Icon(Icons.edit),
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Calendar35Days(
                      initial: DateTime.now(),
                      highlights: vm.highlights,
                      hideMonth: true,
                    ),
                    SizedBox(height: 88),
                  ],
                ),
              ],
            );
          },
          orElse: () => CenteredCircularProgress(),
        ),
      ),
      floatingActionButton: NewBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
