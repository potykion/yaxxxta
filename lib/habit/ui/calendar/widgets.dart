import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/dt.dart';
import '../../../deps.dart';
import '../../../routes.dart';
import '../../../widgets/core/time.dart';
import '../../domain/models.dart';
import '../core/view_models.dart';
import '../core/widgets.dart';

/// Контрол прогресса привычки для страницы календаря
// ignore: camel_case_types
class HabitCalendarPage_HabitProgressControl extends HookWidget {
  /// Индекс в списке
  final int index;

  /// Вм прогресса привычки
  final HabitProgressVM vm;

  /// Анимация при создании/удалении контрола
  final Animation<double> animation;

  /// Улален ли контрол
  final bool removed;

  /// Контрол прогресса привычки для страницы календаря
  const HabitCalendarPage_HabitProgressControl({
    Key? key,
    required this.index,
    required this.vm,
    required this.animation,
    this.removed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: animation,
        child: GestureDetector(
          onTap: removed
              ? null
              : () async {
                  context.read(selectedHabitIdProvider).state = vm.id;
                  var deleted = await Navigator.of(context)
                          .pushNamed(Routes.details) as bool? ??
                      false;
                  if (deleted) {
                    _removeSelf(context);
                  }
                },
          child: HabitProgressControl(
            key: Key(vm.id),
            repeatTitle: vm.performTime != null
                ? "${vm.performTimeStr}: ${vm.title}"
                : vm.title,
            vm: vm,
            onRepeatIncrement: removed
                ? null
                : (incrementValue, progressStatus, [date]) async {
                    context.read(habitPerformingController).insert(
                          HabitPerforming(
                            habitId: vm.id,
                            performValue: incrementValue,
                            performDateTime:
                                await _computePerformDateTime(context, date),
                          ),
                        );

                    var settings = context
                        .read(userDataControllerProvider.state)!
                        .settings;
                    var hideHabit = !settings.showCompleted &&
                            (progressStatus == HabitProgressStatus.complete ||
                                progressStatus == HabitProgressStatus.exceed) ||
                        !settings.showCompleted &&
                            (progressStatus == HabitProgressStatus.partial);

                    if (hideHabit) {
                      _removeSelf(context);
                    }
                  },
            initialDate: context.read(selectedDateProvider).state,
          ),
        ),
      );

  void _removeSelf(BuildContext context) {
    context.read(habitCalendarPage_AnimatedListState_Provider).removeItem(
          index,
          (_, animation) => HabitCalendarPage_HabitProgressControl(
            index: index,
            vm: vm,
            animation: animation,
            removed: true,
          ),
        );
  }

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
