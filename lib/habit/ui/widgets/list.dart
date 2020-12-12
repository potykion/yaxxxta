import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../deps.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../state/view_models.dart';
import 'package:yaxxxta/habit/ui/state/controllers.dart';

/// Вью-моделька привычки
var habitVMProvider = ScopedProvider<HabitVM>(null);

/// Индекс повтора привычки в течение дня
var repeatIndexProvider = ScopedProvider<int>(null);

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
          Navigator.of(context).pushNamed(Routes.form, arguments: vm.id),
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
    var vm = useProvider(habitVMProvider);
    var repeatIndex = useProvider(repeatIndexProvider);

    var repeat = vm.repeats[repeatIndex];

    var timerState = useState<Timer>(null);

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: LinearProgressIndicator(
              value: repeat.progressPercentage,
              backgroundColor: Color(0xffFAFAFA),
              valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green
                  .withAlpha((repeat.progressPercentage * 255).toInt())),
            ),
          ),
        ),
        Positioned(
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              splashRadius: 20,
              icon: repeat.type == HabitType.time
                  ? (timerState.value?.isActive ?? false)
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow)
                  : Icon(Icons.done),
              onPressed: () {
                var controller = context.read(habitListControllerProvider);

                if (repeat.type == HabitType.repeats) {
                  controller.incrementHabitProgress(vm.id, repeatIndex);
                  controller.createPerfoming(
                    habitId: vm.id,
                    repeatIndex: repeatIndex,
                  );
                } else if (repeat.type == HabitType.time) {
                  if (timerState.value?.isActive ?? false) {
                    cancelTimer(timerState, controller, vm, repeatIndex);
                  } else {
                    timerState.value =
                        Timer.periodic(Duration(seconds: 1), (timer) {
                      var repeatComplete = context
                          .read(habitListControllerProvider)
                          .incrementHabitProgress(vm.id, repeatIndex);

                      if (repeatComplete) {
                        cancelTimer(timerState, controller, vm, repeatIndex);
                      }
                    });
                  }
                }
              },
            ),
          ),
        ),
        if (!repeat.isSingle)
          Positioned(
            child: SmallerText(text: repeat.progressStr, dark: true),
            right: 20,
          )
      ],
    );
  }

  void cancelTimer(ValueNotifier<Timer> timerState,
      HabitListController controller, HabitVM vm, int repeatIndex) {
    timerState.value.cancel();

    controller.createPerfoming(
      habitId: vm.id,
      repeatIndex: repeatIndex,
      performValue: timerState.value.tick.toDouble(),
    );

    timerState.value = null;
  }
}
