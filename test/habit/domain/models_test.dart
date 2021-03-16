import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/habit/domain/models.dart';

void main() {
  group("nextPerformDateTime", () {
    test("HabitPeriodType.day", () {
      var habit = Habit(
        created: DateTime(2020, 1, 1),
        periodType: HabitPeriodType.day,
        performTime: DateTime(2020, 1, 1, 13, 00),
      );

      var performDateTime =
          habit.nextPerformDateTime(DateTime(2020, 1, 1, 13, 00)).first;

      expect(performDateTime, DateTime(2020, 1, 2, 13, 00));
    });

    test("HabitPeriodType.week", () {
      var habit = Habit(
        //  2020-01-01 - wednesday
        created: DateTime(2020, 1, 1),
        periodType: HabitPeriodType.week,
        performWeekdays: [Weekday.monday],
        performTime: DateTime(2020, 1, 1, 13, 00),
      );

      var performDateTime =
          habit.nextPerformDateTime(DateTime(2020, 1, 1, 13, 00)).first;

      // next monday
      expect(performDateTime, DateTime(2020, 1, 6, 13, 00));
    });

    test("HabitPeriodType.month", () {
      var habit = Habit(
        created: DateTime(2020, 1, 1),
        periodType: HabitPeriodType.month,
        performMonthDay: 22,
        performTime: DateTime(2020, 1, 1, 13, 00),
      );

      var performDateTime =
          habit.nextPerformDateTime(DateTime(2020, 1, 1, 13, 00)).first;

      expect(performDateTime, DateTime(2020, 1, 22, 13, 00));
    });
  });
}
