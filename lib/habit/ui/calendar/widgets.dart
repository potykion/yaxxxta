import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/time.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../../../settings/ui/core/deps.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/view_models.dart';
import '../core/widgets.dart';

class HabitCalendarPage_HabitProgressControl extends HookWidget {
  final int index;
  final HabitProgressVM vm;
  final Animation<double> animation;
  final bool removed;

  const HabitCalendarPage_HabitProgressControl({
    Key key,
    this.index,
    this.vm,
    this.animation,
    this.removed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var animatedListKey = useProvider(habitAnimatedListStateProvider);

    return FadeTransition(
      opacity: animation,
      child: GestureDetector(
        onTap: removed
            ? null
            : () async {
                context.read(selectedHabitIdProvider).state = vm.id;
                var deleted = await Navigator.of(context)
                        .pushNamed(Routes.details) as bool ??
                    false;
                if (deleted) {
                  animatedListKey.state.currentState.removeItem(
                    index,
                    (context, animation) =>
                        HabitCalendarPage_HabitProgressControl(
                      index: index,
                      vm: vm,
                      animation: animation,
                      removed: true,
                    ),
                    duration: Duration(milliseconds: 500),
                  );
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

                  var settings = context.read(settingsProvider).state;
                  var hideHabit = !settings.showCompleted &&
                          (progressStatus == HabitProgressStatus.complete ||
                              progressStatus == HabitProgressStatus.exceed) ||
                      !settings.showCompleted &&
                          (progressStatus == HabitProgressStatus.partial);

                  if (hideHabit) {
                    animatedListKey.state.currentState.removeItem(
                      index,
                      (context, animation) =>
                          HabitCalendarPage_HabitProgressControl(
                        index: index,
                        vm: vm,
                        animation: animation,
                        removed: true,
                      ),
                      duration: Duration(milliseconds: 500),
                    );
                  }
                },
          initialDate: context.read(selectedDateProvider).state,
        ),
      ),
    );
  }

  Future<DateTime> _computePerformDateTime(
    BuildContext context,
    DateTime initialDate,
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
