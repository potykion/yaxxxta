import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/core/utils/num.dart';

void main() {
  test("Форматирование дюрейшена", () {
    expect(
        formatDuration(Duration(hours: 1, minutes: 2, seconds: 3)), "1:02:03");
    expect(formatDuration(Duration(hours: 1)), "1:00:00");
    expect(formatDuration(Duration(minutes: 1)), "1:00");
    expect(formatDuration(Duration(seconds: 1)), "1");
  });

  test("Флрматирование дабла", () {
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
}
