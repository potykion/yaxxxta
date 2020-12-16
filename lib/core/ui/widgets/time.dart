import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/theme.dart';

class TimePickerInput extends HookWidget {
  final DateTime initial;
  final Function(DateTime time) change;

  TimePickerInput({this.initial, this.change});

  @override
  Widget build(BuildContext context) {
    var tec = useTextEditingController(text: formatTime(initial));

    return TextFormField(
      controller: tec,
      readOnly: true,
      onTap: () async {
        var selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initial),
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
