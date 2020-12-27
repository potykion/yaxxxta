import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/progress.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import 'package:yaxxxta/habit/ui/details/deps.dart';

var _vm = StateProvider((ref) => HabitListPageVM.build(
      ref.watch(habitDetailsController.state).habit,
      ref.watch(habitDetailsController.state).habitPerformings,
    ));

var _repeat = Provider.family(
  (ref, int index) => ref.watch(_vm).state.repeats[index],
);

class HabitDetailsProgressControl extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vmState = useProvider(_vm);
    var vm = vmState.state;
    var repeatIndex = useProvider(repeatIndexProvider);
    var repeat = useProvider(_repeat(repeatIndex));

    incrementHabitProgress() {
      vmState.state = vmState.state.copyWith(repeats: [
        for (var repeatWithIndex in vmState.state.repeats.asMap().entries)
          if (repeatWithIndex.key == repeatIndex)
            repeatWithIndex.value.copyWith(
              currentValue: repeatWithIndex.value.currentValue + 1,
            )
          else
            repeatWithIndex.value,
      ]);
      return vmState.state.repeats[repeatIndex].isComplete;
    }

    return repeat.type == HabitType.time
        ? TimeProgressControl(
            currentValue: repeat.currentValue,
            goalValue: repeat.goalValue,
            onTimerIncrement: incrementHabitProgress,
            onTimerStop: (ticks) {
              context
                  .read(habitDetailsController)
                  .createPerformingAndUpdateHistory(
                    habitId: vm.id,
                    repeatIndex: repeatIndex,
                    performValue: ticks.toDouble(),
                  );
            },
          )
        : RepeatProgressControl(
            onRepeatIncrement: () {
              incrementHabitProgress();
              context
                  .read(habitDetailsController)
                  .createPerformingAndUpdateHistory(
                    habitId: vm.id,
                    repeatIndex: repeatIndex,
                  );
            },
            currentValue: repeat.currentValue,
            goalValue: repeat.goalValue,
          );
  }
}
