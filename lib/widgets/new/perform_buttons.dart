import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme.dart';

class HabitProgressButton extends HookWidget {
  final Habit habit;
  final List<HabitPerforming> habitPerformings;

  const HabitProgressButton({
    Key? key,
    required this.habit,
    required this.habitPerformings,
  }) : super(key: key);

  double get habitPerformingValueSum {
    if (habitPerformings.isEmpty) return 0;
    return habitPerformings
        .map((hp) => hp.performValue)
        .reduce((v1, v2) => v1 + v2);
  }

  @override
  Widget build(BuildContext context) {
    var currentProgress = useState(habitPerformingValueSum);

    return Stack(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: min(currentProgress.value / habit.goalValue, 1),
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green),
            strokeWidth: 10,
          ),
        ),
        Container(
          width: 84,
          height: 84,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                context
                    .read(newHabitPerformingControllerProvider.notifier)
                    .perform(habit);
              },
              child: habit.type == HabitType.time
                  ? Icon(Icons.play_arrow)
                  : (habitPerformingValueSum == 0 && habit.goalValue == 1)
                      ? Icon(Icons.done)
                      : Text(
                          "+1",
                          style: Theme.of(context).textTheme.headline6,
                        ),
              backgroundColor: Colors.white,
            ),
          ),
        )
      ],
      alignment: Alignment.center,
    );
  }
}
