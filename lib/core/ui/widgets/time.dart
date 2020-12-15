import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimePickerInput extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var tec = useTextEditingController();

    return TextFormField(
      readOnly: true,
      onTap: () async {
        var selectedTime =
            await showTimePicker(context: context, initialTime: null);
      },
    );
  }
}
