import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/progress.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/list/view_models.dart';
import 'package:yaxxxta/habit/ui/list/widgets.dart';

import '../../../deps.dart';

class HabitProgressControl extends HookWidget {
  @override
  Widget build(BuildContext context) {
    HabitListVM vm = useProvider(habitVMProvider);
    var repeatIndex = useProvider(repeatIndexProvider);

    var repeat = vm.repeats[repeatIndex];

    return repeat.type == HabitType.time
        ? TimeProgressControl(
            currentValue: repeat.currentValue,
            goalValue: repeat.goalValue,
            onTimerIncrement: () => context
                .read(habitListControllerProvider)
                .incrementHabitProgress(vm.id, repeatIndex),
            onTimerStop: (ticks) {
              context.read(habitListControllerProvider).createPerforming(
                    habitId: vm.id,
                    repeatIndex: repeatIndex,
                    performValue: ticks.toDouble(),
                  );
            },
          )
        : RepeatProgressControl(
            onRepeatIncrement: () {
              context.read(habitListControllerProvider)
                ..incrementHabitProgress(vm.id, repeatIndex)
                ..createPerforming(habitId: vm.id, repeatIndex: repeatIndex);
            },
            currentValue: repeat.currentValue,
            goalValue: repeat.goalValue,
          );
  }
}
