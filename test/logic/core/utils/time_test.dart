import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/time.dart';
import 'package:yaxxxta/logic/habit/models.dart';

void main() {
  /// При вызове toDateTime с now = 2021-07-20 (вт) и weekday = Weekday.Wednesday,
  /// получать дейттайм в среду
  test("toDateTime", () {
    var dt = TimeOfDay(hour: 11, minute: 11).toDateTime(
      now: DateTime(2021, 7, 20),
      weekday: Weekday.Wednesday,
    );

    expect(dt.weekday, Weekday.Wednesday.index + 1);
  });
}
