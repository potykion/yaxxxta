import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';
import 'package:yaxxxta/widgets/core/card.dart';
import 'package:yaxxxta/widgets/core/new_progress.dart';
import 'package:yaxxxta/widgets/core/padding.dart';

/// Контрол повторов выполнений привычки
class HabitProgressControl extends StatelessWidget {
  /// Вью-модель прогресса
  final HabitProgressVM vm;

  /// Событие инкремента привычки
  final void Function(
    double incrementValue,
    HabitProgressStatus progressStatus, [
    DateTime? dateTime,
  ])? onRepeatIncrement;

  /// Текст на карточке с повтором
  final Widget title;

  /// Начальная дата
  final DateTime? initialDate;

  /// Контрол повторов выполнений привычки
  const HabitProgressControl({
    required Key key,
    required this.vm,
    required this.onRepeatIncrement,
    required this.title,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ContainerCard(children: [
        ListTile(title: title, dense: true),
        SmallPadding(
          child: (vm.type == HabitType.repeats
              ? RepeatProgressControl(
                  initialValue: vm.currentValue,
                  goalValue: vm.goalValue,
                  onValueIncrement: (value, progressStatus, [dt]) =>
                      onRepeatIncrement != null
                          ? onRepeatIncrement!(value, progressStatus, dt)
                          : null,
                )
              : vm.type == HabitType.time
                  ? TimeProgressControl(
                      initialValue: vm.currentValue,
                      goalValue: vm.goalValue,
                      onValueIncrement: (value, progressStatus, [dt]) =>
                          onRepeatIncrement != null
                              ? onRepeatIncrement!(value, progressStatus, dt)
                              : null,
                      initialDate: initialDate,
                      notificationText: 'Привычка "${vm.title}" выполнена',
                    )
                  : null)!,
        ),
      ]);
}
