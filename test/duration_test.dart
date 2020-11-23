import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/utils.dart';

main() {
  test("Форматирование дюрейшена", () {
    expect(
        formatDuration(Duration(hours: 1, minutes: 2, seconds: 3)), "1:02:03");
    expect(formatDuration(Duration(hours: 1)), "1:00:00");
    expect(formatDuration(Duration(minutes: 1)), "1:00");
    expect(formatDuration(Duration(seconds: 1)), "1");
  });
}
