import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/core/ui/widgets/date.dart';
import 'package:yaxxxta/core/ui/widgets/input.dart';
import 'package:yaxxxta/core/ui/widgets/padding.dart';
import 'package:yaxxxta/core/ui/widgets/time.dart';
import 'package:yaxxxta/core/utils/dt.dart';

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
    HabitProgressStatus progressStatus, [
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
          onValueIncrement: (value, progressStatus, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(value, progressStatus, dt)
                  : null,
        ),
      if (vm.type == HabitType.time)
        TimeProgressControl(
          initialValue: vm.currentValue,
          goalValue: vm.goalValue,
          onValueIncrement: (value, progressStatus, [dt]) =>
              onRepeatIncrement != null
                  ? onRepeatIncrement(value, progressStatus, dt)
                  : null,
          initialDate: initialDate,
          notificationText: 'Привычка "${vm.title}" выполнена',
        ),
    ]);
  }
}

class HabitPerformingFormModal extends HookWidget {
  final HabitPerforming initialHabitPerforming;

  final HabitType habitType;

  HabitPerformingFormModal({
    @required this.initialHabitPerforming,
    @required this.habitType,
  });

  @override
  Widget build(BuildContext context) {
    var vmState = useState(initialHabitPerforming);
    setVM(HabitPerforming newVM) {
      vmState.value = newVM;
    }

    var vm = vmState.value;

    return PaddedContainerCard(
      padVerticalOnly: true,
      children: [
        SmallPadding(
          child: BiggerText(text: "Дата и время выполнения"),
        ),
        ListTile(
          title: Row(
            children: [
              Flexible(
                child: DatePickerInput(
                  initial: vm.performDateTime,
                  change: (date) => setVM(
                    vm.copyWith(
                      performDateTime: buildDateTime(date, vm.performDateTime),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: TimePickerInput(
                  initial: vm.performDateTime,
                  change: (time) => setVM(
                    vm.copyWith(
                      performDateTime: buildDateTime(vm.performDateTime, time),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (habitType == HabitType.time) ...[
          SmallPadding(
            child: BiggerText(text: "Продолжительность"),
          ),
          TextInput<double>(
            initial: vm.performValue,
            change: (dynamic v) =>
                setVM(vm.copyWith(performValue: v as double)),
          ),
        ],
        if (habitType == HabitType.repeats) ...[
          SmallPadding(
            child: BiggerText(text: "Число повторений"),
          ),
          ListTile(
            title: TextInput<double>(
              initial: vm.performValue,
              change: (dynamic v) =>
                  setVM(vm.copyWith(performValue: v as double)),
            ),
          ),
        ],
        ListTile(
          title: SimpleButton(
            text: "Сохранить",
            onTap: () => Navigator.of(context).pop(vm),
          ),
        ),
      ],
    );
  }
}
