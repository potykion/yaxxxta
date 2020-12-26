import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/core/ui/widgets/progress.dart';
import 'package:yaxxxta/habit/ui/list/view_models.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../deps.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import 'controllers.dart';

/// Вью-моделька привычки
ScopedProvider<HabitListVM> habitVMProvider = ScopedProvider<HabitListVM>(null);

/// Индекс повтора привычки в течение дня
ScopedProvider<int> repeatIndexProvider = ScopedProvider<int>(null);

/// Карточка привычки
class HabitCard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vm = useProvider(habitVMProvider);
    var repeatIndex = useProvider(repeatIndexProvider);

    var repeat = vm.repeats[repeatIndex];
    var isSingleRepeat = vm.repeats.length == 1;
    var repeatCounter = "${repeatIndex + 1} / ${vm.repeats.length}";

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.details, arguments: vm.id),
      child: PaddedContainerCard(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            BiggerText(text: vm.title),
            SizedBox(width: 5),
            if (repeat.performTime != null)
              SmallerText(text: repeat.performTimeStr),
            Spacer(),
            if (!isSingleRepeat) SmallerText(text: repeatCounter)
          ],
        ),
        SizedBox(height: 5),
        HabitProgressControl()
      ]),
    );
  }
}

/// Контрол для изменения прогресса привычки
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
