import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/core/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/widgets/core/buttons.dart';
import 'package:yaxxxta/widgets/core/card.dart';
import 'package:yaxxxta/widgets/core/date.dart';
import 'package:yaxxxta/widgets/core/duration.dart';
import 'package:yaxxxta/widgets/core/input.dart';
import 'package:yaxxxta/widgets/core/padding.dart';
import 'package:yaxxxta/widgets/core/text.dart';
import 'package:yaxxxta/widgets/core/time.dart';

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
