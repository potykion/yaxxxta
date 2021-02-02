import 'package:flutter/material.dart';
import 'package:yaxxxta/core/domain/models.dart';

import 'input.dart';

class DurationInput extends StatelessWidget {
  final DoubleDuration initial;
  final Function(DoubleDuration newDuration) change;

  const DurationInput({
    Key key,
    this.initial,
    this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: TextInput<double>(
              suffix: Text("ч", textAlign: TextAlign.center),
              initial: initial.hours,
              change: (dynamic h) =>
                  change(initial.copyWith(hours: h as double)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextInput<double>(
              suffix: Text("мин", textAlign: TextAlign.center),
              initial: initial.minutes,
              change: (dynamic m) =>
                  change(initial.copyWith(minutes: m as double)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextInput<double>(
              suffix: Text("сек", textAlign: TextAlign.center),
              initial: initial.seconds,
              change: (dynamic s) =>
                  change(initial.copyWith(seconds: s as double)),
            ),
          ),
        ],
      );
}
