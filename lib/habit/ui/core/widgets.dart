import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/new_progress.dart';
import '../../../core/ui/widgets/text.dart';
import 'view_models.dart';

/// Контрол повторов выполнений привычки
class HabitRepeatControl extends StatelessWidget {
  /// ВМки повторов привычек
  final List<HabitRepeatVM> repeats;

  /// Начальный индекс повтора
  final int initialRepeatIndex;

  /// Событие инкремента привычки
  final void Function(int repeatIndex, double incrementValue,
      [DateTime dateTime]) onRepeatIncrement;

  /// Название на карточке с повтором
  final String repeatTitle;

  /// Функция, которая по повтору делает название на карточке с повтором
  final Widget Function(HabitRepeatVM repeat) repeatTitleBuilder;

  final DateTime initialDate;

  /// Контрол повторов выполнений привычки
  const HabitRepeatControl({
    Key key,
    @required this.repeats,
    @required this.onRepeatIncrement,
    this.initialRepeatIndex = 0,
    this.repeatTitle = "",
    this.repeatTitleBuilder,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          // minHeight: 130,
          maxHeight: 155,
        ),
        child: PaddedContainerCard(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Flexible(child: BiggerText(text: repeatTitle)),
            ],
          ),
          SizedBox(height: 5),
          HabitProgressControl(
            habitType: repeats[0].type,
            currentValue: repeats[0].currentValue,
            goalValue: repeats[0].goalValue,
            onValueIncrement: (value, [dt]) =>
                onRepeatIncrement(0, value, dt),
            initialDate: initialDate,
          )
        ]),
      );
}
