import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../habit/domain/models.dart';

import '../../../theme.dart';
import '../../utils/dt.dart';
import '../deps.dart';
import 'text.dart';

typedef OnValueIncrement = void Function(double incrementValue,
    [DateTime datetime]);

/// Контрол прогресса проивычки
class HabitProgressControl extends StatelessWidget {
  /// Текущее значение прогресса
  final double currentValue;

  /// Желаемое значение прогресса
  final double goalValue;

  /// Событие изменения прогресса
  final OnValueIncrement onValueIncrement;

  /// Тип привычки
  /// В зависимости от него определяется тип прогресс-контрола
  final HabitType habitType;

  /// Начальная дата, нужно для _TimeProgressControl
  final DateTime initialDate;

  /// Контрол прогресса проивычки
  const HabitProgressControl({
    Key key,
    @required this.currentValue,
    @required this.goalValue,
    @required this.onValueIncrement,
    @required this.habitType,
    @required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => habitType == HabitType.repeats
      ? _RepeatProgressControl(
          initialValue: currentValue,
          goalValue: goalValue,
          onValueIncrement: onValueIncrement,
        )
      : _TimeProgressControl(
          initialValue: currentValue,
          goalValue: goalValue,
          onValueIncrement: onValueIncrement,
          initialDate: initialDate,
        );
}

class _RepeatProgressControl extends HookWidget {
  final double initialValue;
  final double goalValue;
  final OnValueIncrement onValueIncrement;

  _RepeatProgressControl({
    @required this.initialValue,
    @required this.goalValue,
    @required this.onValueIncrement,
  });

  @override
  Widget build(BuildContext context) {
    var currentValueState = useState(initialValue);
    useValueChanged<double, void>(
      initialValue,
      (_, __) => currentValueState.value = initialValue,
    );

    return _BaseProgressControl(
      incrementButton: GestureDetector(
        child: IconButton(
          splashRadius: 20,
          icon: Icon(Icons.done),
          onPressed: () {
            currentValueState.value += 1;
            onValueIncrement(1);
          },
        ),
        onLongPress: () {
          /// Если прогресс заполнен, то долгое нажатие ничо не делает
          if (currentValueState.value >= goalValue) return;

          /// Заполняем оставшийся прогресс иначе
          onValueIncrement(goalValue - currentValueState.value);
        },
      ),
      progressPercentage: min(currentValueState.value / goalValue, 1),
      progressStr: "${currentValueState.value.toInt()} / ${goalValue.toInt()}",
      showProgressStr: goalValue.toInt() != 1,
    );
  }
}

class _TimeProgressControl extends HookWidget {
  final double initialValue;
  final double goalValue;
  final OnValueIncrement onValueIncrement;
  final DateTime initialDate;

  _TimeProgressControl({
    @required this.initialValue,
    @required this.goalValue,
    @required this.onValueIncrement,
    @required this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    var timerState = useState<Timer>(null);

    var currentValueState = useState(initialValue);
    useValueChanged<double, void>(
      initialValue,
      (_, __) {
        currentValueState.value = initialValue;
      },
    );

    /// Вырубает таймер
    void _cancelTimer({
      DateTime oldDate,
      bool withResetTimer = true,
    }) {
      /// Если таймера нет, то нечего отменять
      if (timerState.value == null) return;

      /// Отключение таймера
      timerState.value.cancel();

      /// Обновляем прогресс
      onValueIncrement(currentValueState.value - initialValue, oldDate);

      /// Обнуление таймера вызывает перерисовку виджета,
      /// это не нужно делать, если мы покидаем страницу с виджетом
      if (withResetTimer) {
        /// Удаляем таймер, чтобы его можно было запустить заново
        timerState.value = null;
      }
    }

    /// При смене initialDate нужно сбросить таймер
    /// Актуально для списка привычек, где можно менять дату
    useValueChanged<DateTime, void>(
      initialDate,
      (oldDate, _) => _cancelTimer(oldDate: oldDate),
    );

    /// При выходе со страницы, на которой работает таймер - его нужно отрубать
    /// Пример: зашли на страницу деталей привычки, запустили таймер,
    /// а потом ушли оттуда - надо вырубить таймер
    useEffect(
      () => () => _cancelTimer(withResetTimer: false),
      [timerState],
    );

    var currentValueDuration =
        Duration(seconds: currentValueState.value.toInt()).format();
    var goalValueDuration = Duration(seconds: goalValue.toInt()).format();
    var progressStr = "$currentValueDuration / $goalValueDuration";

    return _BaseProgressControl(
      progressStr: progressStr,
      progressPercentage: min(currentValueState.value / goalValue, 1),
      incrementButton: GestureDetector(
        child: IconButton(
          splashRadius: 20,
          icon: (timerState.value?.isActive ?? false)
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
          disabledColor: CustomColors.almostBlack,
          onPressed: () {
            if (timerState.value?.isActive ?? false) {
              _cancelTimer();
            } else {
              var timerStart = DateTime.now();

              timerState.value = Timer.periodic(
                Duration(seconds: 1),
                (timer) {
                  var currentTime = DateTime.now();
                  var secondDiff =
                      (currentTime.difference(timerStart).inMilliseconds / 1000)
                          .round();

                  currentValueState.value += secondDiff;
                  timerStart = currentTime;

                  if (currentValueState.value.toInt() == goalValue.toInt()) {
                    _cancelTimer();
                    context
                        .read(notificationSender)
                        .send(title: "Привычка выполнена");
                  }
                },
              );
            }
          },
        ),
        onLongPress: () {
          /// Если таймер запущен, то долгое нажатие ничо не делает
          if (timerState.value?.isActive ?? false) return;

          /// Если прогресс заполнен, то долгое нажатие ничо не делает
          if (currentValueState.value >= goalValue) return;

          /// Заполняем оставшийся прогресс иначе
          onValueIncrement(goalValue - currentValueState.value);
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
