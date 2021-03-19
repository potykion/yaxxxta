import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/core/utils/num.dart';

void main() {
  test("Форматирование дюрейшена", () {
    expect(Duration(hours: 1, minutes: 2, seconds: 3).format(), "01:02:03");
    expect(Duration(hours: 1).format(), "01:00:00");
    expect(Duration(minutes: 1).format(), "01:00");
    expect(Duration(seconds: 1).format(), "00:01");
  });

  test("Форматирование дабла", () {
    expect(formatDouble(1.0), "1");
    expect(formatDouble(1), "1");
    expect(formatDouble(10), "10");
    expect(formatDouble(1.01), "1.01");
    expect(formatDouble(2.20), "2.2");
    expect(formatDouble(3.5545), "3.55");
  });

  test("Конец месяца", () {
    expect(endOfMonth(DateTime(2020, 11, 1)), 30);
    expect(endOfMonth(DateTime(2020, 12, 1)), 31);
  });

  test("Номер недели", () {
    expect(yearWeekNum(DateTime(2020, 1, 1)), 1);
    expect(yearWeekNum(DateTime(2020, 1, 8)), 2);
    expect(yearWeekNum(DateTime(2020, 12, 31)), 53);
    expect(yearWeekNum(DateTime(2020, 12, 24)), 52);
    expect(yearWeekNum(DateTime(2020, 12, 22)), 52);
  });

  test("Номер дня", () {
    expect(yearDayNum(DateTime(2020, 1, 1)), 1);
    expect(yearDayNum(DateTime(2020, 1, 8)), 8);
  });

  test("DateRange.fromDateAndTimes", () {
    expect(
      DateRange.fromDateAndTimes(
        DateTime(2020, 1, 1),
        DateTime(2020, 1, 1, 11),
        DateTime(2020, 1, 1, 23),
      ),
      DateRange(DateTime(2020, 1, 1, 11), DateTime(2020, 1, 1, 23)),
    );

    expect(
      DateRange.fromDateAndTimes(
        DateTime(2020, 1, 1),
        DateTime(2020, 1, 1, 11),
        DateTime(2020, 1, 1, 00),
      ),
      DateRange(DateTime(2020, 1, 1, 11), DateTime(2020, 1, 2, 00)),
    );

    expect(
      DateRange.fromDateAndTimes(
        DateTime(2020, 1, 1),
        DateTime(2020, 1, 1, 11),
        DateTime(2020, 1, 1, 01),
      ),
      DateRange(DateTime(2020, 1, 1, 11), DateTime(2020, 1, 2, 01)),
    );
  });
}
