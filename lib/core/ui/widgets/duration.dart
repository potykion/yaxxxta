import 'package:flutter/material.dart';
import 'package:yaxxxta/core/ui/widgets/padding.dart';
import '../../domain/models.dart';

import 'input.dart';

/// Инпут длительности
class DurationInput extends StatelessWidget {
  /// Начальное значение длительности
  final DoubleDuration initial;

  /// Событие изменения длительности
  final Function(DoubleDuration newDuration) change;

  /// Инпут длительности
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
          SmallPadding.between(),
          Expanded(
            child: TextInput<double>(
              suffix: Text("мин", textAlign: TextAlign.center),
              initial: initial.minutes,
              change: (dynamic m) =>
                  change(initial.copyWith(minutes: m as double)),
            ),
          ),
          SmallPadding.between(),
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
