import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/widgets/core/buttons.dart';

import '../../../core/domain/models.dart';
import '../../../core/utils/dt.dart';
import '../../../../theme.dart';
import '../../../../widgets/core/card.dart';
import '../../../../widgets/core/date.dart';
import '../../../../widgets/core/duration.dart';
import '../../../../widgets/core/input.dart';
import '../../../../widgets/core/new_progress.dart';
import '../../../../widgets/core/padding.dart';
import '../../../../widgets/core/text.dart';
import '../../../../widgets/core/time.dart';
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
    DateTime? dateTime,
  ])? onRepeatIncrement;

  /// Название на карточке с повтором
  final String? repeatTitle;

  /// Начальная дата
  final DateTime? initialDate;

  /// Контрол повторов выполнений привычки
  const HabitProgressControl({
    required Key key,
    required this.vm,
    required this.onRepeatIncrement,
    this.repeatTitle,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ContainerCard(children: [
        ListTile(title: BiggerText(text: repeatTitle ?? vm.title), dense: true),
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

/// Модалька выполнения привычки
class HabitPerformingFormModal extends HookWidget {
  /// Начальное выполнение привычки
  final HabitPerforming initialHabitPerforming;

  /// Тип привычки
  /// Используется чтобы показывать "Число повторений" / "Продолжительность"
  final HabitType habitType;

  /// Модалька выполнения привычки
  HabitPerformingFormModal({
    required this.initialHabitPerforming,
    required this.habitType,
  });

  @override
  Widget build(BuildContext context) {
    var vmState = useState(initialHabitPerforming);
    setVM(HabitPerforming newVM) {
      vmState.value = newVM;
    }

    var vm = vmState.value;

    return ContainerCard(
      children: [
        ListTile(
          title: BiggerText(text: "Дата и время выполнения"),
          dense: true,
        ),
        SmallPadding(
            child: Row(
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
            SmallPadding.between(),
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
        )),
        if (habitType == HabitType.time) ...[
          ListTile(title: BiggerText(text: "Продолжительность"), dense: true),
          SmallPadding(
            child: DurationInput(
              initial: DoubleDuration.fromSeconds(vm.performValue),
              change: (newDuration) =>
                  setVM(vm.copyWith(performValue: newDuration.asSeconds)),
            ),
          ),
        ],
        if (habitType == HabitType.repeats) ...[
          ListTile(title: BiggerText(text: "Число повторений"), dense: true),
          SmallPadding(
            child: TextInput<double>(
              initial: vm.performValue,
              change: (dynamic v) =>
                  setVM(vm.copyWith(performValue: v as double)),
            ),
          ),
        ],
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SmallPadding(
            child: FullWidthButton(
              onPressed: () => Navigator.of(context).pop(vm),
              child: BiggerText(text: "Сохранить"),
            ),
          ),
        ),
      ],
    );
  }
}

/// Чипы, описывающие свойства привычки: тип, периодичность, время выполнения
class HabitChips extends StatelessWidget {
  /// Привычка
  final Habit habit;

  /// Чипы, описывающие свойства привычки: тип, периодичность, время выполнения
  const HabitChips({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        Chip(
          label: Text(habit.type.verbose()),
          backgroundColor: CustomColors.blue,
        ),
        Chip(
          label: Text(habit.periodType.verbose()),
          backgroundColor: CustomColors.red,
        ),
        if (habit.performTime != null)
          Chip(
            avatar: Icon(Icons.access_time),
            label: Text(formatTime(habit.performTime!)),
            backgroundColor: CustomColors.purple,
          ),
      ],
    );
  }
}
