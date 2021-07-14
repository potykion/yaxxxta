import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

void main() {
  group("DateRange", () {
    test("DateTime.weekDateRange", () {
      var weekDateRange = DateTime(2020, 10, 26).weekDateRange;

      expect(weekDateRange.from,  DateTime(2020, 10, 26));
      expect(weekDateRange.to,  DateTime(2020, 11, 1));
      expect(weekDateRange.dates.length,  7);
    });

    test("DateRange.firstMonthDay", () {
      expect(
        DateTime(2020, 10, 26).weekDateRange.firstMonthDay,
        DateTime(2020, 11, 1),
      );
    });
  });


}
