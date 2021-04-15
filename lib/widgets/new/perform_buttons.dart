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
  final void Function(int passedSecods)? onTimerUpdate;

  SmartTimer({
    this.initialSeconds = 0,
    required this.limitSeconds,
    required this.onTimerStop,
    this.onTimerUpdate,
  });

  bool get isActive => timer?.isActive ?? false;

  void toggle() {
    if (isActive) {
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
        if (onTimerUpdate != null) onTimerUpdate!(secondDiff);

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
  required void Function(int timerFreq) onTimerUpdate,
}) {
  return use(_SmartTimerHook(
    initialSeconds: initialSeconds,
    limitSeconds: limitSeconds,
    onTimerStop: onTimerStop,
    onTimerUpdate: onTimerUpdate,
  ));
}

class _SmartTimerHook extends Hook<SmartTimer> {
  int initialSeconds;
  int limitSeconds;
  final void Function(int passedSecods) onTimerStop;
  final void Function(int passedSecods)? onTimerUpdate;

  _SmartTimerHook({
    this.initialSeconds = 0,
    required this.limitSeconds,
    required this.onTimerStop,
    required this.onTimerUpdate,
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
      onTimerUpdate: hook.onTimerUpdate,
    );
  }

  @override
  SmartTimer build(BuildContext context) {
    return timer;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class HabitProgressButton extends HookWidget {
  final NewHabitVM vm;

  HabitProgressButton(this.vm);

  @override
  Widget build(BuildContext context) {
    var currentProgress = useState(vm.todayValue);
    SmartTimer timer = useSmartTimer(
      limitSeconds: vm.habit.goalValue.toInt(),
      initialSeconds: vm.todayValue.toInt(),
      onTimerStop: (performValue) {
        vm.perform(performValue.toDouble());
      },
      onTimerUpdate: (passed) {
        currentProgress.value += passed.toDouble();
      },
    );

    return Column(
      children: [
        Stack(
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
                  heroTag: null,

                  onPressed: () {
                    if (vm.habit.type == HabitType.time) {
                      timer.toggle();
                    } else {
                      vm.perform();
                    }
                  },
                  child: vm.habit.type == HabitType.time
                      ? timer.isActive ? Icon(Icons.pause) : Icon(Icons.play_arrow)
                      : vm.isOnePerformingLeft
                          ? Icon(Icons.done)
                          : Text(
                              "+1",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
          alignment: Alignment.center,
        ),
        SizedBox(height: 8),
        Text(vm.formatProgress(currentProgress.value)),
      ],
    );
  }
}
