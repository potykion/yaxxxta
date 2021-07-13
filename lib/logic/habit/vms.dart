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
      performings.any((hp) => hp.created.date() == DateTime.now().date());

  int get currentStrike {
    if (performings.isEmpty) return 0;

    var strike = 0;

    var performingDates = performings
        .map((p) => p.created.date())
        .toSet()
        .toList()
          ..sort((d1, d2) => -d1.compareTo(d2));

    var currentDate = DateTime.now().date();
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

  int get maxStrike {
    if (performings.isEmpty) return 0;

    var performingDates = performings
        .map((p) => p.created.date())
        .toSet()
        .toList()
          ..sort((d1, d2) => -d1.compareTo(d2));

    var maxStrike = 0;

    var currentDate = DateTime.now().date();
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
