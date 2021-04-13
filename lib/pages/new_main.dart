import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/core/circular_progress.dart';
import 'package:yaxxxta/logic/core/utils/num.dart';
import 'package:yaxxxta/logic/core/utils/list.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/widgets/core/date.dart';
import 'package:yaxxxta/widgets/new/perform_buttons.dart';

import '../routes.dart';

class NewMainPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider);
    var habitPerformingsValue =
        useProvider(newHabitPerformingControllerProvider);
    var todayValue = useProvider(todayValueProvider);
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

            var habit = habits[index];

            var highlights = Map.fromEntries(
              habitPerformings.map(
                (hp) => MapEntry(hp.performDateTime.date(), 1.0),
              ),
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
                                  ? CustomColors.almostBlack
                                  : (habits[i].stats.lastPerforming?.isToday() ?? false)
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
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          habit.title,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Opacity(
                            opacity: habit.goalValue > 1 &&
                                    habit.goalValue != todayValue
                                ? 1
                                : 0,
                            child: FloatingActionButton(
                              child: Icon(Icons.done),
                              onPressed: () {
                                context
                                    .read(newHabitPerformingControllerProvider
                                        .notifier)
                                    .perform(
                                        habit, habit.goalValue - todayValue);
                              },
                              backgroundColor: Colors.white,
                            ),
                          ),
                          HabitProgressButton(
                            habit: habit,
                            habitPerformings: todayHabitPerformings,
                          ),
                          FloatingActionButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              Routes.form,
                              arguments: habit,
                            ),
                            child: Icon(Icons.edit),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Calendar35Days(
                        initial: DateTime.now(),
                        highlights: highlights,
                        hideMonth: true,
                      ),
                      SizedBox(height: 8),
                      Material(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.add),
                                    onPressed: () {}),
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.list),
                                    onPressed: () {}),
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.settings),
                                    onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  bottom: 10,
                ),
              ],
            );
          },
          orElse: () => CenteredCircularProgress(),
        ),
      ),
    );
  }
}
