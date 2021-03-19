import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import '../../theme.dart';

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
