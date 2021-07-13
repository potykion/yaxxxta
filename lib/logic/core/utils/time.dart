import 'package:flutter/material.dart';

extension TimeExtenstions on TimeOfDay {
  DateTime toDateTime() {
    var now = DateTime.now();

    var dt = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (dt.isBefore(now)) {
      dt = dt.add(Duration(days: 1));
    }

    return dt;
  }
}
