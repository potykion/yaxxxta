import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';

class NewHabitVM {
  final BuildContext context;
  final Habit habit;
  final List<HabitPerforming> todayPerformings;
  final List<HabitPerforming> allPerformings;

  NewHabitVM({
    required this.context,
    required this.habit,
    required this.todayPerformings,
    required this.allPerformings,
  });

  double get todayValue => todayPerformings.isEmpty
      ? 0
      : todayPerformings
          .map((hp) => hp.performValue)
          .reduce((v1, v2) => v1 + v2);

  bool get isOnePerformingLeft => todayValue == 0 && habit.goalValue == 1;

  bool get isMultiplePerformingsLeft =>
      habit.goalValue > 1 && habit.goalValue != todayValue;

  Map<DateTime, double> get highlights => Map.fromEntries(
        allPerformings.map(
          (hp) => MapEntry(hp.performDateTime.date(), 1.0),
        ),
      );

  String formatProgress(double progress) {
    if (habit.type == HabitType.time) {
      var currentValueDuration = Duration(seconds: progress.toInt()).format();
      var goalValueDuration =
          Duration(seconds: habit.goalValue.toInt()).format();
      var progressStr = "$currentValueDuration / $goalValueDuration";
      return progressStr;
    } else {
      return "${progress.toInt()} / ${habit.goalValue.toInt()}";
    }
  }

  void perform([double performValue = 1]) {
    context
        .read(newHabitPerformingControllerProvider.notifier)
        .perform(habit, performValue);
  }

  void performFull() {
    perform(habit.goalValue - todayValue);
  }
}
