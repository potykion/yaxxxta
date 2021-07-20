import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/models.dart';

extension TimeExtenstions on TimeOfDay {
  DateTime toDateTime({DateTime? now, Weekday? weekday}) {
    now = now ?? DateTime.now();

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

    if (weekday != null) {
      while (true) {
        if (dt.weekday == weekday.index + 1) {
          break;
        }
        dt = dt.add(Duration(days: 1));
      }
    }

    return dt;
  }
}
