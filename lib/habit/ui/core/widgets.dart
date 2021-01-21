import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/new_progress.dart';
import '../../../core/ui/widgets/text.dart';
import '../../domain/models.dart';
import 'view_models.dart';

/// Контрол повторов выполнений привычки
class HabitProgressControl extends StatelessWidget {
  /// Вью-модель прогресса
  final HabitProgressVM vm;

  /// Событие инкремента привычки
  final void Function(
    double incrementValue,
    bool isCompleteOrExceeded, [
    DateTime dateTime,
  ]) onRepeatIncrement;

  /// Название на карточке с повтором
  final String repeatTitle;

  /// Начальная дата
  final DateTime initialDate;

  /// Контрол повторов выполнений привычки
  const HabitProgressControl({
    @required Key key,
    @required this.vm,
    @required this.onRepeatIncrement,
    this.repeatTitle,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddedContainerCard(children: [
      BiggerText(text: repeatTitle ?? vm.title),
      SizedBox(height: 5),
      if (vm.type == HabitType.repeats)
        RepeatProgressControl(
          initialValue: vm.currentValue,
          goalValue: vm.goalValue,
          onValueIncrement: (value, isCompleteOrExceeded, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(value, isCompleteOrExceeded, dt)
                  : null,
        ),
      if (vm.type == HabitType.time)
        TimeProgressControl(
          initialValue: vm.currentValue,
          goalValue: vm.goalValue,
          onValueIncrement: (value, isCompleteOrExceeded, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(value, isCompleteOrExceeded, dt)
                  : null,
          initialDate: initialDate,
        ),
    ]);
  }
}
