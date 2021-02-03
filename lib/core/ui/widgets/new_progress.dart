import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../habit/ui/core/view_models.dart';

import '../../../theme.dart';
import '../../utils/dt.dart';
import '../deps.dart';
import 'text.dart';

/// Событие изменения значения
typedef OnValueIncrement = void Function(
    double incrementValue, HabitProgressStatus progressStatus,
    [DateTime datetime]);

/// Контролл прогресса на повторы
class RepeatProgressControl extends HookWidget {
  /// Начальное значение
  final double initialValue;

  /// Целевое значение
  final double goalValue;

  /// Событие изменения значения
  final OnValueIncrement onValueIncrement;

  /// Контролл прогресса на повторы
  RepeatProgressControl({
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
            onValueIncrement(
              1,
              buildHabitProgressStatus(currentValueState.value, goalValue),
            );
          },
        ),
        onLongPress: () {
          /// Если прогресс заполнен, то долгое нажатие ничо не делает
          if (currentValueState.value >= goalValue) return;

          /// Заполняем оставшийся прогресс иначе
          onValueIncrement(
            goalValue - currentValueState.value,
            HabitProgressStatus.complete,
          );
        },
      ),
      progressPercentage: min(currentValueState.value / goalValue, 1),
      progressStr: "${currentValueState.value.toInt()} / ${goalValue.toInt()}",
      showProgressStr: goalValue.toInt() != 1,
    );
  }
}

/// Контролл прогресса на время
class TimeProgressControl extends HookWidget {
  /// Начальное значение
  final double initialValue;

  /// Целевое значение
  final double goalValue;

  /// Событие изменения значения
  final OnValueIncrement onValueIncrement;

  /// Начальная дата
  final DateTime initialDate;

  /// Текст уведомления о выполнении привычки
  final String notificationText;

  /// Контролл прогресса на время
  TimeProgressControl({
    @required this.initialValue,
    @required this.goalValue,
    @required this.onValueIncrement,
    @required this.initialDate,
    this.notificationText = "Привычка выполнена",
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

    var notificationId = useValueNotifier<int>(null, []);

    /// Вырубает таймер
    void _cancelTimer({
      DateTime oldDate,
      bool withResetTimer = true,
      bool withCancelNotification = false,
    }) {
      /// Если таймера нет, то нечего отменять
      if (timerState.value == null) return;

      /// Отключение таймера
      timerState.value.cancel();

      /// Отменяем уведомление, если withCancelNotification = true
      if (withCancelNotification && notificationId.value != null) {
        context.read(notificationSender).cancel(notificationId.value);
      }

      /// Обновляем прогресс = разницы между текущим значение таймера
      /// и начальным
      onValueIncrement(
        currentValueState.value - initialValue,
        buildHabitProgressStatus(currentValueState.value, goalValue),
        oldDate,
      );

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
      (oldDate, _) => _cancelTimer(
        oldDate: oldDate,
        withCancelNotification: true,
      ),
    );

    /// При выходе со страницы, на которой работает таймер - его нужно отрубать
    /// Пример: зашли на страницу деталей привычки, запустили таймер,
    /// а потом ушли оттуда - надо вырубить таймер
    useEffect(
      () => () => _cancelTimer(
            withResetTimer: false,
            withCancelNotification: true,
          ),
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
          onPressed: () async {
            if (timerState.value?.isActive ?? false) {
              _cancelTimer(withCancelNotification: true);
            } else {
              var timerStart = DateTime.now();

              /// Создаем уведомление о завершении таймера
              /// через кол-во сек до цели
              if (currentValueState.value < goalValue) {
                notificationId.value =
                    await context.read(notificationSender).schedule(
                          title: notificationText,
                          sendAfterSeconds:
                              (goalValue - currentValueState.value).toInt(),
                        );
              }

              timerState.value = Timer.periodic(
                /// 250 мс для быстрой перерисовки
                Duration(milliseconds: 250),
                (_) {
                  var currentTime = DateTime.now();

                  /// Обновление прогресса = timerStart - currentTime, а не 1 с.
                  /// Потому что андроид может застопить апп, в тч таймер =>
                  /// Надо прогресс обновлять по разнице во времени
                  var millisecondDiff =
                      currentTime.difference(timerStart).inMilliseconds;

                  /// Если секунда не прошла => скипаем обновление
                  /// 900 мс потому что таймер тикает с погрешностью
                  if (millisecondDiff < 900) {
                    return;
                  }

                  var secondDiff = (millisecondDiff / 1000).round();
                  timerStart = currentTime;

                  currentValueState.value += secondDiff;

                  if (currentValueState.value.toInt() == goalValue.toInt()) {
                    _cancelTimer();
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
          onValueIncrement(
            goalValue - currentValueState.value,
            HabitProgressStatus.complete,
          );
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
