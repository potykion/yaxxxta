import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/core/utils/dt.dart';

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
}