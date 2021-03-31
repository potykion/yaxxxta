import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

void main() {
  test("DateRange.withinWeek", () {
    expect(
      DateRange.withinWeek(DateTime(2021, 3, 31)),
      DateRange(DateTime(2021, 3, 29), DateTime(2021, 4, 4)),
    );
  });

  test("DateRange.withinMonth", () {
    expect(
      DateRange.withinMonth(DateTime(2021, 3, 31)),
      DateRange(DateTime(2021, 3, 1), DateTime(2021, 3, 31)),
    );
  });

  test("DateRange.intersects", () {
    expect(
      DateRange.withinMonth(DateTime(2021, 3, 31))
          .intersects(DateRange(DateTime(2021, 3, 29), DateTime(2021, 4, 4))),
      true,
    );

    expect(
      DateRange.withinMonth(DateTime(2021, 3, 31))
          .intersects(DateRange(DateTime(2021, 4, 5), DateTime(2021, 4, 11))),
      false,
    );
  });

  test("DateRange.weeksFrom", () {
    expect(DateRange.withinMonth(DateTime(2021, 3, 31)).weeksFrom, 5);
    expect(DateRange.withinMonth(DateTime(2021, 2, 1)).weeksFrom, 4);
    expect(DateRange.withinMonth(DateTime(2020, 11, 1)).weeksFrom, 6);
  });
}
