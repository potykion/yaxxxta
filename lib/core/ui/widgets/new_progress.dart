import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/habit/domain/models.dart';

import '../../../theme.dart';

class HabitProgressControl extends StatelessWidget {
  final double currentValue;
  final double goalValue;
  final void Function(double incrementValue) onValueIncrement;
  final HabitType habitType;

  const HabitProgressControl({
    Key key,
    this.currentValue,
    this.goalValue,
    this.onValueIncrement,
    this.habitType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => habitType == HabitType.repeats
      ? _RepeatProgressControl(
          currentValue: currentValue,
          goalValue: goalValue,
          onValueIncrement: onValueIncrement,
        )
      : _TimeProgressControl(
          currentValue: currentValue,
          goalValue: goalValue,
          onValueIncrement: onValueIncrement,
        );
}

class _RepeatProgressControl extends HookWidget {
  final double currentValue;
  final double goalValue;
  final void Function(double incrementValue) onValueIncrement;

  _RepeatProgressControl({
    @required this.currentValue,
    @required this.goalValue,
    @required this.onValueIncrement,
  });

  @override
  Widget build(BuildContext context) {
    var currentValueState = useState(currentValue);
    useValueChanged<double, void>(
      currentValue,
      (_, __) => currentValueState.value = currentValue,
    );

    return _BaseProgressControl(
      incrementButton: IconButton(
        splashRadius: 20,
        icon: Icon(Icons.done),
        onPressed: () {
          currentValueState.value += 1;
          onValueIncrement(1);
        },
      ),
      progressPercentage: min(currentValueState.value / goalValue, 1),
      progressStr: "${currentValueState.value.toInt()} / ${goalValue.toInt()}",
      showProgressStr: goalValue.toInt() != 1,
    );
  }
}

class _TimeProgressControl extends HookWidget {
  final double currentValue;
  final double goalValue;
  final void Function(double incrementValue) onValueIncrement;

  _TimeProgressControl({
    @required this.currentValue,
    @required this.goalValue,
    @required this.onValueIncrement,
  });

  String get progressStr {
    var currentValueDuration = Duration(seconds: currentValue.toInt()).format();
    var goalValueDuration = Duration(seconds: goalValue.toInt()).format();
    return "$currentValueDuration / $goalValueDuration";
  }

  @override
  Widget build(BuildContext context) {
    var currentValueState = useState(currentValue);
    var timerState = useState<Timer>(null);

    void _cancelTimer() {
      timerState.value.cancel();
      onValueIncrement(timerState.value.tick.toDouble());
      timerState.value = null;
    }

    return _BaseProgressControl(
      progressStr: progressStr,
      progressPercentage: min(currentValueState.value / goalValue, 1),
      incrementButton: IconButton(
        splashRadius: 20,
        icon: (timerState.value?.isActive ?? false)
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow),
        onPressed: () {
          if (timerState.value?.isActive ?? false) {
            _cancelTimer();
          } else {
            timerState.value = Timer.periodic(
              Duration(seconds: 1),
              (timer) {
                currentValueState.value += 1;
                if (currentValueState.value.toInt() == goalValue.toInt()) {
                  _cancelTimer();
                }
              },
            );
          }
        },
      ),
    );
  }
}

class _BaseProgressControl extends StatelessWidget {
  final double progressPercentage;
  final String progressStr;
  final bool showProgressStr;
  final Widget incrementButton;

  const _BaseProgressControl({
    Key key,
    @required this.progressPercentage,
    @required this.progressStr,
    @required this.incrementButton,
    this.showProgressStr = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: progressPercentage,
                backgroundColor: Color(0xffFAFAFA),
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: incrementButton,
            ),
          ),
          if (showProgressStr)
            Positioned(
              child: SmallerText(text: progressStr, dark: true),
              right: 20,
            )
        ],
      );
}
