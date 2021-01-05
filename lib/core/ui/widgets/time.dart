import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../theme.dart';
import '../../utils/dt.dart';

/// Выбор времени
class TimePickerInput extends HookWidget {
  /// Начальное значение времени
  final DateTime initial;

  /// Событие изменения времени
  final Function(DateTime time) change;

  /// Выбор времени
  TimePickerInput({this.initial, this.change});

  @override
  Widget build(BuildContext context) {
    var tec = useTextEditingController(
      text: initial != null ? formatTime(initial) : "",
    );

    return TextFormField(
      controller: tec,
      readOnly: true,
      onTap: () async {
        var selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initial ?? DateTime.now()),
        );
        var selectedTimeDateTime = DateTime(
          2020,
          1,
          1,
          selectedTime.hour,
          selectedTime.minute,
        );
        tec.text = formatTime(selectedTimeDateTime);
        change(selectedTimeDateTime);
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.access_time, color: CustomColors.almostBlack),
      ),
    );
  }
}
