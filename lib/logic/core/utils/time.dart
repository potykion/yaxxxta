import 'package:flutter/material.dart';

extension TimeExtenstions on TimeOfDay {
  DateTime toDateTime() {
    var now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      this.hour,
      this.minute,
    );
  }
}
