import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/widgets/core/text.dart';

import '../../theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Чипы, описывающие свойства привычки: тип, периодичность, время выполнения
class HabitChips extends HookWidget {
  /// Привычка
  final Habit habit;

  /// Чипы, описывающие свойства привычки: тип, периодичность, время выполнения
  const HabitChips({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todayDateRange = useProvider(todayDateRangeProvider);

    return Wrap(
      spacing: 5,
      children: [
        if (habit.performTime != null)
          Chip(
            avatar: Icon(Icons.access_time),
            label: RegularText(formatTime(habit.performTime!)),
            backgroundColor: CustomColors.purple,
          ),
        Chip(
          label: RegularText(habit.type.verbose()),
          backgroundColor: CustomColors.blue,
        ),
        Chip(
          label: RegularText(habit.periodType.verbose()),
          backgroundColor: CustomColors.red,
        ),
        Chip(
          label: RegularText(
            "Текущий стрик: "
            "${habit.stats.computeTodayCurrentStrike(todayDateRange)}",
          ),
          backgroundColor: CustomColors.pink,
        ),
        Chip(
          label: RegularText("Максимальный стрик: ${habit.stats.maxStrike}"),
          backgroundColor: CustomColors.cyan,
        )
      ],
    );
  }
}
