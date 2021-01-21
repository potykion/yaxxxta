import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/new_progress.dart';
import '../../../core/ui/widgets/text.dart';
import '../../domain/models.dart';
import 'view_models.dart';

/// Контрол повторов выполнений привычки
class HabitRepeatControl extends StatelessWidget {
  /// ВМки повторов привычек
  final List<HabitRepeatVM> repeats;

  /// Начальный индекс повтора
  final int initialRepeatIndex;

  /// Событие инкремента привычки
  final void Function(
    int repeatIndex,
    double incrementValue,
    bool isCompleteOrExceeded, [
    DateTime dateTime,
  ]) onRepeatIncrement;

  /// Название на карточке с повтором
  final String repeatTitle;

  /// Функция, которая по повтору делает название на карточке с повтором
  final Widget Function(HabitRepeatVM repeat) repeatTitleBuilder;

  /// Начальная дата
  final DateTime initialDate;

  /// Контрол повторов выполнений привычки
  const HabitRepeatControl({
    @required Key key,
    @required this.repeats,
    @required this.onRepeatIncrement,
    this.initialRepeatIndex = 0,
    this.repeatTitle = "",
    this.repeatTitleBuilder,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repeat = repeats[0];
    return PaddedContainerCard(children: [
      BiggerText(text: repeatTitle),
      SizedBox(height: 5),
      if (repeat.type == HabitType.repeats)
        RepeatProgressControl(
          initialValue: repeat.currentValue,
          goalValue: repeat.goalValue,
          onValueIncrement: (value, isCompleteOrExceeded, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(0, value, isCompleteOrExceeded, dt)
                  : null,
        ),
      if (repeat.type == HabitType.time)
        TimeProgressControl(
          initialValue: repeat.currentValue,
          goalValue: repeat.goalValue,
          onValueIncrement: (value, isCompleteOrExceeded, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(0, value, isCompleteOrExceeded, dt)
                  : null,
          initialDate: initialDate,
        ),
    ]);
  }
}
