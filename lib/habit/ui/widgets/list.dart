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
                  // ? (timer != null && timer.isActive
                  // ? Icon(Icons.pause)
                  ? Icon(Icons.play_arrow)
                  : Icon(Icons.done),
              onPressed: () {
                // todo
                if (repeat.type == HabitType.repeats) {
                  context
                      .read(habitListControllerProvider)
                      .incrementHabitProgress(vm.id, repeatIndex);
                }

                // if (timer != null && timer.isActive) {
                //   setState(() {
                //     timer.cancel();
                //   });
                // } else {
                //   setState(() =>
                //       timer = Timer.periodic(Duration(seconds: 1), (timer)
                //       {
                //         setState(() => habitRepeat.currentValue++);
                //         if (habitRepeat.currentValue ==
                //             habitRepeat.goalValue) {
                //           Get.find<NotificationSender>()
                //               .send(title: "Время закончилось!");
                //           timer.cancel();
                //         }
                //       }));
                // }
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
}
