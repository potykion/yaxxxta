import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/new/vms.dart';
import '../../theme.dart';

class HabitProgressButton extends HookWidget {
  final NewHabitVM vm;

  HabitProgressButton(this.vm);

  @override
  Widget build(BuildContext context) {
    var currentProgress = useState(vm.todayValue);

    return Stack(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: min(currentProgress.value / vm.habit.goalValue, 1),
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green),
            strokeWidth: 10,
          ),
        ),
        Container(
          width: 84,
          height: 84,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: vm.perform,
              child: vm.habit.type == HabitType.time
                  ? Icon(Icons.play_arrow)
                  : vm.isOnePerformingLeft
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
