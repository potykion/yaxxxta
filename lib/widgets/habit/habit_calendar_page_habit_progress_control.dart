import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

import '../../logic/core/utils/dt.dart';
import '../../routes.dart';
import '../core/time.dart';
import '../../logic/habit/models.dart';
import '../../logic/habit/view_models.dart';
import 'habit_progress_control.dart';

/// Контрол прогресса привычки для страницы календаря
// ignore: camel_case_types
class HabitCalendarPage_HabitProgressControl extends HookWidget {
  /// Индекс в списке
  final int index;

  /// Вм прогресса привычки
  final HabitProgressVM vm;

  /// Контрол прогресса привычки для страницы календаря
  const HabitCalendarPage_HabitProgressControl({
    Key? key,
    required this.index,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          context.read(selectedHabitIdProvider).state = vm.id;
          await Navigator.of(context).pushNamed(Routes.details);
        },
        child: HabitProgressControl(
          key: Key(vm.id),
          repeatTitle: vm.performTime != null
              ? "${vm.performTimeStr}: ${vm.title}"
              : vm.title,
          vm: vm,
          onRepeatIncrement: (incrementValue, progressStatus, [date]) async {
            context.read(habitPerformingController).insert(
                  HabitPerforming(
                    habitId: vm.id,
                    performValue: incrementValue,
                    performDateTime:
                        await _computePerformDateTime(context, date),
                  ),
                );
          },
          initialDate: context.read(selectedDateProvider).state,
        ),
      );

  Future<DateTime> _computePerformDateTime(
    BuildContext context,
    DateTime? initialDate,
  ) async {
    var performDate = initialDate ?? context.read(selectedDateProvider).state;

    /// Если выбранная дата не сегодня,
    /// то выбираем в какое время хотим добавить
    /// выполнение привычки за другую дату
    var performTime = DateTime.now();
    if (!performDate.isToday()) {
      performTime = (await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(performTime),
          ))
              ?.toDateTime() ??
          performTime;
    }

    return buildDateTime(performDate, performTime);
  }
}
