import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

part 'vms.freezed.dart';

@freezed
abstract class HabitVM implements _$HabitVM {
  const HabitVM._();

  const factory HabitVM({
    required Habit habit,
    @Default(<HabitPerforming>[]) List<HabitPerforming> performings,
  }) = _HabitVM;

  bool get isPerformedToday =>
      performings.any((hp) => hp.created.date == DateTime.now().date);

  int get currentRecord {
    switch (habit.frequencyType) {
      case HabitFrequencyType.daily:
        return ComputeStatsForDailyHabit(habit, performings).currentRecord;
      case HabitFrequencyType.weekly:
        return ComputeStatsForWeeklyHabit(habit, performings).currentRecord;
    }
  }

  int get maxRecord {
    switch (habit.frequencyType) {
      case HabitFrequencyType.daily:
        return ComputeStatsForDailyHabit(habit, performings).maxRecord;
      case HabitFrequencyType.weekly:
        return ComputeStatsForWeeklyHabit(habit, performings).maxRecord;
    }
  }
}

class ComputeStatsForWeeklyHabit extends ComputeStats {
  ComputeStatsForWeeklyHabit(Habit habit, List<HabitPerforming> performings)
      : super(habit, performings);

  @override
  int get currentRecord {
    if (performings.isEmpty) return 0;

    var record = 0;

    var performingDates = performings
        .map((p) => p.created.date)
        .toSet()
        .toList()
          ..sort((d1, d2) => -d1.compareTo(d2));
    var performingWeeks =
        groupBy<DateTime, DateRange>(performingDates, (pd) => pd.weekDateRange)
            .keys;

    var currentDate = DateTime.now();
    var currentWeek = currentDate.weekDateRange;

    if (performingWeeks.contains(currentWeek)) {
    } else {
      currentWeek = currentWeek.previous;
    }

    while (true) {
      if (performingWeeks.contains(currentWeek)) {
        record += 1;
      } else {
        break;
      }

      currentWeek = currentWeek.previous;
    }

    return record;
  }

  @override
  int get maxRecord {
    if (performings.isEmpty) return 0;

    var record = 0;
    var maxRecord_ = 0;

    var performingDates = performings
        .map((p) => p.created.date)
        .toSet()
        .toList()
          ..sort((d1, d2) => d1.compareTo(d2));
    var performingWeeks =
        groupBy<DateTime, DateRange>(performingDates, (pd) => pd.weekDateRange)
            .keys;
    var firstWeek = performingWeeks.first;

    var currentDate = DateTime.now();
    var currentWeek = currentDate.weekDateRange;

    while (true) {
      if (performingWeeks.contains(currentWeek)) {
        record += 1;
        maxRecord_ = max(maxRecord_, record);
      } else {
        record = 0;
      }

      if (firstWeek == currentWeek) break;

      currentWeek = currentWeek.previous;
    }

    return maxRecord_;
  }
}

abstract class ComputeStats {
  final Habit habit;
  final List<HabitPerforming> performings;

  ComputeStats(this.habit, this.performings);

  int get currentRecord;

  int get maxRecord;
}

class ComputeStatsForDailyHabit extends ComputeStats {
  ComputeStatsForDailyHabit(Habit habit, List<HabitPerforming> performings)
      : super(habit, performings);

  @override
  int get currentRecord {
    if (performings.isEmpty) return 0;

    var strike = 0;

    var performingDates = performings
        .map((p) => p.created.date)
        .toSet()
        .toList()
          ..sort((d1, d2) => -d1.compareTo(d2));

    var currentDate = DateTime.now().date;
    if (performingDates.first == currentDate) {
      strike += 1;
      performingDates.removeAt(0);
    }
    currentDate = currentDate.subtract(Duration(days: 1));

    for (var date in performingDates) {
      if (date == currentDate) {
        strike += 1;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    return strike;
  }

  @override
  // TODO: implement maxRecord
  int get maxRecord {
    if (habit.frequencyType == HabitFrequencyType.weekly) return 0;

    if (performings.isEmpty) return 0;

    var performingDates = performings
        .map((p) => p.created.date)
        .toSet()
        .toList()
          ..sort((d1, d2) => -d1.compareTo(d2));

    var maxStrike = 0;

    var currentDate = DateTime.now().date;
    while (true) {
      if (performingDates.first == currentDate) break;
      currentDate = currentDate.subtract(Duration(days: 1));
    }
    var currentStrike = 0;

    for (var date in performingDates) {
      if (date == currentDate) {
        currentStrike += 1;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        currentStrike = 1;
        currentDate = date.subtract(Duration(days: 1));
      }
      maxStrike = max(maxStrike, currentStrike);
    }

    return maxStrike;
  }
}
