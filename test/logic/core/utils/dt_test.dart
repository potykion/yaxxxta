import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/models.dart';

void main() {
  group("DateRange", () {
    test("DateTime.weekDateRange", () {
      var weekDateRange = DateTime(2020, 10, 26).weekDateRange;

      expect(weekDateRange.from, DateTime(2020, 10, 26));
      expect(weekDateRange.to, DateTime(2020, 11, 1));
      expect(weekDateRange.dates.length, 7);
    });

    test("DateRange.firstMonthDay", () {
      expect(
        DateTime(2020, 10, 26).weekDateRange.firstMonthDay,
        DateTime(2020, 11, 1),
      );
    });
  });

  group("TimeOfDay.toDateTime", () {
    /// Например. сейчас 2021-08-01 08:40, а тайм-ой-дей = 08:00 =>
    /// Функция вернет 2021-08-02 08:00
    test("Время < текущего ", () {
      var dt = TimeOfDay(hour: 8, minute: 0).toDateTime(
        now: DateTime(2021, 8, 1, 8, 40),
      );

      expect(dt, DateTime(2021, 8, 2, 8));
    });

    /// Например. сейчас 2021-08-01 (вс) 08:40, тайм-ой-дей = 08:00,
    /// день недели - вт =>
    /// Функция вернет 2021-08-03 (вт) 08:00
    test("Время < текущего + указан день недели", () {
      var dt = TimeOfDay(hour: 8, minute: 0).toDateTime(
        now: DateTime(2021, 8, 1, 8, 40),
        weekday: Weekday.Tuesday,
      );

      expect(dt, DateTime(2021, 8, 3, 8));
    });
  });
}
