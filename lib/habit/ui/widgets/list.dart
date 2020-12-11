import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../state/view_models.dart';

/// Карточка привычки
class HabitCard extends StatefulWidget {
  /// Вью-моделька привычки
  final HabitVM vm;

  /// Индекс повтора привычки в течение дня
  final int repeatIndex;

  /// Создает карточку
  const HabitCard({
    Key key,
    this.vm,
    this.repeatIndex,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  String get title => widget.vm.title;

  HabitRepeatVM get repeat => widget.vm.repeats[widget.repeatIndex];

  bool get isSingleRepeat => widget.vm.repeats.length == 1;

  String get repeatCounter =>
      "${widget.repeatIndex + 1} / ${widget.vm.repeats.length}";

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.form, arguments: widget.vm.id),
        child: PaddedContainerCard(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              BiggerText(text: title),
              SizedBox(width: 5),
              if (repeat.performTime != null)
                SmallerText(text: repeat.performTimeStr),
              Spacer(),
              if (!isSingleRepeat) SmallerText(text: repeatCounter)
            ],
          ),
          SizedBox(height: 5),
          HabitProgressControl(
            initialHabitRepeat: repeat,
          )
        ]),
      );
}



/// Контрол для изменения прогресса привычки
class HabitProgressControl extends StatefulWidget {
  /// Очередное выполнение привычки
  final HabitRepeatVM initialHabitRepeat;

  /// Создает контрол
  const HabitProgressControl({Key key, this.initialHabitRepeat})
      : super(key: key);

  @override
  _HabitProgressControlState createState() => _HabitProgressControlState();
}

class _HabitProgressControlState extends State<HabitProgressControl> {
  HabitRepeatVM habitRepeat;
  Timer timer;

  @override
  void initState() {
    super.initState();
    habitRepeat = widget.initialHabitRepeat;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: habitRepeat.progressPercentage,
                backgroundColor: Color(0xffFAFAFA),
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green
                    .withAlpha((habitRepeat.progressPercentage * 255).toInt())),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                icon: habitRepeat.type == HabitType.time
                    ? (timer != null && timer.isActive
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow))
                    : Icon(Icons.done),
                onPressed: () {
                  // todo
                  // if (habitRepeat.type == HabitType.repeats) {
                  //   context.read(habitListControllerProvider)
                  //    .incrementHabitProgress(id, repeatIndex)
                  // }

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
          if (!habitRepeat.isSingle)
            Positioned(
              child: SmallerText(text: habitRepeat.progressStr, dark: true),
              right: 20,
            )
        ],
      );
}


