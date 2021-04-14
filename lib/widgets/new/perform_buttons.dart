import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/new/vms.dart';
import '../../theme.dart';

class SmartTimer {
  Timer? timer;
  int _passedSeconds = 0;
  int initialSeconds;
  int limitSeconds;
  final void Function(int passedSecods) onTimerStop;

  SmartTimer({
    this.initialSeconds = 0,
    required this.limitSeconds,
    required this.onTimerStop,
  });

  void toggle() {
    if (timer?.isActive ?? false) {
      cancel();
    } else {
      activate();
    }
  }

  void cancel() {
    timer?.cancel();
    onTimerStop(_passedSeconds);
  }

  void activate() {
    var timerStart = DateTime.now();

    timer = Timer.periodic(
      /// 250 мс для быстрой перерисовки
      Duration(microseconds: 250),
      (timer) {
        var currentTime = DateTime.now();

        /// Обновление прогресса = timerStart - currentTime
        /// Потому что андроид может застопить апп, в тч таймер =>
        /// Надо прогресс обновлять по разнице во времени
        var millisecondDiff = currentTime.difference(timerStart).inMilliseconds;

        /// Если секунда не прошла => скипаем обновление
        /// 900 мс потому что таймер тикает с погрешностью
        if (millisecondDiff < 900) {
          return;
        }

        var secondDiff = (millisecondDiff / 1000).round();
        timerStart = currentTime;

        _passedSeconds += secondDiff;

        if (initialSeconds + _passedSeconds == limitSeconds) {
          cancel();
        }
      },
    );
  }
}

SmartTimer useSmartTimer({
  int initialSeconds = 0,
  required int limitSeconds,
  required void Function(int passedSecods) onTimerStop,
}) {
  return use(_SmartTimerHook(
    initialSeconds: initialSeconds,
    limitSeconds: limitSeconds,
    onTimerStop: onTimerStop,
  ));
}

class _SmartTimerHook extends Hook<SmartTimer> {
  int initialSeconds;
  int limitSeconds;
  final void Function(int passedSecods) onTimerStop;

  _SmartTimerHook({
    this.initialSeconds = 0,
    required this.limitSeconds,
    required this.onTimerStop,
  });

  @override
  HookState<SmartTimer, Hook<SmartTimer>> createState() =>
      _SmartTimerHookState();
}

class _SmartTimerHookState extends HookState<SmartTimer, _SmartTimerHook> {
  late SmartTimer timer;

  @override
  void initHook() {
    super.initHook();
    timer = SmartTimer(
      limitSeconds: hook.limitSeconds,
      initialSeconds: hook.initialSeconds,
      onTimerStop: hook.onTimerStop,
    );
  }

  @override
  SmartTimer build(BuildContext context) {
    return timer;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

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
              onPressed: () {
                if (vm.habit.type == HabitType.time) {
                } else {
                  vm.perform();
                }
              },
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
