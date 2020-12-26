import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/core/utils/dt.dart';

import '../../../theme.dart';

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

class RepeatProgressControl extends StatelessWidget {
  final void Function() onRepeatIncrement;
  final double currentValue;
  final double goalValue;

  RepeatProgressControl({
    @required this.onRepeatIncrement,
    @required this.currentValue,
    @required this.goalValue,
  });

  @override
  Widget build(BuildContext context) => _BaseProgressControl(
        incrementButton: IconButton(
          splashRadius: 20,
          icon: Icon(Icons.done),
          onPressed: onRepeatIncrement,
        ),
        progressPercentage: min(currentValue / goalValue, 1),
        progressStr: "${currentValue.toInt()} / ${goalValue.toInt()}",
        showProgressStr: goalValue.toInt() != 1,
      );
}

class TimeProgressControl extends HookWidget {
  final bool Function() onTimerIncrement;
  final void Function(int ticks) onTimerStop;
  final double currentValue;
  final double goalValue;

  TimeProgressControl({
    @required this.onTimerIncrement,
    @required this.onTimerStop,
    @required this.currentValue,
    @required this.goalValue,
  });

  String get progressStr {
    var currentValueDuration = Duration(seconds: currentValue.toInt()).format();
    var goalValueDuration = Duration(seconds: goalValue.toInt()).format();
    return "$currentValueDuration / $goalValueDuration";
  }

  @override
  Widget build(BuildContext context) {
    var timerState = useState<Timer>(null);

    void _cancelTimer() {
      timerState.value.cancel();
      onTimerStop(timerState.value.tick);
      timerState.value = null;
    }

    return _BaseProgressControl(
      progressStr: progressStr,
      progressPercentage: min(currentValue / goalValue, 1),
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
                var stopTimer = onTimerIncrement();
                if (stopTimer) {
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
