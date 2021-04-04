import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/core/fit_icon_button.dart';
import 'package:yaxxxta/widgets/core/padding.dart';
import 'package:yaxxxta/widgets/core/text.dart';

import '../../logic/core/utils/dt.dart';
import '../../logic/core/utils/list.dart';
import '../../routes.dart';
import '../core/time.dart';
import '../../logic/habit/models.dart';
import '../../logic/habit/view_models.dart';
import 'habit_progress_control.dart';

/// Контрол прогресса привычки для страницы календаря
// ignore: camel_case_types
class HabitCalendarPage_HabitProgressControl extends HookWidget {
  /// Привычка
  final Habit habit;

  /// Вм прогресса привычки
  final HabitProgressVM vm;

  /// Контрол прогресса привычки для страницы календаря
  const HabitCalendarPage_HabitProgressControl({
    Key? key,
    required this.vm,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showProgress = useState(!(vm.isComplete || vm.isExceeded));
    useValueChanged<bool, void>(vm.isComplete || vm.isExceeded, (_, __) {
      showProgress.value = !(vm.isComplete || vm.isExceeded);
    });

    var todayDateRange = useProvider(todayDateRangeProvider);

    return GestureDetector(
      onTap: () async {
        context.read(selectedHabitIdProvider).state = vm.id;
        await Navigator.of(context).pushNamed(Routes.details);
      },
      child: HabitProgressControl(
        key: Key(vm.id),
        title: Row(
          children: [
            BiggerText(
              text: vm.title,
              disabled: vm.isComplete || vm.isExceeded,
            ),
          ],
        ),
        subtitle: Row(
          children: [
            if (vm.performTime != null)
              SmallerText(text: "🔔 ${vm.performTimeStr}"),
            if (habit.stats.isPerformedLongAgo(todayDateRange))
              SmallerText(text: "Привычка давно не выполнялась!", error: true),
          ].joinObject(SmallerText(text: " · ")).toList(),
        ),
        trailing: vm.isComplete || vm.isExceeded
            ? FitIconButton(
                icon: Icon(
                  showProgress.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: CustomColors.almostBlack,
                ),
                onTap: () {
                  showProgress.value = !showProgress.value;
                },
              )
            : null,
        vm: vm,
        showProgress: showProgress.value,
        onRepeatIncrement: (incrementValue, progressStatus, [date]) async {
          context.read(habitPerformingController).insert(
                habit,
                HabitPerforming(
                  habitId: vm.id,
                  performValue: incrementValue,
                  performDateTime: await _computePerformDateTime(context, date),
                ),
              );
        },
        initialDate: context.read(selectedDateProvider).state,
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
